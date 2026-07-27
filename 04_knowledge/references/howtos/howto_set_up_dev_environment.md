---
title: How-to — Set Up the Dev Environment
tags: [knowledge, reference, howto, onboarding]
created: 2026-06-02
updated: 2026-08-21
source: internal onboarding page, plus the two days it actually took me
---

# How-to — Set Up the Dev Environment

Getting a fresh Windows work laptop ready to build and run [[paneflow]] locally.

## Why it matters here

The official onboarding page is four steps long and takes half a day. This is the version with
the parts that are missing from it. I wrote it while setting up the machine for the second-year
apprentice starting in September, so it has been run through once end to end.

Budget a full day. Steps 7 and 9 are where everyone loses their afternoon.

## Steps

1. **Get access.** Ask [[nils_putty]] for: the AD account, GitLab access to `paneflow` and
   `paneflow-optimizer`, the VPN profile, and the licence key for Rider. All five, in one
   message — asking for them one at a time takes a week.

2. **Install the basics.** `winget` is the package manager that ships with Windows. `-e` means
   "exact ID", without it winget matches loosely and installs something adjacent.

   ```powershell
   winget install --id Git.Git -e
   winget install --id Microsoft.PowerShell -e        # PowerShell 7, next to the built-in 5.1
   winget install --id Microsoft.WindowsTerminal -e
   winget install --id Docker.DockerDesktop -e
   winget install --id JetBrains.Toolbox -e
   winget install --id jqlang.jq -e
   ```

   Then **close the terminal and open a new one.** Installers extend `PATH`, and a running
   terminal keeps its own copy of the environment — see [[terminal_cheatsheet]] § Environment.
   Half the "winget did not install it" reports are this.

3. **Install the .NET SDK.** We are on .NET 8 (LTS) and `global.json` pins the feature band, so
   a newer SDK will refuse to build.

   ```powershell
   winget install --id Microsoft.DotNet.SDK.8 -e
   dotnet --list-sdks          # an 8.0.4xx must be in the list
   ```

   Visual Studio installs its own SDK copies, so the list can be long. `global.json` decides
   which one wins; `dotnet --version` **inside the repo folder** tells you which one that is.

4. **Install an IDE.** Rider through JetBrains Toolbox with the key from step 1, or Visual
   Studio 2022 — the team is split and both build the solution.

   ```powershell
   winget install --id Microsoft.VisualStudio.2022.Professional -e --override `
     "--add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.ManagedDesktop --passive"
   ```

   The `--override` passes arguments straight to the Visual Studio installer. Without it you get
   Visual Studio with no workloads — it opens, it cannot build, and nothing says why.

   If you use both IDEs, agree on one formatting configuration in the repository. Otherwise every
   save reformats the file and your first pull request is 300 lines of whitespace.

5. **Configure git.**

   ```powershell
   git config --global user.name "Robin Sill"
   git config --global user.email robin.sill@panerelief.example
   git config --global pull.rebase true
   git config --global init.defaultBranch main
   git config --global core.longpaths true
   ```

   `core.longpaths` is not optional here. Windows paths stop at 260 characters by default, and
   `src\PaneFlow.Optimizer\bin\Debug\net8.0\...` gets there. Without it a clone fails halfway
   with "filename too long".

   Git for Windows also installs Git Credential Manager, so the first `git push` opens a browser
   for the GitLab login instead of asking for a password on the command line.

   **Line endings — read this before you set `core.autocrlf`.**
   Windows editors end lines with CRLF (`\r\n`), git and Linux want LF (`\n`). Left alone, the
   difference shows up as a diff on every line of a file nobody touched.

   `core.autocrlf` is the old fix, set per machine:

   | Value | On checkout | On commit |
   |---|---|---|
   | `true` | LF becomes CRLF | CRLF becomes LF |
   | `input` | unchanged | CRLF becomes LF |
   | `false` | unchanged | unchanged |

   The Git for Windows installer offers `true` and most people click through it. It works, but it
   is the wrong layer: it is a setting on **your** laptop, and it has to be right on **everyone's**
   laptop. One colleague with `false` commits CRLF into the repository, and from then on every
   change to that file looks like a rewrite for the rest of the team.

   The better fix is a `.gitattributes` file committed in the repository:

   ```gitattributes
   * text=auto eol=lf
   *.png binary
   ```

   `text=auto` lets git decide per file whether it is text; `eol=lf` stores LF in the repository.
   It travels with the clone, so it applies to every machine and every new colleague without
   anyone configuring anything, and it wins over `core.autocrlf` where the two disagree. This
   vault's own repository has exactly that file at its root — read `.gitattributes` there, the
   comment in it says the same thing in three lines.

   With a `.gitattributes` in place, leave `core.autocrlf` unset. Setting both is not harmful,
   but it makes the behaviour a puzzle when something does go wrong.

   Adding `.gitattributes` to a repository that already has CRLF committed does not fix the old
   files. Renormalise them once:

   ```powershell
   git add --renormalize .
   git commit -m "Normalise line endings"
   ```

6. **Connect the VPN** with the profile from step 1. Everything internal — GitLab, the NuGet
   feed, staging — is only reachable through it.

7. **Clone and restore.** ← *first thing that goes wrong*

   ```powershell
   New-Item -ItemType Directory C:\dev -Force
   Set-Location C:\dev
   git clone git@gitlab.internal:paneflow/paneflow.git
   Set-Location paneflow
   dotnet restore
   ```

   Clone to `C:\dev`, not into `Documents`. The path limit from step 5 counts the whole path, and
   a deep home folder spends 60 characters before the repository even starts.

   For the SSH clone you need the key loaded. The agent service is disabled on a fresh Windows
   install, and the first two commands need an elevated terminal, once:

   ```powershell
   Get-Service ssh-agent | Set-Service -StartupType Automatic
   Start-Service ssh-agent
   ssh-add $env:USERPROFILE\.ssh\id_ed25519
   ```

   `dotnet restore` will fail with `401 Unauthorized` from the internal package feed. Two causes,
   both of them normal:

   - The feed credentials are not in the repo. Copy `nuget.config.template` to `nuget.config`
     (it is git-ignored) and put a GitLab personal access token with `read_api` in it.
   - The VPN certificate expires every 90 days. When it does, the symptom is not "VPN broken",
     it is this same 401 — because the feed simply is not reachable and the proxy answers
     instead. Check with `curl.exe -I https://nuget.internal/v3/index.json` before debugging
     NuGet. The `.exe` matters: plain `curl` in Windows PowerShell 5.1 is an alias for
     `Invoke-WebRequest` and ignores `-I`.

8. **Set up Docker with the WSL2 backend.** WSL2 (Windows Subsystem for Linux, version 2) is a
   real Linux kernel in a lightweight VM. Docker Desktop uses it to run Linux containers, and our
   SQL Server image is a Linux one.

   ```powershell
   wsl --install         # elevated terminal, then reboot
   wsl --status
   ```

   Two things that stop this dead:

   - **Virtualisation is off in the BIOS.** `wsl --install` then complains that the Virtual
     Machine Platform feature could not be enabled. On the standard-issue laptops it is on; on
     anything reused from another department, ask [[nils_putty]] to switch it on in the firmware.
   - **Your account is not in the local `docker-users` group.** Docker Desktop starts and
     immediately says you are not allowed to use it. Also a ticket for Nils.

   Then start SQL Server:

   ```powershell
   docker run -d --name paneflow-db `
     -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<from the password manager>" `
     -p 1433:1433 `
     mcr.microsoft.com/mssql/server:2022-latest
   ```

   The backtick is PowerShell's line continuation. Docker documentation uses `\`, and pasting that
   into PowerShell runs only the first line and then errors on the rest.

9. **Make that container actually stay up.** ← *second thing that goes wrong*

   Two failure modes, and neither error message points at the cause.

   **Docker is in Windows-containers mode.** `docker run` refuses with `no matching manifest for
   windows/amd64 in the manifest list entries`. Because the message names the manifest, people go
   looking for a different image tag. There is no Windows build of this image and there does not
   need to be. Right-click the Docker whale in the notification area → **Switch to Linux
   containers…**, wait for the restart, run the command again.

   **The container starts and exits within seconds.** `docker logs paneflow-db` is the first
   thing to read, always. Usual cause: SQL Server wants roughly 2 GB of RAM and WSL2's default
   memory cap starves it. Create `%USERPROFILE%\.wslconfig`:

   ```ini
   [wsl2]
   memory=8GB
   ```

   then `wsl --shutdown` and start Docker Desktop again. Second-usual cause: the SA password is
   rejected. It needs at least eight characters from three of uppercase, lowercase, digits and
   symbols, and the failure looks like a startup crash rather than a validation error.

10. **Load the seed data.** Get the current dump from `\\fileserver\dev\paneflow_seed.bak` —
    roughly 400 anonymised orders, enough for the optimizer to have something to chew on.

    ```powershell
    docker cp .\paneflow_seed.bak paneflow-db:/var/opt/mssql/backup/
    docker exec -it paneflow-db /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa `
      -Q "RESTORE DATABASE PaneFlow FROM DISK='/var/opt/mssql/backup/paneflow_seed.bak' WITH MOVE ..."
    ```

    Only the left-hand side of `docker cp` is a Windows path. Everything after the colon is inside
    the container and stays a Linux path with forward slashes, no matter which shell you type it
    in.

    If the restore fails with error 3169, the dump was taken on a newer server version than the
    container. Ask Nils for one from the matching version rather than upgrading the container.

11. **Local configuration.** Copy `appsettings.Development.template.json` to
    `appsettings.Development.json` and point the connection string at `localhost,1433`. The file
    is git-ignored on purpose. Secrets go into user secrets, never into the file:

    ```powershell
    Copy-Item appsettings.Development.template.json appsettings.Development.json
    dotnet user-secrets set "ConnectionStrings:PaneFlow" "Server=localhost,1433;..."
    ```

    User secrets land in `%APPDATA%\Microsoft\UserSecrets\<id>\secrets.json` — outside the
    repository, which is the whole point. They are not encrypted, so this protects against
    committing them by accident, not against someone with your laptop.

12. **Build and run.**

    ```powershell
    dotnet dev-certs https --trust      # once per machine, confirm the Windows dialog
    dotnet build
    dotnet run --project src\PaneFlow.Api
    curl.exe -i https://localhost:5001/api/v1/health     # expect 200
    ```

    Skip `dev-certs` and every HTTPS call fails with a certificate trust error that reads like a
    server problem. Swagger is at `/swagger` in Development only.

13. **Run the tests.** `dotnet test` — around 900 of them, about 40 seconds. The integration tests
    are a separate project and need the container from step 8 running.

    If builds and tests feel slow, it is usually Defender scanning every file the compiler writes
    into `bin\` and `obj\`. An exclusion for `C:\dev` is the single biggest speedup on these
    laptops, and it needs IT approval — ask Nils rather than switching anything off yourself.

14. **Tell [[dana_frames]]** you are through, and take a support ticket as the first change.
    Small, real, and it forces you to use everything you just installed.

## Related

- [[terminal_cheatsheet]]
- [[git_cheatsheet]]
- [[howto_release_a_hotfix]]
- [[nils_putty]]
- [[moc_development]]

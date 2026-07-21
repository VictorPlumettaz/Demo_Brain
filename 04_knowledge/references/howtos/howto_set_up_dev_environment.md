---
title: How-to — Set Up the Dev Environment
tags: [knowledge, reference, howto, onboarding]
created: 2026-06-02
updated: 2026-08-10
source: internal onboarding page, plus the two days it actually took me
---

# How-to — Set Up the Dev Environment

Getting a fresh MacBook ready to build and run [[paneflow]] locally.

## Why it matters here

The official onboarding page is four steps long and takes half a day. This is the version with
the parts that are missing from it. I wrote it while setting up the machine for the second-year
apprentice starting in September, so it has been run through once end to end.

Budget a full day. Steps 6 and 8 are where everyone loses their afternoon.

## Steps

1. **Get access.** Ask [[nils_putty]] for: the AD account, GitLab access to `paneflow` and
   `paneflow-optimizer`, the VPN profile, and the licence key for Rider. All five, in one
   message — asking for them one at a time takes a week.

2. **Install the basics.**

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   brew install git jq
   brew install --cask docker jetbrains-toolbox
   ```

3. **Install the .NET SDK.** We are on .NET 8 (LTS) and `global.json` pins the feature band,
   so a newer SDK will refuse to build.

   ```bash
   brew install --cask dotnet-sdk
   dotnet --list-sdks          # an 8.0.4xx must be in the list
   ```

4. **Configure git.**

   ```bash
   git config --global user.name "Robin Sill"
   git config --global user.email robin.sill@panerelief.example
   git config --global pull.rebase true
   git config --global init.defaultBranch main
   ```

   Do not set `core.autocrlf true` on macOS. The repo has a `.gitattributes` and setting it as
   well produces a diff on every file exactly once, which is a confusing first pull request.

5. **Connect the VPN** with the profile from step 1. Everything internal — GitLab, the NuGet
   feed, staging — is only reachable through it.

6. **Clone and restore.** ← *first thing that goes wrong*

   ```bash
   mkdir -p ~/dev && cd ~/dev
   git clone git@gitlab.internal:paneflow/paneflow.git
   cd paneflow
   dotnet restore
   ```

   `dotnet restore` will fail with `401 Unauthorized` from the internal package feed. Two
   causes, both of them normal:

   - The feed credentials are not in the repo. Copy `nuget.config.template` to `nuget.config`
     (it is git-ignored) and put a GitLab personal access token with `read_api` in it.
   - The VPN certificate expires every 90 days. When it does, the symptom is not "VPN broken",
     it is this same 401 — because the feed simply is not reachable and the proxy answers
     instead. Check with `curl -I https://nuget.internal/v3/index.json` before debugging NuGet.

7. **Start SQL Server in Docker.**

   ```bash
   docker run -d --name paneflow-db \
     --platform linux/amd64 \
     -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<from 1Password>" \
     -p 1433:1433 \
     mcr.microsoft.com/mssql/server:2022-latest
   ```

8. **Make that container actually stay up.** ← *second thing that goes wrong*

   On an Apple Silicon Mac the container starts and exits within a second, with no useful
   message in `docker logs`. There is no ARM build of SQL Server. Open Docker Desktop →
   Settings → General and switch on **Use Rosetta for x86/amd64 emulation**, then restart
   Docker and run the container again. Nobody tells you this and the error looks like a
   password problem.

9. **Load the seed data.** Get the current dump from `\\fileserver\dev\paneflow_seed.bak` —
   roughly 400 anonymised orders, enough for the optimizer to have something to chew on.

   ```bash
   docker cp paneflow_seed.bak paneflow-db:/var/opt/mssql/backup/
   docker exec -it paneflow-db /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa \
     -Q "RESTORE DATABASE PaneFlow FROM DISK='/var/opt/mssql/backup/paneflow_seed.bak' WITH MOVE ..."
   ```

   If the restore fails with error 3169, the dump was taken on a newer server version than the
   container. Ask Nils for one from the matching version rather than upgrading the container.

10. **Local configuration.** Copy `appsettings.Development.template.json` to
    `appsettings.Development.json` and point the connection string at `localhost,1433`. The
    file is git-ignored on purpose. Secrets go into user secrets, never into the file:

    ```bash
    dotnet user-secrets set "ConnectionStrings:PaneFlow" "Server=localhost,1433;..."
    ```

11. **Build and run.**

    ```bash
    dotnet build
    dotnet run --project src/PaneFlow.Api
    curl -i https://localhost:5001/api/v1/health     # expect 200
    ```

    Swagger is at `/swagger` in Development only.

12. **Run the tests.** `dotnet test` — around 900 of them, about 40 seconds. The integration
    tests are a separate project and need the container from step 7 running.

13. **Tell [[dana_frames]]** you are through, and take a support ticket as the first change.
    Small, real, and it forces you to use everything you just installed.

## Related

- [[terminal_cheatsheet]]
- [[git_cheatsheet]]
- [[howto_release_a_hotfix]]
- [[nils_putty]]
- [[moc_development]]

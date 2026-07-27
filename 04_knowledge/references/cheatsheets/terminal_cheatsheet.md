---
title: Terminal Cheatsheet
tags: [knowledge, reference, cheatsheet, shell]
created: 2026-04-28
updated: 2026-08-21
source: Microsoft PowerShell documentation; Windows PowerShell 5.1 and PowerShell 7, differences marked
---

# Terminal Cheatsheet

PowerShell on Windows, which is what the work laptop runs. Two versions are on every machine:
**Windows PowerShell 5.1** (`powershell.exe`, ships with Windows, no longer developed) and
**PowerShell 7** (`pwsh.exe`, installed separately, what you should use). They mostly agree; where
they do not, it is marked below.

The build servers are Linux. Git Bash covers the gap — see the last two sections.

## Moving around

```powershell
Get-Location                       # where am I
Set-Location C:\dev\paneflow       # go
Set-Location ..                    # up one
Set-Location -                     # back to the previous directory  (PowerShell 7 only)
Get-ChildItem                      # list
Get-ChildItem -Force               # include hidden and system files
Get-ChildItem -Recurse -File       # everything below here, files only
Get-ChildItem | Sort-Object LastWriteTime -Descending    # newest first
Invoke-Item .                      # this folder in Explorer
```

Nobody types the long names. Every cmdlet has aliases, and the Unix ones are there on purpose:

| You type | It runs |
|---|---|
| `pwd` | `Get-Location` |
| `cd`, `sl` | `Set-Location` |
| `ls`, `dir`, `gci` | `Get-ChildItem` |
| `cat`, `type`, `gc` | `Get-Content` |
| `cp`, `copy` | `Copy-Item` |
| `mv`, `move` | `Move-Item` |
| `rm`, `del` | `Remove-Item` |
| `ps` | `Get-Process` |
| `kill` | `Stop-Process` |
| `ii` | `Invoke-Item` |
| `man`, `help` | `Get-Help` |

The alias covers the **name**, not the flags. `ls -la` fails, because `Get-ChildItem` has never
heard of `-la`. More on that under "PowerShell is not bash".

## Files

```powershell
Copy-Item file.txt copy.txt
Copy-Item src\ backup\ -Recurse           # -Recurse for folders
Move-Item old.txt new.txt                 # rename and move are the same thing
New-Item -ItemType Directory a\b\c -Force # -Force creates the parents too
New-Item -ItemType File notes.md          # create empty
Remove-Item file.txt
Remove-Item folder -Recurse -Force        # no undo, no Recycle Bin
New-Item -ItemType Junction -Path pf -Target C:\dev\paneflow   # folder link, no admin rights
```

A **junction** is Windows' folder link. Unlike a symlink it needs no administrator rights, which
is why `00_system\skills_link.ps1` uses one.

Sizes and free space:

```powershell
(Get-ChildItem -Recurse -File | Measure-Object Length -Sum).Sum / 1MB   # this tree, in MB
Get-ChildItem -Directory | ForEach-Object {
    '{0,8:N1} MB  {1}' -f ((Get-ChildItem $_ -Recurse -File |
        Measure-Object Length -Sum).Sum / 1MB), $_.Name
}                                                       # size per subfolder
Get-PSDrive -PSProvider FileSystem                      # used and free per drive
```

`KB`, `MB`, `GB` and `TB` are real number literals in PowerShell: `500KB` is `512000`. No maths
in your head.

## Reading

```powershell
Get-Content appsettings.json          # whole file
Get-Content big.log -TotalCount 20    # first 20 lines
Get-Content big.log -Tail 50          # last 50 lines
Get-Content app.log -Tail 50 -Wait    # follow live, Ctrl+C to stop
Get-Content big.log | Measure-Object -Line      # count lines
Get-Content app.log | Out-Host -Paging          # page through it, space for the next screen
Get-Content config.json | ConvertFrom-Json      # JSON straight into an object you can query
```

`Get-Content` without `-Tail` or `-TotalCount` loads the whole file into memory as an array of
lines. On a 2 GB log that is a problem — always bound it.

## Searching text

`Select-String` is PowerShell's `grep`. Two differences that bite immediately: it is
**case-insensitive by default**, and it **does not recurse** — you feed it files.

```powershell
Select-String "PatternPacker" .\*.cs                     # one folder
Get-ChildItem -Recurse -Filter *.cs | Select-String "IPriceRepo"      # recursive
Select-String "error" app.log                            # ignores case
Select-String "Error" app.log -CaseSensitive             # like grep, exact case
Select-String "Debug" app.log -NotMatch                  # invert: everything that is not
(Select-String "Exception" app.log).Count                # count matches
Select-String "40[0-9]" access.log                       # regex is the default, no flag needed
Select-String "Unhandled" app.log -Context 3,5           # 3 lines before, 5 after
Get-ChildItem -Recurse -Filter *.json |
    Select-String "connectionString" -List |
    Select-Object -ExpandProperty Path                   # file names only
```

`-List` stops after the first hit per file, which is what makes the last one fast.

`Select-String` returns **MatchInfo objects**, not strings. `$_.Line` is the matched text,
`$_.Path` the file, `$_.LineNumber` the line. That is why the last example needs
`Select-Object -ExpandProperty Path` instead of `cut`.

`rg` (ripgrep, `winget install BurntSushi.ripgrep.MSVC`) is much faster over a whole repository
and skips `.git\` and `bin\` on its own. For anything that has to keep flowing down a PowerShell
pipeline, `Select-String` is still the right tool, because it hands over objects.

## Pipes and redirection

```powershell
Get-Process | Where-Object CPU -gt 10     # objects go down the pipe, not text
command > out.txt                         # write, overwriting
command >> out.txt                        # append
command 2> errors.txt                     # errors only
command *> all.txt                        # every stream into one file
command 2>$null                           # throw errors away
command | Tee-Object out.txt              # show on screen and save
command | Out-File out.txt -Encoding utf8 # explicit encoding
```

**Encoding trap:** in Windows PowerShell 5.1, `>` writes UTF-16LE. Any tool that expects UTF-8
then reads your file as binary noise. PowerShell 7 writes UTF-8 without BOM. When in doubt, use
`Out-File -Encoding utf8` and stop guessing.

The pipeline I use most — the ten most frequent error messages in a log:

```powershell
Select-String "ERROR" app.log |
    ForEach-Object { ($_.Line -split '\s+', 4)[3] } |
    Group-Object |
    Sort-Object Count -Descending |
    Select-Object -First 10 Count, Name
```

`Group-Object` replaces `sort | uniq -c`, and unlike `uniq` it does **not** need a sort in front
of it — it groups by value, not by adjacency.

## Text tools

```powershell
Get-Content list.txt | Sort-Object -Unique              # sort, drop duplicates
Import-Csv export.csv | Select-Object Width, Height     # columns by name, not by number
Import-Csv export.csv | Where-Object { [int]$_.Width -gt 1000 }
(Get-Content app.log) -replace 'localhost','paneflow-db'          # print with substitution
Get-Content access.log | ForEach-Object {
    $f = $_ -split '\s+'; "$($f[0]) $($f[-1])"          # first and last field
}
```

Editing a file in place — the equivalent of `sed -i`:

```powershell
(Get-Content appsettings.json) -replace 'localhost','paneflow-db' |
    Set-Content appsettings.json
```

**The parentheses are not decoration.** They force the file to be read completely before
`Set-Content` opens it for writing. Leave them out and `Set-Content` truncates the file that
`Get-Content` is still reading, and you get an empty file. This has cost me an `appsettings.json`.

`-replace` takes a regex; `.Replace()` on a string is literal. For a Windows path in a pattern,
use `[regex]::Escape('C:\dev')` — the backslashes are escapes to the regex engine.

## Permissions

Windows has no permission bits. Access is a list of rules per file (an **ACL**, access control
list) and it is far more verbose than `rwx`:

```powershell
Get-Acl notes.md | Format-List
icacls C:\dev\paneflow                    # the compact, readable form
(Get-Item deploy.ps1).Attributes          # ReadOnly, Hidden, Archive...
Set-ItemProperty notes.md -Name IsReadOnly -Value $true
```

There is **no execute bit**. Whether something runs is decided by its extension (`.exe`, `.ps1`,
`.bat`) and by the execution policy, not by a permission. So `chmod +x` has no equivalent and
needs none — except in git, which stores the Unix mode anyway:

```powershell
git update-index --chmod=+x deploy.sh     # for scripts the Linux build server has to run
```

Without that line the script arrives on the build server without its execute bit, because Windows
had no way to set it.

The one place Windows does check permissions like Unix is SSH. If `ssh` refuses your key with
"permissions are too open":

```powershell
icacls $env:USERPROFILE\.ssh\id_ed25519 /inheritance:r /grant:r "$($env:USERNAME):(R)"
```

## Processes and ports

```powershell
Get-Process dotnet
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
Stop-Process -Id 4711
Stop-Process -Name dotnet -Force          # -Force: do not ask for confirmation

Get-NetTCPConnection -LocalPort 5000 -State Listen       # who is holding the API's port
Get-NetTCPConnection -LocalPort 5000 |
    ForEach-Object { Get-Process -Id $_.OwningProcess }  # and which program that is
netstat -ano | Select-String ":5000"                     # the old way, still works
```

Windows has no `SIGTERM`, so there is no "ask nicely" version of `Stop-Process` for a console
program — it terminates. `-Force` only suppresses the confirmation prompt.

There is also no `Ctrl+Z` / `bg` / `fg`. Background work goes through jobs:

```powershell
Start-Job { dotnet test }
Get-Job ; Receive-Job 1                   # see them, collect the output
dotnet test &                             # shorthand, PowerShell 7 only
Ctrl+C                                    # stop the foreground program
```

## Environment and history

```powershell
$env:PATH                                     # read one variable
$env:ASPNETCORE_ENVIRONMENT = 'Development'   # set it — this process only
Get-ChildItem Env:                            # list all of them
Get-Command dotnet                            # which binary actually runs
$PROFILE                                      # path to your startup script
. $PROFILE                                    # reload it after editing
```

`$env:X = ...` lives and dies with the window. Child processes inherit it, a new terminal does
not. To make it stick:

```powershell
[Environment]::SetEnvironmentVariable('ASPNETCORE_ENVIRONMENT','Development','User')
```

Then **open a new terminal**. The running one keeps its own copy of the environment and will not
see the change — this is the same reason an installer tells you to restart your shell.

History:

```powershell
Get-History                                        # this session only
Get-History | Where-Object CommandLine -like '*restore*'
Invoke-History 42                                  # run entry 42 again  (alias: r 42)
(Get-PSReadLineOption).HistorySavePath             # the file that survives reboots
```

`Get-History` is per session. PSReadLine — the module that gives the prompt its editing and
colours — keeps a separate plain-text file across sessions, and that is what `Ctrl+R` searches.
`!!` and `!$` are bash and do not exist here.

## Line editing

PSReadLine, Windows key layout:

| Key | Does |
|---|---|
| `Home` / `End` | start / end of line |
| `Ctrl+Left` / `Ctrl+Right` | one word left / right |
| `Ctrl+Backspace` | delete the word before the cursor |
| `Escape` | clear the whole line |
| `Ctrl+L` | clear the screen |
| `Ctrl+R` | search backwards through history — the best key here |
| `F8` | cycle through history entries starting with what you typed |
| `Tab` / `Ctrl+Space` | complete / show all completions as a menu |
| `Ctrl+C` | copy if something is selected, otherwise cancel the command |

`Set-PSReadLineOption -EditMode Emacs` swaps the whole set for the bash keys (`Ctrl+A`, `Ctrl+E`,
`Ctrl+U`, `Ctrl+W`). Worth it if your fingers already know them.

## Paths

| Thing | On Windows |
|---|---|
| Separator | `\`, but PowerShell accepts `/` too: `Get-ChildItem C:/dev/paneflow` works |
| Escape character | backtick `` ` ``, **not** backslash — so `"C:\temp\new"` is literal, and `` "line`nbreak" `` is a newline |
| Spaces | quote them: `Set-Location 'C:\Program Files\Git'` |
| Quotes | `'single'` is literal, `"double"` expands `$variables` and `$(expressions)` |
| Home | `~` works and means `C:\Users\robin` |
| Case | ignored. `Get-ChildItem PaneFlow.cs` finds `paneflow.cs` — the Linux build server does not, so a wrong-case `using` compiles here and fails there |
| Network shares | `\\fileserver\dev\` works directly, no mounting |
| Building paths | `Join-Path $vault '.claude\skills'`, never string concatenation |
| Length limit | 260 characters unless long paths are switched on. Deep `bin\Debug\net8.0\...` trees hit it, and the error says "filename too long" somewhere unrelated |
| Running a script | `.\build.ps1` — the `.\` is mandatory. PowerShell refuses to run anything from the current directory by name, so a stray `git.ps1` cannot hijack `git` |

## Execution policy

```powershell
Get-ExecutionPolicy -List                              # what is set, and at which scope
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned    # persistent, no admin rights needed
powershell -ExecutionPolicy Bypass -File 00_system\skills_link.ps1   # this run only
Unblock-File .\skills_link.ps1                         # drop the "came from the internet" mark
```

The execution policy decides whether `.ps1` files may run. It is **not a security boundary** —
anyone can bypass it in one flag, which is the point below. It exists so a script cannot run by
accident, for example by double-click.

| Policy | Means |
|---|---|
| `Restricted` | no script runs at all. The default on Windows client machines |
| `RemoteSigned` | local scripts run, downloaded ones need a signature. The sensible setting |
| `AllSigned` | everything needs a signature, including your own scripts |
| `Bypass` | nothing is blocked, nothing is warned about |

**Why the skill script needs it.** `00_system\skills_link.ps1` creates a junction for each skill
folder inside `.claude\skills\`, because that is the only path Claude Code loads skills from. On a
fresh clone the default `Restricted` policy stops it with *"running scripts is disabled on this
system"* — a message that sounds like a rights problem and sends people asking for local admin
they do not need. `-ExecutionPolicy Bypass` applies to that single invocation and changes nothing
on the machine, which is why the script's own header spells the command out.

A `.ps1` that arrived in a zip or download carries a hidden "mark of the web" flag. Then even
`RemoteSigned` blocks it, and the fix is `Unblock-File`, not a policy change.

## PowerShell is not bash

Everything below is a real trap for someone following a Linux tutorial.

| Trap | What actually happens |
|---|---|
| `ls -la`, `rm -rf`, `cat -n` | the **names** are aliases, the **flags** are not. Use `Get-ChildItem -Force`, `Remove-Item -Recurse -Force` |
| `grep` | does not exist. `Select-String`, case-insensitive by default, no recursion |
| `cut`, `awk`, `sed` | do not exist. The pipeline carries objects, so you use `Select-Object`, `Where-Object`, `-replace` |
| `curl`, `wget` | in Windows PowerShell 5.1 these are aliases for `Invoke-WebRequest` and swallow curl's flags. Write `curl.exe`. PowerShell 7 removed the aliases |
| `&&` and the or-else operator | PowerShell 7 only. In 5.1 use `;` to always run, or `if ($?) { ... }` to run on success |
| `$?` | a boolean, not the exit code. The exit code of a native program is `$LASTEXITCODE` |
| `echo` | is `Write-Output` and emits objects. `Write-Host` writes to the screen and cannot be piped or captured |
| `>` in a condition | `>` is always redirection. Comparisons are words: `-eq -ne -gt -lt -like -match`. `if ($a > $b)` silently creates a file called `$b` |
| `sudo` | no such thing. Elevation starts a new process: `Start-Process pwsh -Verb RunAs` |
| Line endings | Windows editors write CRLF, git and Linux want LF. A stray `\r` makes a shell script die on the build server with `bash\r: not found`, and turns a one-line change into a whole-file diff |

The object pipeline is the big one, and it cuts both ways:

```powershell
Get-ChildItem | Select-Object Name, Length, LastWriteTime
```

Nothing is parsed here — `Length` is a number because the object has a number, not because a
column was counted. But every Linux one-liner you paste has to be rewritten, and formatting is
one-way: `Format-Table` produces display objects, so piping a `Format-*` into anything else gives
you formatting instructions instead of data. `Format-*` goes last, always.

For the CRLF problem, the repository-level fix beats the per-machine one: a `.gitattributes` with
`* text=auto eol=lf` applies to everyone who clones. This vault has one at its root. Details in
[[howto_set_up_dev_environment]].

## Git Bash, and when to use it

Git for Windows installs a small Unix environment alongside git: `bash`, plus `grep`, `sed`,
`awk`, `find`, `less`, `ssh`, `curl`, `tar`. It is already on the machine.

| Situation | Shell |
|---|---|
| Daily work, .NET, files, anything whose output you want as data | PowerShell |
| A one-liner copied from a README or Stack Overflow | Git Bash |
| The build server's `.sh` scripts, run locally | Git Bash |
| Quick `sed`/`awk` from a tutorial you do not want to translate | Git Bash |

One Git Bash quirk worth knowing: it rewrites arguments that look like Unix paths into Windows
paths, so `docker run -v /c/dev:/app` can arrive as something under `C:\Program Files\Git`.
Prefix the command with `MSYS_NO_PATHCONV=1` when that happens.

## Archives and network

```powershell
Compress-Archive logs\ -DestinationPath logs.zip
Expand-Archive logs.zip -DestinationPath .\logs
tar -czf logs.tar.gz logs\               # real tar, ships with Windows

Invoke-WebRequest https://api.paneflow.local/api/v1/health      # alias: iwr
Invoke-RestMethod https://api.paneflow.local/api/v1/orders      # alias: irm, parses JSON for you
curl.exe -i https://api.paneflow.local/api/v1/health            # note the .exe

$body = @{ customer = 'Glaswerk Nord' } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri https://api.paneflow.local/api/v1/orders `
    -ContentType 'application/json' `
    -Headers @{ Authorization = "Bearer $token" } `
    -Body $body

ssh robin@build01                        # OpenSSH ships with Windows
scp build01:/var/log/paneflow/app.log .
```

`Invoke-RestMethod` gives you a real object — `(irm .../orders).Count` works, no `jq` needed. The
backtick at the end of a line is PowerShell's line continuation; every Docker and curl README uses
`\`, and pasting one of those into PowerShell breaks it at the first line.

## Related

- [[git_cheatsheet]]
- [[howto_set_up_dev_environment]]
- [[logging_basics]]
- [[moc_development]]

---
title: Terminal Cheatsheet
tags: [knowledge, reference, cheatsheet, shell]
created: 2026-04-28
updated: 2026-08-19
source: man pages; macOS zsh, differences to Linux marked
---

# Terminal Cheatsheet

zsh on macOS, which is what the work laptop runs. The build servers are Linux, and the two
disagree just often enough to be annoying — those differences are at the bottom.

## Moving around

```bash
pwd                 # where am I
cd ~/dev/paneflow   # go
cd ..               # up one
cd -                # back to the previous directory
ls -lah             # long, all, human-readable sizes
ls -lt              # newest first
open .              # macOS: this folder in Finder
```

## Files

```bash
cp file copy.txt
cp -r src/ backup/           # -r for folders
mv old.txt new.txt           # rename and move are the same thing
mkdir -p a/b/c               # -p creates the parents too
rm file
rm -r folder                 # no undo, no bin
touch notes.md               # create empty / update timestamp
ln -s ~/dev/paneflow pf      # symlink
du -sh *                     # size of everything here
df -h                        # free disk
```

## Reading

```bash
cat appsettings.json         # short files only
less big.log                 # q quit, / search, n next, G end, g start
head -n 20 big.log
tail -n 50 big.log
tail -f app.log              # follow live, Ctrl+C to stop
wc -l big.log                # count lines
```

## find

```bash
find . -name "*.cs"                        # by name, case-sensitive
find . -iname "*packer*"                   # case-insensitive
find . -type d -name "bin"                 # directories only
find . -type f -mtime -7                   # changed in the last 7 days
find . -size +10M                          # bigger than 10 MB
find . -name "*.log" -mtime +30 -delete    # careful
find . -name "*.cs" -exec grep -l "TODO" {} \;
```

## grep

```bash
grep -rn "PatternPacker" .                 # recursive, with line numbers
grep -rn --include="*.cs" "IPriceRepo" src/
grep -i "error" app.log                    # ignore case
grep -v "Debug" app.log                    # invert: everything that is not
grep -c "Exception" app.log                # count matches
grep -l "connectionString" -r .            # only file names
grep -E "40[0-9]" access.log               # regex
grep -B 3 -A 5 "Unhandled" app.log         # context lines around the hit
```

`rg` (ripgrep) is installed and does the same much faster, and skips `.git` and `bin/` on its
own. I still write `grep` out of habit.

## Pipes and redirection

```bash
command | other                # send output into the next command
command > out.txt              # write, overwriting
command >> out.txt             # append
command 2> errors.txt          # stderr only
command > all.txt 2>&1         # both into one file
command 2>/dev/null            # throw errors away
command | tee out.txt          # show on screen and save
```

Counting the top error messages in a log, which is the pipeline I use most:

```bash
grep "ERROR" app.log | cut -d' ' -f4- | sort | uniq -c | sort -rn | head
```

`uniq` only collapses **adjacent** duplicates, so it needs `sort` in front of it. Forgetting
that gives a plausible and wrong answer.

## Text tools

```bash
sort -u list.txt               # sort, drop duplicates
cut -d',' -f2,3 export.csv     # columns 2 and 3 of a CSV
tr 'a-z' 'A-Z' < file          # translate characters
sed 's/localhost/paneflow-db/g' appsettings.json     # print with substitution
sed -i '' 's/old/new/g' file   # macOS: edit in place, note the empty ''
awk '{print $1, $NF}' access.log                     # first and last field
xargs -n1 echo < list.txt      # turn each line into one argument
find . -name "*.tmp" -print0 | xargs -0 rm           # -print0/-0 survives spaces
```

## Permissions

`ls -l` shows `-rwxr-xr--`: type, then owner, group, others.

| Digit | Means | Numbers |
|---|---|---|
| `r` | read | 4 |
| `w` | write | 2 |
| `x` | execute, or enter a directory | 1 |

```bash
chmod 644 notes.md      # owner rw, everyone else r
chmod 755 deploy.sh     # owner rwx, everyone else rx
chmod 600 ~/.ssh/id_ed25519    # owner only — ssh refuses anything looser
chmod +x deploy.sh      # just make it runnable
chown robin:staff file
```

## Processes and ports

```bash
ps aux | grep dotnet
top                     # q to quit
kill 4711               # ask nicely
kill -9 4711            # do not ask (last resort)
lsof -i :5000           # who is holding the port the API wants
Ctrl+C                  # stop the foreground program
Ctrl+Z  then  bg        # suspend, then continue in the background
jobs / fg %1
```

## Environment and history

```bash
echo $PATH
export ASPNETCORE_ENVIRONMENT=Development
which dotnet            # which binary actually runs
source ~/.zshrc         # reload the config after editing it
history | grep restore
!!                      # the previous command
!$                      # the last argument of the previous command
Ctrl+R                  # search backwards through history — the best key here
```

## Line editing

| Key | Does |
|---|---|
| `Ctrl+A` / `Ctrl+E` | start / end of line |
| `Ctrl+U` / `Ctrl+K` | delete to start / to end |
| `Ctrl+W` | delete the word before the cursor |
| `Ctrl+L` | clear the screen |
| `Ctrl+D` | end of input, or close the shell |

## Archives and network

```bash
tar -czf logs.tar.gz logs/       # create gzipped
tar -xzf logs.tar.gz             # extract
zip -r out.zip folder/ && unzip out.zip

curl -i https://api.paneflow.local/api/v1/health
curl -X POST https://api.paneflow.local/api/v1/orders \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -d '{"customer":"Glaswerk Nord"}'

ssh robin@build01
scp build01:/var/log/paneflow/app.log .
```

## macOS is not Linux

| Thing | macOS (BSD) | Linux (GNU) |
|---|---|---|
| in-place sed | `sed -i '' 's/a/b/'` | `sed -i 's/a/b/'` |
| clipboard | `pbcopy` / `pbpaste` | `xclip -sel clip` |
| `ls` colours | `ls -G` | `ls --color` |
| long flags | often missing | usually there |

The `sed -i ''` one has cost me a file called `-e`. Twice.

## Related

- [[git_cheatsheet]]
- [[howto_set_up_dev_environment]]
- [[logging_basics]]
- [[moc_development]]

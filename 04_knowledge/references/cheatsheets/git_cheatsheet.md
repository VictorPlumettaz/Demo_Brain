---
title: Git Cheatsheet
tags: [knowledge, reference, cheatsheet, git]
created: 2026-04-24
updated: 2026-08-17
source: git-scm.com reference, trimmed down to what I actually use
---

# Git Cheatsheet

The commands I run in a normal week. The model behind them is in [[git_basics]].

## Look around

| Command | Does |
|---|---|
| `git status -sb` | short status plus branch and ahead/behind |
| `git diff` | working tree vs staging |
| `git diff --staged` | staging vs last commit |
| `git diff main...HEAD` | what my branch adds since it left `main` |
| `git log --oneline --graph --decorate --all` | the history as a picture |
| `git log -S "PatternPacker"` | commits where that string appeared or disappeared |
| `git log --follow -- src/Packer.cs` | history of one file, across renames |
| `git blame -L 40,60 src/Packer.cs` | who last touched lines 40-60 |
| `git show a1b2c3d` | one commit, message and diff |

## Stage and commit

```bash
git add src/Packer.cs        # one file
git add -p                   # hunk by hunk, best habit I picked up
git restore --staged file    # unstage, keep the edit
git restore file             # throw the edit away  (destructive)

git commit -m "Fix rounding on trim loss"
git commit --amend --no-edit # fold into the previous commit, before pushing
```

## Branches

| Command | Does |
|---|---|
| `git switch -c feature/x` | new branch here, switch to it |
| `git switch main` | switch |
| `git switch -` | back to the previous branch |
| `git branch -vv` | local branches, their remote and drift |
| `git branch -d feature/x` | delete, refuses if unmerged |
| `git branch -D feature/x` | delete anyway (destructive) |

## Remotes

```bash
git fetch --prune                 # update refs, drop branches deleted on the server
git pull --rebase                 # fetch + replay my commits on top, no merge bubble
git push -u origin HEAD           # push and set upstream in one go
git push --force-with-lease       # rewrite, but refuse if someone else pushed
```

`--force-with-lease` instead of `--force`, always. See the incident in [[git_basics]].

## Undo

| Situation | Command |
|---|---|
| Wrong commit message, not pushed | `git commit --amend` |
| Undo commit, keep changes staged | `git reset --soft HEAD~1` |
| Undo commit, keep changes in the tree | `git reset HEAD~1` |
| Undo commit and the changes | `git reset --hard HEAD~1` (destructive) |
| Undo a commit already pushed | `git revert a1b2c3d` |
| Where was I an hour ago | `git reflog` |
| Get a deleted branch back | `git switch -c rescue a1b2c3d` from the reflog |

`revert` on anything shared, `reset` only on commits nobody else has seen.

## Conflicts

```bash
git status                   # lists "both modified"
# edit the file, delete <<<<<<<  =======  >>>>>>>
git add file
git rebase --continue        # or: git merge --continue

git merge --abort            # back to before the merge
git rebase --abort
git checkout --ours file     # keep my side wholesale
git checkout --theirs file   # keep their side wholesale
```

Trap: during a **rebase**, `--ours` is the branch you are replaying onto and `--theirs` is your
own work. It is the other way round from a merge. I check with `git log` before trusting either.

## Stash

```bash
git stash push -m "half a fix"
git stash list
git stash pop            # apply the newest and delete it
git stash apply stash@{1}
git stash drop stash@{1}
```

## Digging

```bash
git cherry-pick a1b2c3d          # take one commit from elsewhere
git bisect start
git bisect bad                   # current is broken
git bisect good v1.13.0          # this tag was fine
# test, then: git bisect good | git bisect bad
git bisect reset
```

## Housekeeping

| Command | Does |
|---|---|
| `git clean -nd` | *show* untracked files that would be deleted |
| `git clean -fd` | delete them (destructive) |
| `git rm --cached secrets.json` | stop tracking, keep the file on disk |
| `git check-ignore -v file` | which `.gitignore` rule is hiding it |
| `git config --global pull.rebase true` | never accidentally merge on pull |

## Destructive list

`reset --hard` · `clean -fd` · `push --force` · `branch -D` · `restore <file>` · `stash drop`

None of them ask twice. The first four have cost me or someone else time.

## Related

- [[git_basics]]
- [[howto_release_a_hotfix]]
- [[terminal_cheatsheet]]
- [[moc_development]]

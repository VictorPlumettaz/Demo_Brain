---
title: Git Basics
tags: [knowledge, it, git]
created: 2026-04-22
updated: 2026-08-11
---

# Git Basics

Git stores snapshots of a folder and lets several people change that folder without
overwriting each other.

## Why it matters here

Everything at [[pane_relief_software]] is in git — [[paneflow]], the [[cutting_optimizer]],
and this vault. In my first week I lost half a day because I did not know the difference
between *saved* and *committed*, and in May I deleted work that was not mine. The model below
is what I wish someone had drawn on a whiteboard on day one.

## The four places a change can be

| Place | What it is | How a change gets there |
|---|---|---|
| Working tree | the files on disk, what the editor shows | you type |
| Staging area | the basket for the next commit | `git add` |
| Local repository | the chain of commits on your machine | `git commit` |
| Remote | the copy on the server everyone shares | `git push` |

Everyone says "the three places" and then forgets the remote. That is exactly why
"I committed it" and "Marco can see it" are two different statements.

A commit is a complete snapshot plus a pointer to its parent, an author and a message. It is
not a diff, even though every tool shows it as one. The diff is calculated by comparing the
snapshot to its parent.

## Branches

A branch is a movable label pointing at one commit. That is all it is. Creating one copies
nothing, which is why it is instant.

`HEAD` is the label that says which branch you are on. When you commit, your branch label
moves forward and `HEAD` comes along.

Branch names here: `feature/…`, `bugfix/…`, `hotfix/…`. `git switch -c feature/lite-rounding`
creates one, `git push -u origin HEAD` creates the same label on the server. See
[[howto_release_a_hotfix]] for why hotfix branches start from a tag rather than from `main`.

## What a merge conflict really is

When you merge two branches, git looks at both sides and at their common ancestor. If the two
sides changed different files, or different parts of the same file, git works it out alone.

A conflict happens only when **both sides changed the same region of the same file**. Git has
no rule for deciding which one is right, so it stops and hands the decision back:

```
<<<<<<< HEAD
    var yield = placed / sheetArea;
=======
    var yield = placed / (sheetArea - trimLoss);
>>>>>>> feature/trim-loss
```

Top is what is on your branch, bottom is what is coming in. You delete the markers and leave
the code you want — often a third version that is neither. Then `git add` the file and
continue. A conflict is not an error message. It is git refusing to guess.

## The mistake I made once

I rebased a branch Marco and I were both using, and pushed it with `--force`. Rebasing rewrites
commits, so the new ones have different hashes; the remote branch no longer shared history with
what [[marco_bevel]] had. `--force` told the server to take my version anyway, and his two
commits from that morning disappeared from the remote.

Nothing was lost in the end — he still had them locally and recovered them with `git reflog`.
It cost him an hour and me some credibility. Three rules came out of it:

- Force-push only a branch nobody else uses.
- Use `--force-with-lease`. It refuses if the remote moved since your last fetch.
- `git reflog` is the undo history of the local repository. It remembers commits for about 90
  days even after nothing points at them any more.

## Related

- [[git_cheatsheet]]
- [[code_review_basics]]
- [[howto_release_a_hotfix]]
- [[marco_bevel]]
- [[moc_development]]

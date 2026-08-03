---
title: Trash
tags: [system, archive, trash]
created: 2026-04-13
updated: 2026-08-15
---

# Trash

Nothing is deleted straight away. It waits here for **30 days** first.

## The rule

When something is deleted — by me or by the AI — it moves here instead of disappearing. Each
item keeps a `deleted` date in its frontmatter. The weekly `/cleanup` pass removes whatever has
been sitting here longer than 30 days, and reports what it removed.

That is the whole mechanism: one folder, one date field, one line in the cleanup skill.

## Why a delay and not just delete

Because otherwise I never let anything be deleted at all.

An AI that tidies a vault has to be allowed to throw things away — a superseded draft, a note
that got merged into a better page, a duplicate. If every one of those is permanent the moment
it happens, I will not grant permission, and then nothing gets tidied. A vault nobody tidies is
unusable within a year.

Thirty days is long enough that a mistake surfaces — I go looking for a page, do not find it,
and it is still here. It is short enough that the folder does not quietly become a second
archive.

**The delay is not for the AI. It is for me, so that I can say yes.**

## What this folder is not

It is not `06_archive/`. Archiving means *finished and kept* — a shipped project, last quarter's
daily notes. Those stay forever and stay findable.

Trash means *gone, pending the wait*. Nothing in here is meant to be read again. If something in
here turns out to be worth keeping, it does not belong in here — move it back out.

## Related

- [[index]]
- [[log]]
- `00_system/skills/cleanup/SKILL.md` — the pass that empties this folder

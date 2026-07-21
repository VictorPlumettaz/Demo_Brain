---
title: Convention — File Naming
tags: [system, convention]
created: 2026-04-13
updated: 2026-08-11
---

# File Naming

One rule, because a name you have to think about is a name you will get wrong.

## The rule

`lowercase_with_underscores.md`

- lowercase only
- underscores instead of spaces
- no umlauts, no accents, no `&`, `/`, `:`, `?`, `*`, `"`, `<`, `>`, `|`
- English only, even for German customer names (`glaswerk_nord`, not `Glaswerk Nord`)

## Why it is this strict

| Problem | What breaks |
|---|---|
| Spaces | shell commands need quoting, links break on paste |
| Umlauts | macOS and Windows store them differently, git sees two files |
| Uppercase | macOS ignores case, Linux does not — the repo splits in two |
| `:` and `?` | illegal on Windows, the repo will not clone |

The vault syncs between machines through git. A file that cannot exist on Windows takes
the whole clone down with it.

## Prefixes

| Kind | Pattern | Example |
|---|---|---|
| Daily note | `YYYY_MM_DD.md` | `2026_08_11.md` |
| Weekly report | `weekly_report_kw<NR>_<YEAR>.md` | `weekly_report_kw33_2026.md` |
| Project file | `<project>_<kind>.md` | `coffee_machine_api_tasks.md` |
| Meeting | `<project>_meeting_YYYY_MM_DD.md` | `cutting_optimizer_rewrite_meeting_2026_08_04.md` |
| Person | `firstname_lastname.md` | `dana_frames.md` |
| MOC | `moc_<topic>.md` | `moc_development.md` |

Project files repeat the project name even though they sit in a folder named after the
project. It looks redundant in the file tree — it is not. Open tabs, search results and
links all show the filename without its folder.

## The four exceptions

Uppercase is wrong everywhere except where a tool expects it:

| File | Why it shouts |
|---|---|
| `README.md` | GitHub and most editors look for this exact name |
| `CLAUDE.md` | Claude Code reads this exact name at startup |
| `SKILL.md` | Claude Code reads this exact name inside a skill folder |
| `MEMORY.md` | index of the memory folder, named after the same pattern |

That is the whole list. A file that shouts without being on it is a mistake — and an agent
reading this convention would otherwise rename all four and break the vault.

## Folders

Same rule, plus the numeric prefix at the top level (`00_` … `07_`). The numbers force a
reading order and make paths stable to reference from `CLAUDE.md` and from skills.

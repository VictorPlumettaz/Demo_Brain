---
name: session-start
description: Open a working session cleanly. Use at the start of every session, when the user says "session start", "/session-start", or sends the first message of the day. Pulls first, then shows what is open.
---

# Session Start

The first thing that happens, before anything else. The order matters.

## Steps

### 1. Pull — before anything else

```powershell
git pull --ff-only origin main
```

Someone may have worked on another machine since last time. Pulling at the *end* of a
session means finding out about the conflict after the work is done.

`--ff-only` on purpose: it fast-forwards when that is possible and stops harmlessly when it
is not, instead of leaving a merge commit or a half-merged working tree behind.

**If the pull fails** with "diverging branches can't be fast-forwarded", the history has
split. Say so and stop. Do not merge on your own — find out what happened on the other
machine first.

**On a fresh clone,** the skills are not linked yet. Run this once:

```powershell
powershell -ExecutionPolicy Bypass -File 00_system\skills_link.ps1
```

See `CLAUDE.md`, section *Where the skills live*, for why that step exists.

### 2. Show what is open

Read `00_system/my_tasks.md` and the two most recent files in `05_daily_notes/`. Then report,
without being asked:

- open tasks marked high priority — not the total count, that number tells nobody anything
- what yesterday's daily note left under `## Open`
- whether last week's `weekly_report_kw<NR>_<YEAR>.md` is missing
- anything sitting in `01_inbox/`, with how old it is

**Five lines of output, maximum.** People who get used to long startup reports stop reading
them, and then the one line that mattered goes past unread too.

### 3. Sort by urgency

Due before new, dated before open. After one look the answer to "what do I start with"
should be obvious — not a list to be sorted by hand.

## What this skill does not do

Clear the conversation. A skill cannot empty its own context; that is a manual step.

## Edge cases

- **Second session the same day** — pull anyway, keep the rest short, do not repeat what was
  already discussed.
- **The first message is an urgent question** — pull anyway (it takes two seconds), answer the
  question, then hand in the status. Do not skip it entirely.

## Related

- `/session-end` is the counterpart and writes what this skill reads.
- `/standup` turns the same material into three sentences for the 09:15 standup.

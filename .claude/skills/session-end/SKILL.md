---
name: session-end
description: Close a working session cleanly. Use when the user says "end the session", "session end", or "/session-end". Writes the daily note, updates the log, commits.
---

# Session End

Everything that has to happen before the laptop closes. In order — the daily note comes
first, because everything after it reads from it.

## Steps

1. **Write today's daily note** — `05_daily_notes/YYYY_MM_DD.md`. If it exists, extend it;
   never overwrite.

   ```yaml
   ---
   title: YYYY-MM-DD (Weekday)
   tags: [daily, kw<NR>]
   created: YYYY-MM-DD
   updated: YYYY-MM-DD
   ---
   ```

   Four sections, always the same:

   - `## What happened` — what was worked on, in full sentences
   - `## Done` — what actually finished, with wiki links to the pages it touched
   - `## Open` — what carries into tomorrow
   - `## Notes` — what was learned or not understood. **This is the section people drop
     first and the one knowledge pages later come from.** Do not skip it because the day
     felt unremarkable.

2. **Archive daily notes older than 30 days** into `06_archive/daily_notes/YYYY_kw<NR>/`
   using `git mv`. A weekly report moves with its week, but only once **every** daily note
   of that week has been archived.

3. **Archive finished projects.** Any project in `02_projects/` whose overview says
   `status: done` moves to `06_archive/projects/`. Update `00_system/index.md` afterwards.

4. **Add one line to `00_system/log.md`** — date, what the session was, what changed.

5. **Check `CLAUDE.md`.** Did folders move, did a new convention appear, did a rule turn out
   wrong? Fix it now, while the reason is still fresh, and say what was changed.

6. **Commit.** `git add . && git commit -m "session: <two to five keywords>"`. Push if the
   vault has a remote.

## Edge cases

- **No real session today** — write the daily note with one line saying so. Do not create an
  empty commit.
- **Several sessions in one day** — merge into the existing daily note, do not duplicate it.
- **Nothing finished** — that is a valid daily note. Do not invent progress.

## Related

- `/standup` reads tomorrow morning what this skill writes tonight.
- `/ingest` empties the inbox; run it before this if anything is still sitting there.

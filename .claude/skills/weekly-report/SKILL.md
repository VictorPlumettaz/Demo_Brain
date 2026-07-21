---
name: weekly-report
description: Build the apprenticeship weekly report (Ausbildungsnachweis) from the daily notes of a calendar week. Use when the user says "weekly report", "Wochenbericht", or "/weekly-report".
---

# Weekly Report

Build the official apprenticeship record for one calendar week out of what actually
happened, as recorded in `05_daily_notes/`.

## Steps

1. **Determine the week.** Default: the last *completed* week. Confirm the date range
   before writing — Monday to Sunday, always the full week even if only Mon–Fri have entries.

2. **Check it does not already exist:** `05_daily_notes/weekly_report_kw<NR>_<YEAR>.md`.
   If it does, stop and say so.

3. **Read every daily note in the range.** Do not read anything else. If a day is missing,
   flag it — do not invent a day.

4. **Write the file** with this frontmatter:

   ```yaml
   ---
   title: Weekly Report KW<NR>/<YEAR>
   tags: [weekly-report, apprenticeship]
   week: <NR>
   from: <Monday YYYY-MM-DD>
   to: <Sunday YYYY-MM-DD>
   hours: <total>
   ---
   ```

   Then a table: day · hours · what was done. Then a short section on what was learned.

5. **Formalise the language.** Daily notes are shorthand; the report is read by the training
   supervisor. Same facts, full sentences, no in-jokes.

6. Add a line to `00_system/log.md` and commit.

## Rules

- **Hours must add up** and must match the daily notes. Do not round to make a nicer total.
- **Only what is in the daily notes.** If a day says nothing happened, the report says the
  day was quiet. Never fill a gap with something plausible.
- **Side projects that are not company work do not appear** in the official record.
- Link the projects — the report is a vault page, not a dead document.

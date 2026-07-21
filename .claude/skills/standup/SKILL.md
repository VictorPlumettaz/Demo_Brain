---
name: standup
description: Produce the three standup sentences (yesterday, today, blockers) from the vault. Use when the user says "standup", "what do I say in standup", or "/standup".
---

# Standup

Daily standup is at 09:15. This produces the three sentences, from what is actually written
down rather than from what you can remember at 09:14.

## Steps

1. Read the **most recent daily note** in `05_daily_notes/`.
2. Read the **open tasks** in the active project folders under `02_projects/`.
3. Output exactly three lines, nothing else:

   ```
   Yesterday:  …
   Today:      …
   Blockers:   … (or "none")
   ```

## Rules

- **One sentence each.** If it needs two, it is a design discussion, not a standup item.
- **Name the person you are blocked on** and link them, so the note is useful afterwards.
- **No status theatre.** "Continued working on the optimizer" tells nobody anything. Say
  what changed: "Found the yield bug, it is remnants being counted twice."
- If yesterday's note is missing, say so instead of guessing. A wrong standup is worse than
  an honest "I did not write yesterday down".
- Do not write anything into the vault. This skill only reads.

---
title: Convention — Projects
tags: [system, convention]
created: 2026-04-20
updated: 2026-08-18
---

# Projects

## What counts as a project

A project **ends**. If it does not end, it is an area and belongs in `03_areas/`.

- "Rewrite the cutting optimizer" → project, it ships and it is done
- "Answer support tickets" → area, it never stops
- "Onboard Glaswerk Nord" → project, they go live and it is over

If you cannot say what "finished" looks like, you do not have a project yet. Write it down
as a question instead.

## Folder layout

Each project gets its own folder in `02_projects/`:

```
02_projects/coffee_machine_api/
  coffee_machine_api_overview.md    ← always exists
  coffee_machine_api_tasks.md       ← always exists
  coffee_machine_api_findings.md    ← as needed
  coffee_machine_api_meeting_YYYY_MM_DD.md
```

The overview and the task list are mandatory. Everything else is created when there is
something to put in it.

## The overview page

Frontmatter carries `status` (`active`, `paused`, `done`) and `started`. The body answers
four questions, in this order:

1. **Goal** — one sentence, and what "done" means
2. **Status** — where it stands right now
3. **Decisions** — what was decided, and why. This is the part you will need in six months.
4. **Open questions** — what is still unclear and who can answer it

The decision log is the reason the project folder is worth keeping after the project ends.
Code lives in git; the reasoning lives here.

## Archiving

When a project is done: set `status: done`, write two lines about what worked and what did
not, and move the whole folder to `06_archive/projects/`. Do not delete it — the decisions
outlive the project, and the links pointing at it should keep working.

## Related

- [[task_conventions]]
- [[moc_development]]

---
title: Convention — Tasks
tags: [system, convention]
created: 2026-04-20
updated: 2026-08-18
---

# Tasks

## Syntax

Tasks are Markdown checkboxes. Nothing else, no plugin required to read them.

```markdown
- [ ] #priority/high Fix the cutting pattern rounding bug — Robin, blocked by [[marco_bevel]]
- [x] #priority/medium Write the API notes → [[rest_api_basics]] — done 2026-08-12
```

Order inside a task line: **checkbox, priority tag, what, who, context.**

## Priorities

| Tag | Means |
|---|---|
| `#priority/high` | blocks someone else, or has a date |
| `#priority/medium` | should happen this month |
| `#priority/low` | would be nice, no pressure |

Three levels only. A fourth level always becomes a second kind of "low".

## Where tasks live

**In the project or area they belong to**, never in a central list. The central list at
`00_system/my_tasks.md` is a *query* that collects them — it stores nothing itself.

This matters: a task written in the project keeps its context. The same task copied into a
to-do app loses the link to why it exists.

## Rules

- Name a person if someone else is involved, and link them: `[[nils_putty]]`
- If a task is waiting on someone, say so — "blocked by" is more useful than silence
- When you finish a task, tick it and add the date. Do not delete it. The finished list is
  the only honest record of where the time went, and the weekly report is built from it.
- A task older than a month that nobody has touched is not a task. Delete it or turn it
  into a note.

## Related

- [[project_conventions]]
- [[my_tasks]]

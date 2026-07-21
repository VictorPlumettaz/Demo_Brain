---
title: My Tasks
tags: [system, dashboard, tasks]
created: 2026-04-20
updated: 2026-08-22
---

# My Tasks

**This page stores nothing.** Every task below lives in the project or area it belongs to —
this is just a query that collects them. Tick a task here and it is ticked at the source.

Each block asks the same folder twice: once for what is open, once for what is done. Ticking a
task does not move it anywhere — the first query stops matching it, the second starts.

That is the whole point: a task keeps its context. The same task copied into a to-do app
loses the link to why it exists.

> [!note] Requires the Dataview plugin
> These are `dataview` blocks. Without the plugin they show as code.
> Obsidian's built-in **Bases** cannot replace them — Bases works at file level and reads
> frontmatter, and checkboxes live in the file *contents*. Task support is not on its roadmap.
> So this page is knowingly tied to a plugin whose last release was April 2025.
> A real dependency, written down rather than ignored. See [[obsidian]].

## High priority

```dataview
TASK
FROM "02_projects" OR "03_areas"
WHERE !completed AND contains(tags, "#priority/high")
```

## Cutting Optimizer Rewrite

```dataview
TASK
FROM "02_projects/cutting_optimizer_rewrite"
WHERE !completed
```

### Recently done

```dataview
TASK
FROM "02_projects/cutting_optimizer_rewrite"
WHERE completed
LIMIT 5
```

## Glaswerk Nord Onboarding

```dataview
TASK
FROM "02_projects/customer_onboarding_glaswerk_nord"
WHERE !completed
```

### Recently done

```dataview
TASK
FROM "02_projects/customer_onboarding_glaswerk_nord"
WHERE completed
LIMIT 5
```

## Coffee Machine API

```dataview
TASK
FROM "02_projects/coffee_machine_api"
WHERE !completed
```

### Recently done

```dataview
TASK
FROM "02_projects/coffee_machine_api"
WHERE completed
LIMIT 5
```

## Areas

```dataview
TASK
FROM "03_areas"
WHERE !completed
```

### Recently done

```dataview
TASK
FROM "03_areas"
WHERE completed
LIMIT 5
```

## Blocked — waiting on someone

```dataview
TASK
FROM "02_projects" OR "03_areas"
WHERE !completed AND contains(text, "blocked")
```

---

## Related

- [[task_conventions]] — syntax and the three priority levels
- [[index]]

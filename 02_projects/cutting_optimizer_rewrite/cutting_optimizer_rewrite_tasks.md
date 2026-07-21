---
title: Cutting Optimizer Rewrite — Tasks
tags: [project, tasks, optimizer]
created: 2026-05-11
updated: 2026-08-20
---

# Cutting Optimizer Rewrite — Tasks

Syntax and priorities: [[task_conventions]]. Actions that came out of a meeting stay in that
meeting note, not here — [[cutting_optimizer_rewrite_meeting_2026_08_04]].

## Open

- [ ] #priority/high Stop benchmark jobs 112, 118 and 203 regressing — Robin, worst is 4.1 points of yield below legacy
- [ ] #priority/high Get the remnant table schema — Robin, blocked by [[marco_bevel]] until he is off the 12.1 hotfix (back 2026-08-25)
- [ ] #priority/medium Implement free-form nesting for laminated stock — Robin, only guillotine cuts work today
- [ ] #priority/medium Ask [[priya_tempered]] for a benchmark set with low-E coated glass — Robin, current 240 jobs contain none
- [ ] #priority/low Write down the `.opt` file format → [[cutting_optimizer]] — Robin, it currently exists only in Marco's head

## Done

- [x] #priority/high Put the legacy engine behind an interface so both engines can run — done 2026-06-05
- [x] #priority/high Build the 240-job benchmark set from real customer exports — Robin with [[priya_tempered]], done 2026-06-19
- [x] #priority/medium Decide the implementation language → [[cutting_optimizer_rewrite_decisions]] — done 2026-05-19
- [x] #priority/medium Add the `optimizer.v2` feature flag to PaneFlow config — done 2026-07-02
- [x] #priority/low Understand the engine factory well enough to change it → [[dependency_injection]] — done 2026-07-16

## Related

- [[cutting_optimizer_rewrite_overview]]
- [[my_tasks]]

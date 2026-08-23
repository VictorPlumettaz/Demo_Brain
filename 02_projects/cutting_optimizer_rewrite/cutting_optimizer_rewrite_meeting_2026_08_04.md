---
title: Cutting Optimizer Rewrite — Design Review, 4 August 2026
tags: [project, meeting, optimizer]
created: 2026-08-04
updated: 2026-08-05
---

# Design Review — 4 August 2026

45 minutes, meeting room 2. Called because remnant support came back into scope on 28 July and
the release plan no longer worked.

**Attendees:** [[dana_frames]], [[marco_bevel]], [[priya_tempered]], Robin.

## Decisions

| Decision | Reason |
|---|---|
| Release target moves from PaneFlow 12.2 to 12.3 | 12.2 freezes 2026-09-14. Remnant handling will not be ready and tested by then. Roughly six weeks later. |
| The benchmark runs in CI on every merge into main | Priya will not sign off on results from a run somebody did on a laptop. Fair. |
| Every change to the `.opt` writer goes through Marco | Customer saw controllers parse that file directly. A broken file stops a plant cutting, and one customer runs a 2009 controller with no update path. |
| Glaswerk Nord goes live on the legacy engine | Their go-live is 5 October, 12.3 is Q1 2027. Nothing to discuss, but it had to be said out loud. |

Marco's position on the regressing benchmark jobs, recorded because I want to check it later:
all three are jobs with mixed thickness in one batch, and the legacy engine sorts by thickness
before it does anything else. He thinks the new engine does not. I have not verified this.

Dana's summary at the end: "yield is fine, the pattern is ugly" — meaning the new engine finds
good numbers but produces cutting patterns that a saw operator would look at twice. Not a
blocker for 12.3, but it goes on the list.

## Actions

- [ ] #priority/high Move the benchmark run into CI — Robin, needs a build agent with 16 GB RAM from [[nils_putty]]
- [ ] #priority/medium Check Marco's thickness-sorting theory against jobs 112, 118 and 203 — Robin
- [ ] #priority/medium Tell [[lena_mullion]] that Glaswerk Nord goes live on the legacy engine — Dana
- [x] #priority/medium Update the release plan to 12.3 and tell product — Dana, done 2026-08-05

## Related

- [[cutting_optimizer_rewrite_overview]]
- [[cutting_optimizer_rewrite_decisions]]
- [[glaswerk_nord_overview]]

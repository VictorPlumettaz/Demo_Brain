---
title: Cutting Optimizer Rewrite
tags: [project, development, optimizer, paneflow]
status: active
started: 2026-05-11
created: 2026-05-11
updated: 2026-08-20
---

# Cutting Optimizer Rewrite

Replacing the nesting engine inside [[cutting_optimizer]], the part of [[paneflow]] that works
out how to cut a batch of customer orders out of full sheets of float glass with as little
waste as possible. The current engine was written in 2012. Nobody who wrote it still works at
[[pane_relief_software]].

Owner: [[robin_sill|me]]. Reviewer: [[marco_bevel]]. Sponsor: [[dana_frames]].

## Goal

One new engine. Same inputs, same output file, better yield — yield being the share of a sheet
that leaves the plant as a saleable lite, a lite being one finished piece of glass.

**Done means all four of these:**

- the new engine matches or beats the legacy yield on all 240 jobs in the benchmark set
- a 500-lite batch optimises in under 30 seconds (legacy: two to four minutes)
- it writes the same `.opt` pattern file the saw controllers already read, byte for byte
- it ships as the default in PaneFlow 12.3, with the legacy engine still available behind a
  flag for one release

Not in scope: a new user interface. That is a different project and it does not exist yet.

## Status — 2026-08-20

Roughly two thirds. Honest version:

| Piece | State |
|---|---|
| Legacy engine behind an interface | done, both engines run side by side |
| Guillotine cuts (straight edge to edge) | working, beats legacy on 231 of 240 jobs |
| Free-form nesting for laminated stock | not started |
| Remnant handling | back in scope since 28 July, schema not final |
| Benchmark run in CI | not yet, needs a build agent from [[nils_putty]] |
| Low-E coating orientation | not started, and I do not understand it yet |

Three benchmark jobs regress badly — 112, 118 and 203. The worst is 4.1 percentage points of
yield below legacy, which for a plant the size of Glaswerk Nord is roughly one extra sheet of
float glass per shift turned into cullet, the broken glass that goes back to the furnace.

The legacy engine is one file, `Optimizer.cs`, 6,200 lines, with a 400-line method called
`DoIt()`. Marco says it has been correct since about 2015 and that this is not the same thing
as being understood.

## Decisions

Short version. The full reasoning, including what was rejected, is in
[[cutting_optimizer_rewrite_decisions]].

| Date | Decision | One-line reason |
|---|---|---|
| 2026-05-19 | Stay in C# | the team maintains it for ten years, and the team writes C# |
| 2026-05-26 | Feature flag `optimizer.v2`, not a long branch | see [[legacy_report_export_retrospective]] |
| 2026-06-02 | Keep the `.opt` output format unchanged | customer saw controllers parse it directly |
| 2026-06-11 | Golden-master tests, not unit tests, for the engine core | nobody can state the correct answer, but we know last week's answer |
| 2026-07-14 | Remnants out of scope for v1 — **reversed 2026-07-28** | the reversal is the useful entry, read that one |

## Open questions

1. **Why does the yield calculation ignore remnants?** I still do not understand this. The
   legacy code subtracts remnant area from the sheet and then adds it back three methods later,
   so the net effect is nothing. Marco's answer is "because in 2012 nobody sold remnants", which
   explains the intent but not the code. Someone wrote both halves on purpose.
2. **Low-E coating orientation.** Low-E is a thin metallic coating on one face of the glass. Every
   lite cut from one sheet has the coating on the same side, and the order says which side it
   has to end up on. The legacy engine handles this somewhere and I have not found where.
   Asked Marco, he said "later".
3. **Does Glaswerk Nord get the new engine at go-live?** No — decided on
   [[cutting_optimizer_rewrite_meeting_2026_08_04|4 August]]. Open part: whether they have
   actually been told. [[lena_mullion]] was going to.
4. **Who owns the `.opt` writer after this ships?** Right now Marco owns it informally, which
   means it is owned by one person and written down nowhere.

## Related

- [[cutting_optimizer_rewrite_tasks]]
- [[cutting_optimizer_rewrite_decisions]]
- [[cutting_optimizer_rewrite_meeting_2026_08_04]]
- [[cutting_optimizer]]
- [[glossary_glass_industry]]
- [[moc_development]]

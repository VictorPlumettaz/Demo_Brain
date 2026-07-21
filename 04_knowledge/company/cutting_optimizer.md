---
title: Cutting Optimizer
tags: [knowledge, company, product, algorithm]
created: 2026-04-24
updated: 2026-08-21
source: Marco Bevel, the module docs from 2018, and reading up on guillotine cutting
---

# Cutting Optimizer

The cutting optimizer is the part of [[paneflow]] that decides how to cut the panes a customer
ordered out of the large stock sheets we have in the warehouse, wasting as little glass as
possible.

It matters more than anything else in the product. Glass is the plant's largest material cost,
and the optimizer decides how much of it ends up in a skip. One percentage point of yield at a
mid-size plant is real money every week — which is also why it is the module being rewritten
→ [[cutting_optimizer_rewrite_overview]].

## The problem in plain terms

**In:** a list of rectangles. Each one is a **lite** — a single pane — with a width, a height,
a glass type, a thickness and a quantity. Plus the stock sheet formats available, typically a
**jumbo** sheet at 6000 × 3210 mm or a divided format around 3210 × 2250 mm.

**Out:** for each sheet, where every lite sits on it. Plus the leftover pieces, the cutting
sequence, and the expected yield.

Textbook name: two-dimensional bin packing, or nesting. Place small rectangles into as few
large rectangles as possible. It is NP-hard, so nobody computes the true optimum — you run a
heuristic against a time budget and take the best answer it found.

## Why it is not just packing rectangles

Glass is not sawn. A wheel **scores** the surface, and the sheet is then **snapped** along that
score. A score has to run from one edge of the piece to the opposite edge, so every break
splits one rectangle into exactly two rectangles.

That is the **guillotine constraint**, and it throws away most of what a general nesting
algorithm would produce. A layout where a small pane sits in a pocket surrounded by three
others is fine on paper, cuttable by a waterjet, and impossible on a cutting table.

Three more things that surprised me:

- **There is almost no kerf.** A saw eats 3–4 mm of material per cut. A scoring wheel eats
  well under a millimetre. Reuse a wood-cutting optimiser here and it will add sheets that
  are not needed.
- **A bad snap destroys the whole piece.** Wood gives you a shorter board. Glass gives you a
  floor to sweep.
- **Nothing can be cut after tempering.** Toughened glass shatters if you score it. Every size
  decision has to be right before the pane goes in the oven → [[glossary_glass_industry]].

## The constraints that shape the answer

| Constraint | Effect on the layout |
|---|---|
| Guillotine cuts only | Every pattern is a recursive split into two, all the way down |
| Stage limit | The table can do a limited number of cut stages. Two- or three-stage patterns only, however clever a deeper one would be |
| One material per sheet | Only lites with identical glass type, thickness and coating share a sheet |
| Rotation | Clear float may turn 90°. Coated, patterned or printed glass may not — the coating has to end up on a defined surface and patterns run in one direction |
| Edge trim | The stock sheet's own edges are chipped. A few millimetres come off all round before anything useful is cut |
| Minimum handling size | A strip too narrow to lift safely is not a remnant, it is waste |
| Delivery dates | A lite due Thursday cannot wait for a batch that would cut it beautifully next Tuesday |

The "one material per sheet" rule is why optimisation runs against a **batch** and not against
an order. A batch collects lites from many orders that happen to need the same glass.

## Yield, remnants and cullet

- **Yield** — ordered area divided by consumed sheet area, as a percentage. Everything the
  optimizer does is judged by this number. Glaswerk Nord reports 84–88 % on clear float and
  noticeably less on coated batches, from [[lena_mullion|Lena]]'s quarterly call notes.
- **Remnant** — a leftover piece large enough to be worth keeping, put back into stock for a
  later batch. Because of the guillotine rule a remnant is always a clean rectangle, which is
  the one convenience the constraint gives us.
- **Cullet** — broken and scrap glass. It gets recycled back into the furnace, so it is not
  worthless, but it is worth a fraction of a pane.

A remnant only counts as saved glass if it is actually consumed later. A plant with a warehouse
full of remnants nobody cuts from has not saved anything, it has moved the waste onto a rack.
Scoring remnants as if they were free is the classic way to make a yield report look good and
the material bill stay flat.

## What the current implementation does

Written by [[marco_bevel|Marco]] in 2017, C#, single process.

1. Group the lites into batches by material.
2. Sort by area, largest first.
3. Build the sheet as horizontal strips — a shelf heuristic, which is guillotine-friendly by
   construction: cut a strip off the top, fill it left to right, repeat.
4. Improve with local search — swap, rotate where allowed, re-strip — until the time budget
   runs out. Default 30 seconds per batch.
5. Return the best pattern set found and whatever remnants it produced.

## What I still do not understand

- Why it sometimes returns a pattern with a *worse* yield. Marco says priority and delivery-date
  weights outrank yield in the score. I have not found where in the code that happens.
- How remnant re-use is scored. If the number is too generous the optimizer will happily
  manufacture remnants forever.
- Whether the 30-second budget is a real tuning decision or a number somebody typed in 2017.
  Derived guess, not verified: the second one.

## Related

- [[paneflow]]
- [[cutting_optimizer_rewrite_overview]]
- [[cutting_optimizer_rewrite_decisions]]
- [[glossary_glass_industry]]
- [[marco_bevel]]

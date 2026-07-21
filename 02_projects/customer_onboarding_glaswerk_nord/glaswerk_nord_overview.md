---
title: Customer Onboarding — Glaswerk Nord
tags: [project, customer, onboarding, paneflow]
status: active
started: 2026-06-22
created: 2026-06-22
updated: 2026-08-19
---

# Customer Onboarding — Glaswerk Nord

Glaswerk Nord GmbH in Hamburg goes live on [[paneflow]] on **Monday 5 October 2026**. They are
replacing an in-house system called Glasplan that has run their plant since 2012.

[[lena_mullion]] owns the customer relationship and the plan. My part is the data migration: I
write the import, run it, and explain what came out. [[nils_putty]] does the access and the
server side.

## The plant

Worth knowing, because it explains most of the decisions below.

| | |
|---|---|
| Location | Hamburg, one site |
| Volume | around 19,000 lites a week — a lite is one finished piece of glass |
| Lines | two tempering furnaces, one laminating line, one IGU line |
| Old system | Glasplan, in-house, Access front end on a SQL Server |
| Users | 34, of which about 20 stand at a machine and not at a desk |

Tempering means heating a lite to roughly 620 °C and cooling it fast, so it ends up four to five
times stronger and breaks into blunt pieces instead of shards. Laminating bonds two lites with a
plastic interlayer. An IGU — insulating glass unit — is two or three lites with a sealed gap
between them. Definitions live in [[glossary_glass_industry]]; I keep having to look them up.

## Goal

Glaswerk Nord runs their production on PaneFlow with their own data in it.

**Done means:**

- one full week of production run entirely in PaneFlow, with no fallback to Glasplan
- their first month-end invoice run closes without manual correction
- Glasplan is read-only and nobody has asked to write to it for two weeks

## Status — 2026-08-19

On plan, with one real risk.

| Workstream | State |
|---|---|
| Customer and address master | migrated and checked, 1,240 records |
| Article master | first dry run done 12 August — 4,100 rows in, 812 rejected |
| Glass type codes | 340 distinct codes, 222 mapped by hand, 118 left |
| Order history | not started, waiting on the code mapping |
| Training | 22 and 23 September, on site, booked |
| Cutover | weekend of 3/4 October, runbook not written yet |

**The risk:** the 812 rejected articles. Glasplan stored the glass type as free text, so
"ESG 6mm", "ESG 6", "6mm ESG" and "esg6" are four articles that are one article. I do not yet
know how many of the 812 are duplicates and how many are real articles my mapping does not
cover. Until that number exists, the order history cannot be migrated, because orders point at
articles.

## Decisions

**Migrate three years of order history, not fourteen** — 2026-08-06. They asked for all fourteen.
The reason they gave was "we look things up". Lena pulled their actual lookup log: every lookup
in the last year landed inside 18 months. The remaining eleven years go into a read-only CSV
export they keep on their own file server. Rejected: migrating everything, which triples the
import time and drags fourteen years of bad glass type codes into a clean system.

**Map glass type codes by hand, not by fuzzy matching** — 2026-07-28. 340 codes, about four
evenings of work. A fuzzy match that gets "ESG" and "VSG" confused sends a laminated lite into a
tempering furnace, and a wrong furnace recipe is scrap glass at best. Rejected: a similarity
script with a review step, because the review step is the same four evenings and I would trust
the result less.

**Training on site, not remote** — 2026-07-14. Twenty of their 34 users work standing at a
machine. Lena was firm about this and I did not have an argument.

**Go live on a Monday, not a Friday** — 2026-06-30. If Monday goes wrong we have five working
days and everyone is in the building. If Friday goes wrong, the plant has a weekend of orders it
cannot cut.

## Open questions

1. **Who signs off the migrated data?** Nobody has agreed to this. It needs to be someone at
   Glaswerk Nord who is willing to say "yes, these are our articles". Lena is asking.
2. **Low-E stock codes do not record which side is coated.** Low-E is a metallic coating on one
   face of the glass, and the coated face has to end up on the correct side of an IGU. Their
   codes do not say. Asked their production manager on 6 August, no answer yet. If the answer is
   "the operators just know", that is a problem we inherit on 5 October.
3. **Do they get the new optimizer?** No. They go live on the legacy engine — see
   [[cutting_optimizer_rewrite_overview]]. Whether they have been told is still open.
4. **Remnant stock.** Their remnant rack covers about 11 percent of their float glass demand,
   which is the number that reversed a decision in the other project. What I do not know is
   whether the Glasplan export contains the rack at all.

## Related

- [[glaswerk_nord_tasks]]
- [[glaswerk_nord_meeting_2026_08_06]]
- [[paneflow]]
- [[glossary_glass_industry]]
- [[product_support_overview]]

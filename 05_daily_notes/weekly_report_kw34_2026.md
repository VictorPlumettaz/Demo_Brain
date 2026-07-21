---
title: Weekly Report KW34 2026
tags: [weekly-report, kw34]
week: 34
from: 2026-08-17
to: 2026-08-23
hours: 40.0
created: 2026-08-21
updated: 2026-08-21
---

# Weekly Report KW34 2026

Apprentice: Robin Sill, second year
Department: Product development, PaneFlow core team
Period: 17 August – 23 August 2026

## Record of activities

| Day | Date | h | Activity |
|---|---|---|---|
| Mon | 17 Aug | 8.0 | Found the root cause of the yield defect together with the senior developer: the area of a reusable remnant is added to the total twice, once when the cutting pattern is committed and once when the remnant is returned to stock. Established and documented the condition under which the defect occurs (at least one remnant above the plant reuse threshold), which explains why it never appeared in the internal test data. Sprint planning for 17–28 August. |
| Tue | 18 Aug | 8.0 | Fixed the defect. The run summary now reports yield, waste and recovered material as three separate figures instead of one percentage — a change QA had requested in July. Added the QA test batch to the repository as a fixture and wrote a regression test that fails against the old code. QA re-ran all three affected batches; figures now match the existing engine. |
| Wed | 19 Aug | 8.0 | Customer onboarding: go-live confirmed for 5 October, cutover on the weekend of 3/4 October, followed by two weeks of parallel operation. Deploy freeze agreed for 2–6 October. Import profiles now carry an explicit encoding per file and reject a file that fails the validation check instead of importing it silently. Re-imported all nine files; the 1,143 affected records are correct. |
| Thu | 20 Aug | 8.0 | Pull request merged after review. Two changes from the review: a rename, because the old name no longer described the value, and moving a threshold into the existing plant configuration instead of holding it as a constant in the calculation. Rebuilt the staging database from the corrected import (480 customers, approx. 31,000 order lines) and hand-checked twenty records with customer success against the customer's own system. |
| Fri | 21 Aug | 8.0 | Second-line support rota: four tickets, all matching documented patterns; added one new pattern (weekly reindex job overlapping the first shift on Monday mornings). Weekly report. Planned the performance work on the packing loop for the coming sprint (currently 12 s for a 400-part batch). |
| | **Total** | **40.0** | |

## What I learned this week

- Two questions before opening the code: does it fail always or only sometimes, and what do the
  failing cases have in common. I worked in the opposite order and it cost me two days on a defect
  that took ten minutes once the question was asked properly.
- A four-line fix protected by a regression test is worth considerably more than the fix on its own.
  The test carries the reason the defect existed, which the fix does not.
- Review is not a formality. It found a configuration value I had recreated as a constant although it
  already existed in the plant configuration.
- Splitting one number into three (yield, waste, recovered) made the calculation easier to check and
  easier to explain to the customer. One aggregated figure hides the disagreement instead of
  resolving it.

## Source notes

- [[2026_08_17]] · [[2026_08_18]] · [[2026_08_19]] · [[2026_08_20]] · [[2026_08_21]]

## Signatures

| | Name | Date |
|---|---|---|
| Apprentice | Robin Sill | 2026-08-21 |
| Trainer | Dana Frames | |

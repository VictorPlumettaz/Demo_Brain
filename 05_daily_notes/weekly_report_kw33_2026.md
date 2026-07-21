---
title: Weekly Report KW33 2026
tags: [weekly-report, kw33]
week: 33
from: 2026-08-10
to: 2026-08-16
hours: 38.0
created: 2026-08-14
updated: 2026-08-14
---

# Weekly Report KW33 2026

Apprentice: Robin Sill, second year
Department: Product development, PaneFlow core team
Period: 10 August – 16 August 2026

## Record of activities

| Day | Date | h | Activity |
|---|---|---|---|
| Mon | 10 Aug | 8.0 | Sprint work on the cutting optimizer rewrite. Took over a defect on the yield calculation from QA: the new engine reports different figures from the existing engine, one batch above 100%. Reviewed the three reported cases and ran the new engine against the internal test data. Unpacked and checked the customer data export for the Glaswerk Nord onboarding (9 files, approx. 12,400 article records). |
| Tue | 11 Aug | 8.0 | Defect analysis, yield calculation. Compared commit, build configuration, plant configuration and database between the QA environment and my own — no difference found, defect not reproducible locally. Added structured logging around the calculation so that intermediate totals are visible in the run output. |
| Wed | 12 Aug | 8.0 | Customer data migration: found a character encoding problem in the customer export. Source files are Windows-1252, our import assumes UTF-8; 1,143 records across 4 of 9 files affected. Documented the finding and handed it to customer success for clarification with the customer. Continued defect analysis on the yield calculation. |
| Thu | 13 Aug | 8.0 | Narrowed the yield defect to the run aggregation: the area per cutting pattern is correct, the total over the run is not. Team retrospective (every second Thursday). Code review of a colleague's change. Confirmed with customer success that the customer's source system can only export Windows-1252, so the conversion has to happen on our side. |
| Fri | 14 Aug | 6.0 | Second-line support rota: three tickets (export separator and locale, remnant reuse threshold, session after password change). All three matched documented patterns and were closed the same day. |
| | **Total** | **38.0** | |

## What I learned this week

- A measured value that is **impossible** is more useful than one that is merely wrong. 101.6% yield
  cannot be a rounding argument — it means something is counted twice. That narrowed the search on
  day one.
- Character encoding has to be **declared, not guessed**. Nobody had written down what encoding an
  import file is expected to be in, so both sides assumed the obvious one and assumed differently.
- I could not reproduce the defect on my own test data all week. My test data is regular where the
  customer's is not, and code that is only ever run against tidy input is not really tested.
- Structured logging pays off when you can read the intermediate values, not only the result. It told
  me the error was in the aggregation and not in the packing, which removed most of the code from the
  search.

## Source notes

- [[2026_08_10]] · [[2026_08_11]] · [[2026_08_12]] · [[2026_08_13]] · [[2026_08_14]]

## Signatures

| | Name | Date |
|---|---|---|
| Apprentice | Robin Sill | 2026-08-14 |
| Trainer | Dana Frames | |

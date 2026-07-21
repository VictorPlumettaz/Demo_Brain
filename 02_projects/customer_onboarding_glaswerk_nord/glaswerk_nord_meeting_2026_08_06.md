---
title: Glaswerk Nord — Customer Call, 6 August 2026
tags: [project, meeting, customer, onboarding]
created: 2026-08-06
updated: 2026-08-07
---

# Customer Call — 6 August 2026

50 minutes, video call. Second of the fortnightly onboarding calls.

**From us:** [[lena_mullion]], Robin.
**From Glaswerk Nord:** Anke Vogel (production manager), Timo Reiss (IT).

## Decisions

| Decision | Reason |
|---|---|
| Migrate three years of order history, not fourteen | Lena had pulled their lookup log beforehand. Every lookup in the last year was inside 18 months. Anke agreed on the call. |
| The remaining eleven years go into a read-only CSV export on their file server | Timo will host it. Nobody has to migrate it and nobody loses it. |
| Training on 22 and 23 September, on site, two groups | Anke wants the saw and furnace operators in the morning groups, before the shift gets busy. |
| Go-live stays 5 October | Confirmed by both sides. No reason to move it. |

## Open, taken away

**Low-E coated side.** I asked how their article codes record which face of the glass carries the
low-E coating — the thin metallic layer that has to end up on the correct side of an insulating
glass unit. Anke said she would check with the IGU line. No answer yet as of 19 August. This is
open question 2 in [[glaswerk_nord_overview]] and it does not get less important.

**812 rejected articles.** I explained the free-text glass type problem. Anke was not surprised
and said "we know, that is why we are replacing it", which was a better reaction than I expected.
Timo will send the internal list of codes their own people actually use, which may be far fewer
than 340.

## Note to self

Anke asked whether PaneFlow can print their old label layout. Lena said yes before I could say I
did not know. She was right — it is a template file, nobody has touched it since 2023, and it is
in the standard install. I looked it up afterwards.

Lesson: I would have said "I will check", which is honest and correct and would have left the
customer worrying for two weeks about a thing that was never a problem. Knowing the product well
enough to answer on the call is worth something. Writing down what I did not know is how I get
there.

## Actions

- [ ] #priority/high Chase Anke Vogel on the low-E coated side — [[lena_mullion]], before the next call
- [ ] #priority/medium Compare Timo's list of live codes against my 340 — Robin, may cut the mapping work in half
- [x] #priority/medium Send Anke the training agenda and the two group lists — Lena, done 2026-08-07

## Related

- [[glaswerk_nord_overview]]
- [[glaswerk_nord_tasks]]
- [[paneflow]]

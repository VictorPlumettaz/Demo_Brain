---
title: "Invoice INV-2026-0042 — Glaswerk Nord GmbH"
tags: [billing, invoice, example, customer]
invoice_number: INV-2026-0042
customer: Glaswerk Nord GmbH
date: 2026-08-31
period: 2026-08-06 – 2026-08-31
net: 2675.00
vat: 508.25
gross: 3183.25
status: draft
created: 2026-08-21
updated: 2026-08-21
---

# Invoice INV-2026-0042 — Glaswerk Nord GmbH

The worked example for `/invoice`: onboarding services for [[glaswerk_nord_overview]] in August
2026. This is the **source** the PDF is rendered from. Every line below points at the note that
proves it happened.

Invoice date 31 August 2026 · service period 6 – 31 August 2026 · payment 14 days net, due
14 September 2026 · customer number GN-1042 · reference PO-2026-0338.

**Bill to:** Glaswerk Nord GmbH, Accounts Payable, Am Glaskai 7, 21109 Hamburg, Germany ·
VAT ID DE987654321. Held here because the customer has no page in `04_knowledge/` yet — the
first of the edge cases in `SKILL.md`. Fourth invoice for them, fourth time the address was
retyped — well past the point where the page should exist.

The period starts on 6 August because 1 – 5 August was already billed as a milestone on
INV-2026-0041. Periods must not overlap — see [[invoice_ledger]].

## Items

| # | Item | Qty | Unit | Rate EUR | Amount EUR | Comes from |
|---|---|---|---|---|---|---|
| 1 | Data migration — article and customer master | 2.0 | days | 850.00 | 1,700.00 | [[2026_08_10]] · [[2026_08_12]] · [[2026_08_19]] · [[2026_08_20]] |
| 2 | Go-live preparation | 0.5 | days | 850.00 | 425.00 | [[2026_08_19]] |
| 3 | Onboarding coordination | 0.5 | days | 1,100.00 | 550.00 | [[glaswerk_nord_meeting_2026_08_06]] |

**Item 1** — intake and check of the nine Glasplan export files, 12,400 article rows (10 Aug).
Article master dry run into staging, 4,100 rows, character encoding fault traced across 1,143
records (12 Aug). Re-import of all nine files after the encoding correction, including spot checks
(19 Aug). Staging rebuild and joint verification of twenty records with the customer (20 Aug).

**Item 2** — go-live confirmed for 5 October 2026, cutover window 3/4 October, deploy freeze
2–6 October agreed and scheduled (19 Aug).

**Item 3** — the fortnightly onboarding call of 6 August and its follow-up: order history scope,
training dates 22/23 September, handover of the customer's live code list. [[lena_mullion]].

Each half day is a day on which the daily note records both customer work and internal work. The
four migration half days are 10, 12, 19 and 20 August; 19 August carries a second half day for
go-live preparation, which makes it one full billed day.

## Totals

| | EUR |
|---|---|
| Net | 2,675.00 |
| VAT 19% | 508.25 |
| **Gross** | **3,183.25** |

Check: 1,700.00 + 425.00 + 550.00 = 2,675.00. 2,675.00 × 0.19 = 508.25. 2,675.00 + 508.25 =
3,183.25.

## Not billed

Deliberate omissions. They are written down so the next invoice does not have to rediscover them.

| Work | Why not |
|---|---|
| Glass type code mapping, 222 codes mapped by hand | Real work, but no note says which days it fell on. Confirm the days with [[lena_mullion]], then bill it on the next invoice |
| Second-line support tickets, 14 and 21 August | Covered by the support contract, not by onboarding → [[product_support_overview]] |
| On-site training, 22 and 23 September | Booked, not delivered. Bills in September |
| Yield defect in the [[cutting_optimizer_rewrite_overview]] | Product work. It is not this customer's, even though it took most of both weeks |

## Status

Draft. The period runs to 31 August and the vault records nothing after 21 August, so the
quantities are provisional. Confirm with Lena, then set `status: sent` here and in
[[invoice_ledger]] on the same day.

## Rendering it

Fill `invoice_template.html`, render with headless Edge, file the PDF outside git. The exact
commands are in `SKILL.md` § 4–6. Rendered from this file the invoice is one A4 page.

## Related

- [[invoice_ledger]]
- [[billing_overview]]
- [[glaswerk_nord_overview]]
- [[lena_mullion]]

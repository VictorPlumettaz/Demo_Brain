---
title: Invoice Ledger
tags: [area, billing, register]
created: 2026-06-30
updated: 2026-08-21
---

# Invoice Ledger

Every service invoice ever issued, one row each, oldest first.

**This table is the truth, not the PDFs.** A PDF can be re-rendered, moved, deleted or sit in
someone's downloads folder in three versions; the number it carries proves nothing about whether
that number was ever issued twice. The ledger is one file, in git, with a history — so the next
number is whatever is at the bottom of it, plus one.

## Register

| Number | Date | Customer | Period | Net EUR | VAT 19% | Gross EUR | Status |
|---|---|---|---|---|---|---|---|
| INV-2026-0039 | 2026-06-30 | Glaswerk Nord GmbH | 2026-06-22 – 2026-06-30 | 1,700.00 | 323.00 | 2,023.00 | paid |
| INV-2026-0040 | 2026-07-31 | Glaswerk Nord GmbH | 2026-07-01 – 2026-07-31 | 4,250.00 | 807.50 | 5,057.50 | paid |
| INV-2026-0041 | 2026-08-05 | Glaswerk Nord GmbH | 2026-08-01 – 2026-08-05 | 2,550.00 | 484.50 | 3,034.50 | paid |
| INV-2026-0042 | 2026-08-31 | Glaswerk Nord GmbH | 2026-08-06 – 2026-08-31 | 2,675.00 | 508.25 | 3,183.25 | draft |

Invoiced in 2026 so far: 11,175.00 net, 2,123.25 VAT, 13,298.25 gross. Of that, 2,675.00 net is
still a draft.

**Next free number: INV-2026-0043.**

## What each one was

- **0039** — kickoff week for [[glaswerk_nord_overview]]: plant survey in Hamburg, migration plan,
  export specification for their Glasplan system. Two days.
- **0040** — July: glass type code mapping by hand (222 of 340 codes), VPN and database access to
  their test server with [[nils_putty]], planning for the September training. Five days.
- **0041** — milestone, fixed price: customer and address master imported and checked, 1,240
  records. Invoiced on completion, which is why August is split across two invoices.
- **0042** — August data migration and go-live preparation. Draft →
  `00_system/skills/invoice/example_invoice.md`.

## Rules

1. **The row is written when the number is taken**, before the PDF exists. A number on disk that
   is not in this table will be handed out a second time.
2. **Nothing here is ever renumbered or deleted.** A wrong invoice keeps its number, gets status
   `credited`, and the credit note takes the next free number and its own row.
3. **Periods must not overlap** for the same customer. Two rows covering 5 August means the
   customer was billed twice for the same day, and their system will book it twice.
4. **Status changes are edits to this file**, not to the invoice. `sent` and later, the invoice
   document itself is frozen.
5. Amounts here must match the invoice source in `03_areas/billing/invoices/` exactly. If they
   disagree, the invoice that went to the customer wins, and the ledger is corrected in the same
   session.

## Related

- [[billing_overview]]
- [[glaswerk_nord_overview]]
- [[lena_mullion]]
- `00_system/skills/invoice/SKILL.md`

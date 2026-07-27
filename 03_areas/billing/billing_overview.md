---
title: Billing — Overview
tags: [area, billing, customer, onboarding]
created: 2026-06-24
updated: 2026-08-21
---

# Billing

Onboarding and migration services are invoiced by hand, once a month, out of what the vault
records. This page holds the rates, the rhythm and who does which part.

It is an area and not a project because it does not end: as long as a customer is onboarding,
there is an invoice at the end of every month → [[project_conventions]].

## What is billed here, and what is not

| Billed here | Billed elsewhere |
|---|---|
| Data migration, imports, verification | Licences — the ERP raises those |
| Onboarding calls and coordination | The support contract, including my Friday rota → [[product_support_overview]] |
| On-site training | Product development. A defect in [[paneflow]] is ours, not the customer's |
| Cutover and go-live support | Anything for a different customer |

We invoice our own customers out of the invoicing module of the product we sell. Service work is
the exception, because it has no fixed monthly amount and no article number — it is days, and the
days are in the daily notes.

## Rates

Agreed in the onboarding contract. **The contract is not in this vault** — [[lena_mullion]] has
it. If a rate here and the contract disagree, the contract wins and this table gets corrected.

| Service | Unit | Rate |
|---|---|---|
| Data migration and engineering | day | 850.00 EUR |
| Onboarding coordination, customer calls | day | 1,100.00 EUR |
| On-site training | day | 1,250.00 EUR plus travel at cost |
| Weekend and out-of-hours work, e.g. a cutover | day | rate + 50% |

Billed in **half days**. Anything smaller is not worth the argument, and anything the daily note
cannot place on a day is not billed at all.

VAT 19%. Payment 14 days net from the invoice date.

## Rhythm

- **Last working day of the month** — invoice for that month, from the daily notes of that month.
- **On completion** — a milestone agreed as a fixed price can be invoiced when it completes, in
  the middle of the month. The monthly invoice then starts the day after, so the periods do not
  overlap. That is why INV-2026-0041 exists on 5 August and INV-2026-0042 starts on the 6th.
- **First working day of the month** — check the ledger for anything still `sent` and past its
  due date.

## Who does what

| Step | Who |
|---|---|
| Collect the work, prepare the invoice, render the PDF | Robin, with `/invoice` |
| Check it against the contract, send it to the customer | [[lena_mullion]] — she owns the relationship, so she owns what the customer receives |
| Book the payment, set the status to `paid` | Accounts, Hanover |
| Keep the ledger correct | Robin |

Lena sees every invoice before it leaves. She reads it the way the customer will: if a line does
not say what it bought, it comes back to me, and that is cheaper than it coming back from them.

## Numbering

`INV-<year>-<four digits>`, sequential, one range for all service invoices. The next number comes
out of [[invoice_ledger]] and nowhere else. Numbers are never reused, never renumbered, and a
cancelled invoice keeps its number and gets a credit note.

## Status vocabulary

| Status | Means |
|---|---|
| `draft` | prepared, not sent. Numbers can still change |
| `sent` | with the customer. Nothing in it may be edited any more |
| `paid` | money arrived, date checked by accounts |
| `overdue` | past the due date, unpaid. Lena chases, not me |
| `credited` | cancelled by a credit note. The credit note has its own number and its own row |

## Related

- [[invoice_ledger]]
- [[glaswerk_nord_overview]]
- [[lena_mullion]]
- [[product_support_overview]]
- `00_system/skills/invoice/SKILL.md` — the procedure that produces the PDF

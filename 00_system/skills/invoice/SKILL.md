---
name: invoice
description: Build a customer invoice as a PDF out of what the vault already records — line items from the project and the daily notes, the number from the ledger. Use when the user says "invoice", "write an invoice", "bill the customer", or "/invoice".
---

# Invoice

Turn recorded work into a document a customer can pay. The work is already written down in
`02_projects/` and `05_daily_notes/`; this skill collects it, numbers it, renders it to PDF and
files the number in the ledger.

## Why this exists

Three reasons, in the order they cost money.

1. **An invoice is checked by someone whose job is checking it.** A wrong total, a missing tax
   number or a duplicate invoice number comes straight back, and it comes back to a person who
   now trusts the next invoice less.
2. **The evidence goes stale.** Six weeks after the work, nobody remembers whether the re-import
   was half a day or a day. The daily note remembers. Billing from the vault instead of from
   memory is the entire point.
3. **The numbering has to survive people.** Sequential, gapless, never reused — that is a rule an
   auditor checks and a human forgets. The ledger is how it survives.

## Steps

### 1. Collect the facts

Ask for the customer and the period if they were not given. Then read, in this order:

| What | Where it comes from |
|---|---|
| Customer name, address, VAT ID, customer number | the customer's page in `04_knowledge/company/` or the project overview |
| Project name, what was agreed, what was delivered | `02_projects/<project>/<project>_overview.md` and `_tasks.md`, section **Done** |
| Which day held which work | every `05_daily_notes/YYYY_MM_DD.md` inside the period |
| Cross-check of days and hours | `05_daily_notes/weekly_report_kw<NR>_<YEAR>.md` for the weeks in the period |
| Meetings and calls that are billable | `<project>_meeting_YYYY_MM_DD.md` |
| Day rates, VAT rate, payment terms | `03_areas/billing/billing_overview.md` |
| What has already been invoiced | `03_areas/billing/invoice_ledger.md` |

Read the whole period, not the first two notes. Then sort what you found into three piles:

- **billable** — work done for this customer, on a day the notes name
- **not billable** — internal product work, support tickets under the support contract, anything
  done for a different customer
- **unclear** — it happened, but the notes do not say which days it fell on

The third pile does not go on the invoice. It goes into the questions you ask before rendering.

### 2. Take the invoice number

Read `03_areas/billing/invoice_ledger.md`, take the **highest** number in the table, add one.
Format `INV-<year>-<four digits>`.

Never take the number from a PDF, a file name or a previous conversation. The ledger is the only
place a number is issued, which is the only reason two invoices never collide.

### 3. Write the invoice source

`03_areas/billing/invoices/invoice_<year>_<number>.md` — copy the shape of
`00_system/skills/invoice/example_invoice.md`.

```yaml
---
invoice_number: INV-2026-0042
customer: Glaswerk Nord GmbH
date: 2026-08-31
period: 2026-08-06 – 2026-08-31
net: 2675.00
vat: 508.25
gross: 3183.25
status: draft
---
```

Below the frontmatter: one line per item with quantity, unit price, amount **and the note it comes
from**. This file is the invoice. The PDF is a render of it, and it can be thrown away and made
again at any time.

`status` is one of `draft` · `sent` · `paid` · `overdue` · `credited`.

### 4. Fill the template

Read `00_system/skills/invoice/invoice_template.html` and replace every placeholder. Write the
filled copy to a temporary path — `$env:TEMP\invoice_filled.html` — **not into the vault**. A
filled HTML in the vault is a second source of truth that will disagree with the markdown within
a month.

| Placeholder | Filled from |
|---|---|
| `{{INVOICE_NUMBER}}` | step 2, the ledger |
| `{{INVOICE_DATE}}` | the day the invoice is issued, normally the last day of the period |
| `{{SERVICE_PERIOD}}` | the agreed period, written out: `6 – 31 August 2026` |
| `{{DUE_DATE}}` | invoice date + the payment term from `billing_overview.md` |
| `{{PAYMENT_TERMS}}` | `billing_overview.md` |
| `{{CUSTOMER_NAME}}` | customer page or project overview |
| `{{CUSTOMER_ADDRESS}}` | street line, plus a department if the customer named one |
| `{{CUSTOMER_POSTCODE_CITY}}` | same source |
| `{{CUSTOMER_COUNTRY}}` | same source |
| `{{CUSTOMER_VAT_ID}}` | customer page. Missing → ask, do not leave blank |
| `{{CUSTOMER_NUMBER}}` | customer page |
| `{{PO_REFERENCE}}` | the customer's own order number, if they gave one. Otherwise `—` |
| `{{PROJECT}}` | project overview title, plus what the invoice covers |
| `{{LINE_ITEMS}}` | step 1, as table rows — shape below |
| `{{NET_TOTAL}}` | sum of the item amounts |
| `{{VAT_RATE}}` | `billing_overview.md`, e.g. `19%` |
| `{{VAT_AMOUNT}}` | net × rate, rounded to the cent |
| `{{GROSS_TOTAL}}` | net + VAT |
| `{{CONTACT_NAME}}` | who owns the customer relationship — [[lena_mullion]] for Glaswerk Nord |
| `{{NOTE}}` | anything the reader needs to know. **No note → delete the whole `<div class="note">` block**, or the PDF shows an empty grey box |

One `{{LINE_ITEMS}}` row per item:

```html
    <tr>
      <td class="pos">1</td>
      <td class="desc"><span class="what">Short title</span>
        <span class="detail">What was actually done, with the dates it happened on.</span></td>
      <td class="num">2.0</td>
      <td>days</td>
      <td class="num">850.00</td>
      <td class="num">1,700.00</td>
    </tr>
```

The sender block, the bank details and both tax numbers are fixed in the template. They do not
change per invoice, and a constant you retype every month is a constant you will eventually
retype wrong.

Before rendering, search the filled file for `{{`. One hit means one empty field on a document
going to a customer.

### 5. Render the PDF

Microsoft Edge, because it is on every Windows machine and needs no install:

```powershell
$vault = (Get-Location).Path          # run this from the vault root
$edge  = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$html  = "$env:TEMP\invoice_filled.html"
$pdf   = "$vault\03_areas\billing\pdf\invoice_2026_0042.pdf"

New-Item -ItemType Directory (Split-Path $pdf) -Force | Out-Null
& $edge --headless --disable-gpu --no-pdf-header-footer `
        --print-to-pdf="$pdf" `
        "file:///$($html -replace '\\','/')"
```

Chrome understands the same flags — same Chromium engine, same renderer:

```powershell
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
```

Four things break this, all of them silently:

- **Relative paths.** `--print-to-pdf` and the `file:///` URL both need absolute paths, and the
  URL needs forward slashes.
- **`--no-pdf-header-footer` left out.** The PDF then carries the file path and a date in the
  page margin. On a customer document that looks like a mistake, because it is one.
- **Old flag handling.** If nothing is written, try `--headless=new`.
- **Anything loaded over the network.** The template deliberately has no web fonts and no images.
  A headless render does not wait for the network, so an external resource is a blank space in
  some renders and not in others.

### 6. Check the PDF

It is now at `03_areas/billing/pdf/invoice_<year>_<number>.pdf`. Open it and look at it: totals
block, customer address, invoice number, and that it is one page unless the item list is long.
The render can succeed and still be wrong, and headless Chromium reports success either way.

### 7. Add the ledger row

One row in `03_areas/billing/invoice_ledger.md`: number, date, customer, period, net, VAT, gross,
status. Add it **immediately**, before anything else, even if the invoice is still a draft. A
number that exists on disk but not in the ledger is a number somebody else will hand out again.

### 8. Commit

```powershell
git add 03_areas/billing/
git commit -m "invoice: INV-2026-0042 Glaswerk Nord, August"
```

Then one line in `00_system/log.md`, and one line in today's daily note.

**The PDF does not go into git.** It is a binary, it is reproducible from the markdown in about
ten seconds, and a repository that fills up with generated documents stops being readable in a
diff. Keep `03_areas/billing/pdf/` out of git — one line in `.gitignore` does it. Check the line
is there before the first render; until it is, never `git add` a PDF.

## Hard rules

1. **Invoice numbers are sequential and issued once.** Read the ledger first, every time. No
   gaps, no reuse, no "I think the last one was".
2. **No line item without a source.** If the vault does not show that the work happened, it does
   not go on the invoice. Ask instead. An invoice is the wrong place to find out you were wrong.
3. **The arithmetic has to close.** Sum of the items = net. Net + VAT = gross. Add it up, do not
   estimate it, and write the result in the markdown so the next person can check it in one line.
4. **Round once, at the end.** VAT is calculated on the net total and rounded to the cent there —
   not per item, or the rows will not add up to the total.
5. **A sent invoice is never edited.** Wrong invoice out of the door → a credit note plus a new
   invoice, both with their own numbers, both in the ledger. Changing a document a customer
   already has is how two versions of the same invoice end up in two accounting systems.
6. **The markdown and the ledger are the invoice.** The PDF is a printout.

## Mandatory fields

Check every one before rendering. A missing field can make the invoice unusable for the
customer's own tax deduction, which turns a five-minute job into a re-issue.

- [ ] Invoice number, unique and sequential
- [ ] Invoice date
- [ ] Service period, or the delivery date
- [ ] Full name and address of the issuer
- [ ] Full name and address of the customer
- [ ] Tax number **or** VAT ID of the issuer
- [ ] Quantity and a description of each service, specific enough to identify it
- [ ] Net amount, split by tax rate if more than one rate appears
- [ ] Tax rate **and** tax amount, shown separately
- [ ] Gross total
- [ ] Payment terms and due date
- [ ] Bank details

## Edge cases

- **The customer has no page in the vault.** Do not invent an address. Ask for it, put it on the
  invoice, and create the customer page in the same session — the second invoice should not need
  the same question.
- **The period contains no recorded work.** Say so and stop. No invoice, no number burned. An
  empty period usually means the work is filed under a different project, so check that before
  reporting back.
- **An invoice for that customer and period already exists.** Look it up in the ledger and stop.
  Two invoices for one period is the worst outcome here — worse than being late, worse than being
  wrong, because it is the one error the customer's system will book twice.
- **A day is split between this customer and internal work.** Bill in half days and say in the
  item detail which day it was. Do not round a half day up because the total looks better.
- **Work happened but the notes do not date it.** It stays off the invoice. Name it in the
  markdown under "not billed" with the reason, so the next invoice can pick it up once the dates
  are clear.
- **No rate for a service.** `billing_overview.md` holds the rates that were agreed. If a service
  has none, ask — the contract wins over anything guessed here.

## Related

- `03_areas/billing/billing_overview.md` — rates, rhythm, who owns the customer relationship
- `03_areas/billing/invoice_ledger.md` — where the numbers live
- `00_system/skills/invoice/example_invoice.md` — a filled invoice, end to end
- `00_system/skills/invoice/invoice_template.html` — the template this fills
- `/weekly-report` renders a PDF the same way, from the same daily notes

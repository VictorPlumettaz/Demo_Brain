---
title: Support Ticket Patterns
tags: [area, support, paneflow, reference]
created: 2026-05-18
updated: 2026-08-21
---

# Support Ticket Patterns

The tickets that come back. Symptom on the left in the customer's words, what it actually turns out
to be in the middle, what to do on the right.

I started this page after solving the same encoding ticket three times and not recognising it the
third time. It is the page I open first on every rota day → [[product_support_overview]].

## How to use it

Search the symptom column with the **customer's** words first and ours second — they do not write
"remnant reuse threshold", they write "the leftover piece disappeared". One row per real cause, not
one row per ticket. A thing that has happened once is an incident and goes in the daily note; a thing
that has happened twice is a pattern and goes here.

## Ask these three before anything else

1. **Does it happen every time, or only sometimes?** If only sometimes: what do the failing cases
   have in common? If the answer is "I do not know", that is the next piece of work, and it is not in
   the code. This one cost me two days in August → [[2026_08_17]].
2. **Did it ever work?** What changed — version, data, configuration, or the person doing it?
3. **Can I reproduce it on staging?** If not, I do not understand it yet.

## The patterns

| Symptom (as reported) | What it usually really is | Fix | Seen |
|---|---|---|---|
| "The optimizer returns 0% yield for the whole batch" | Every part is larger than the stock sheet. Sizes were entered in cm instead of mm | Reject the batch on import naming the first offending line. Do not run an optimization that cannot succeed | 6 |
| "The export opens as one long column in Excel" | German Excel expects `;` as the separator. The file was opened and re-saved in a text editor, which turned it into `,` | Re-download and do not open it before importing. We ship UTF-8 with BOM and `;` on purpose | 9 |
| "Umlauts arrive as `Ã¤`, `ÃŸ`, `Ã¼`" | A Windows-1252 file decoded as UTF-8 | Set the encoding explicitly on the import profile. `Ã` followed by a letter is this, every time so far | 5 |
| "Report totals differ from the shop floor by a few m²" | Each line is rounded to two decimals and then summed. The shop floor sums first and rounds once | Sum first, round once. The report footer says which method it used | 4 |
| "PaneFlow is slow every Monday morning" | The weekly reindex job starts at 05:00 and runs into the first shift | Move the job to Sunday 02:00 in the plant job schedule | 3 |
| "A leftover piece never comes back into stock" | The remnant is below the plant's reuse threshold, 300 mm on the short edge by default | Not a defect. Show them the plant configuration and ask whether the threshold is still right for them | 7 |
| "Everyone is logged out after a password change" | The session is cached on the second application node and sticky sessions are off | Restart the session, or upgrade to 4.2 where it is fixed | 3 |
| "The printed cutting pattern does not match the screen" | The printer is set to "fit to page" and prints at 94% | Print at 100%. On that sheet the scale is a measurement, not a layout choice | 2 |
| "Order lines are duplicated after an import" | The same file was uploaded twice. The import has no unique key on the external order id | Delete the second batch by import id. Idempotent import is planned, PR-4702 | 5 |
| "Shift report times are two hours off, but only in summer" | That one report renders a stored local time as if it were UTC | Known defect PR-4655. No workaround. Every other report is correct | 2 |

`Seen` counts closed tickets since May 2026. I update it when I close one, otherwise the ordering
here stops meaning anything.

## Seen once, not patterns yet

Kept here so I recognise the second occurrence. Promoted to the table when it happens again — stub
first, see [[wiki_page_layout]].

- Optimization run hangs at 99% on batches with more than 900 parts. Once, in June, on one plant.
- Customer's own scheduled export runs before our nightly job finishes and picks up yesterday's data.
- A glass type shows the wrong thickness in the pattern preview but the right one on the label.

## Related

- [[product_support_overview]]
- [[paneflow]]
- [[cutting_optimizer]]
- [[glossary_glass_industry]]
- [[howto_release_a_hotfix]]

---
title: Product Support — Overview
tags: [area, support, paneflow]
created: 2026-05-11
updated: 2026-08-21
---

# Product Support

Second-line support is the developer end of the support chain for [[paneflow]]: the tickets that
first line cannot answer out of the manual or the configuration.

This page exists because I am on the rota every Friday and I kept re-learning the escalation path
from scratch. It never stops, so it is an area and not a project — see [[project_conventions]].

## How a ticket arrives

Customers write into the support portal. Tickets get an ID of the form `PR-4821` and move down the
chain only when the level above cannot close them.

| Line | Who | Handles | Response target |
|---|---|---|---|
| First | Customer success — [[lena_mullion]] and two colleagues | "how do I", "where is", passwords, configuration questions, training | 4 working hours |
| Second | Developer rota, one per day. Mine is Friday | Reproducible defects, data problems, anything that needs a log file or a database look | Next working day |
| Third | Component owner. [[marco_bevel]] for the packing engine | Algorithm behaviour, anything inside the optimizer core | By agreement |
| Escalation | [[dana_frames]] | Customer blocked in production, or a fix that needs a hotfix release | Immediately |

A hotfix is not a support decision. It goes through [[howto_release_a_hotfix]] and Dana signs it off.

## Priorities

| Level | Means | Target |
|---|---|---|
| P1 | Production stopped. Nobody at the plant can cut glass | 4 hours, and somebody stays on it |
| P2 | Wrong numbers, or a workaround exists but hurts | 2 working days |
| P3 | Cosmetic, or a question | Best effort, reviewed weekly |

Only Dana or the on-call lead sets P1. A customer calling it urgent is information, not a priority.

## My share

One day a week, Fridays, published a month ahead. Typically four to six tickets, of which one or two
are genuinely new — the rest are in [[support_ticket_patterns]]. If I am away I swap the day with
someone, I do not skip it.

Being on the rota means the day is for tickets. I have twice tried to also do sprint work on a Friday
and finished neither.

## What I do with a ticket

1. Read the ticket **and the attached log** before replying. The log usually contains the answer and
   the customer usually has not read it.
2. Check [[support_ticket_patterns]]. Roughly three quarters of tickets are already there.
3. Reproduce on staging before promising anything. If I cannot reproduce it, I do not understand it
   yet, and saying so is a better update than a guess.
4. If the same thing arrives a second time, it gets a row in [[support_ticket_patterns]]. Once, it is
   an incident. Twice, it is a pattern.
5. Never change anything in a customer's production system directly. If it needs a code change it
   becomes an ordinary pull request → [[code_review_overview]].
6. Close with what it was, not only that it is fixed. "Resolved" in a ticket history helps nobody in
   six months.

## Things I got wrong first

- **"It is not a defect, it is the plant configuration"** is the single most common outcome. Check
  the configuration before reading any code.
- Answer in the customer's words. They say "leftover piece", we say "remnant"; they say "sheet", we
  say "stock unit". Translating is my job, not theirs → [[glossary_glass_industry]]
- Do not promise a release date in a ticket. Priya decides what ships → [[team_overview]]

## Related

- [[support_ticket_patterns]]
- [[paneflow]]
- [[howto_release_a_hotfix]]
- [[team_overview]]
- [[lena_mullion]]

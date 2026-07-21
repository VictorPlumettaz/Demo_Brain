---
title: Team — Overview
tags: [area, team, company]
created: 2026-04-21
updated: 2026-08-19
---

# Team

How development at [[pane_relief_software]] is organised, when we meet, and who to ask about what.

I wrote this in my first month because I asked "who actually decides that?" four times in three
weeks and got a slightly different answer each time.

## The people

Product development is eleven people in three teams. I am in the PaneFlow core team.

| Person | Role | Owns | Ask them about |
|---|---|---|---|
| [[dana_frames]] | Team lead | Roadmap, priorities, architecture | What we work on next. Anything with a date on it |
| [[marco_bevel]] | Senior developer | Optimizer core, packing engine | Algorithms, and why the old code is the way it is. Ask a specific question and you get a specific answer |
| [[robin_sill]] | Apprentice, second year (me) | Reporting, imports, whatever is on the rota | — |
| [[priya_tempered]] | QA lead, all three teams | Test strategy, test data, release sign-off | Whether something can ship |

Two people outside the team who I talk to more than most people inside it:

| Person | Role | Ask them about |
|---|---|---|
| [[nils_putty]] | IT, whole company | Access, environments, build agents, VPN, anything with an IP address |
| [[lena_mullion]] | Customer success | What the customer actually said, as opposed to what the ticket says |

## Meeting rhythm

| Meeting | When | Length | Runs it | Point |
|---|---|---|---|---|
| Standup | Daily 9:15 | 15 min | Dana | Blockers. Not a status report |
| Retro | Every second Thursday, 14:00 | 60 min | Rotates | Next: 27 August |
| Sprint planning | The Monday after the retro | 90 min | Dana | Two-week sprint |
| Glaswerk Nord call | Thursdays 10:00 until go-live | 30 min | Lena | → [[glaswerk_nord_overview]] |
| 1:1 with Dana | Every second Wednesday | 30 min | Dana | My apprenticeship, not the sprint |
| All-hands | First Monday of the month, 16:00 | 45 min | — | |

Standup is fifteen minutes because it is standing up. If an item takes more than a sentence, two
people take it away and the other three go back to work.

## Who decides what

- **Dana** decides priority and what we work on next.
- **Marco** decides how the optimizer core works. He can be argued with, in the pull request.
- **Priya** decides whether something ships. Not Dana, and not the customer.
- **Nils** decides what runs where and on which network.
- **I** decide how my own change is written, until review says otherwise → [[code_review_overview]].

## The unwritten rules

They are not written anywhere. That is the point of this section. Every one of them I learned by
getting it slightly wrong first.

- **Standup is for blockers.** Nobody wants your commit list.
- **If you have been stuck for more than an hour, ask.** Dana said this in my first week. I ignored
  it for two days in August → [[2026_08_17]]
- **Do not merge to main after 15:00 on a Friday.** Nobody has ever written this down. Everybody does
  it.
- **No deploys during a customer go-live week.** 2–6 October is frozen.
- **Name the customer in the standup.** "The customer" means three different companies to three
  people in that room.
- **A red build is everyone's problem**, starting with whoever broke it but not ending there.
- **Ask Marco a specific question and you get a specific answer.** Ask "can you take a look at this?"
  and you get a look, and a sigh, and then the answer anyway.
- **Whoever takes the last coffee starts the next pot.** This is enforced more consistently than the
  deploy freeze.

## Where things live

- Work items: the board. Code: git. Reasoning and everything that outlives a ticket: this vault →
  [[index]]
- Tickets from customers: the support portal → [[product_support_overview]]
- If something is only in someone's head, that is the thing to write down next.

## Related

- [[moc_people]]
- [[pane_relief_software]]
- [[code_review_overview]]
- [[product_support_overview]]
- [[dana_frames]]

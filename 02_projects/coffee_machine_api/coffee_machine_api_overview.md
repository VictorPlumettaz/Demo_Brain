---
title: Coffee Machine API
tags: [project, side-project, api, learning]
status: active
started: 2026-07-09
created: 2026-07-09
updated: 2026-08-20
---

# Coffee Machine API

The bean-to-cup coffee machine in the second floor kitchen answers HTTP requests. It was not
supposed to and it is not documented anywhere. This project is a small dashboard showing which
drinks the office makes and when.

I found it by accident on 9 July while scanning my own subnet for a Raspberry Pi I had lost.
Something on `kaffee-02` answered on port 8080.

## Standing of this project

This is not a work project. [[dana_frames]] knows it exists. Her position, stated on 2026-07-15
and written down here so that neither of us has to remember it accurately later:

1. not sanctioned
2. not forbidden
3. my own time
4. no writes to the machine

I accepted all four. I have since broken the fourth one, once, and the details are in
[[coffee_machine_api_findings]].

## Goal

A dashboard showing drinks per type per day for the second floor machine.

**Done means:**

- it runs for two consecutive weeks without me touching it
- it survives a restart of my laptop without losing a day of data
- I can answer the question it started with: does the office drink more espresso on release days

The real goal is the same thing three levels down — I wanted a project where I owned every layer,
from the HTTP call to the chart. See [[rest_api_basics]] and [[sql_joins]]. The coffee is the
excuse.

## Status — 2026-08-20

Poller works. Dashboard does not exist.

| Piece | State |
|---|---|
| Poller, every five minutes | running on my laptop since 2026-07-21 |
| SQLite store, deltas per interval | working, 41 days, two gaps |
| Midnight reset handling | working since 2026-07-24, see findings |
| Dashboard | a `SELECT` I run by hand and read in the terminal |
| Second machine on floor 1 | not tested, may not be networked at all |

The two gaps are days I closed the laptop. This is the thing that needs fixing before the
"two weeks untouched" criterion can even be attempted, and fixing it means running the poller
somewhere that stays on, and that means asking [[nils_putty]], and that conversation now has a
much larger agenda item attached to it.

## Decisions

**Read only, no writes** — 2026-07-15. The machine accepts POST. That is not an invitation. Also
condition four above. Rejected: a "safe" write test on a setting nobody would notice, which is
exactly what I did on 3 August and exactly why the rule exists.

**Poll every five minutes** — 2026-07-16. The counters reset at midnight, so I need enough
samples that one missed poll is not a lost day. Five minutes gives 288 rows a day, which is
nothing. Rejected: every 30 seconds, because a coffee machine generating 2,880 requests a day is
the kind of thing that eventually shows up in somebody's traffic graph, and I would rather it did
not show up before I have explained it myself.

**SQLite, not a text file** — 2026-07-17. The endpoint reports cumulative counters that reset at
midnight, so what I actually store is the delta between two polls. Deltas need a schema, a
timestamp and a unique constraint, or a retry writes the same coffee twice. Rejected: append to
CSV, which worked for four days and then did exactly that.

**Runs on my laptop, not the dev server** — 2026-07-17. The dev server belongs to Nils. Putting
an unsanctioned script on someone else's machine is how a side project becomes an incident.

**No names, ever** — 2026-07-20. The machine does not know who pressed the button. Badge data
would tell me who was in the kitchen. I thought about it for about a minute and then decided
that a dashboard which can tell Dana who takes four cappuccinos before eleven is not a dashboard,
it is a disciplinary tool with a chart on it. Aggregate counts only.

## Open questions

1. Are the machines on floor 1 and by reception on the network too? If they are, the same
   findings apply to them and the conversation with Nils gets bigger.
2. Does an americano count as coffee in the totals? Currently it has its own column. Hot water
   does not count as anything, because it is mostly tea.
3. Will the endpoint survive a firmware update? There is no documentation, so there is no
   promise. If it disappears one Tuesday, the project ends and the data stays.
4. What happens after I tell Nils. Realistic outcomes: the machine gets moved to its own VLAN and
   the project dies, or nothing happens. I would prefer the first one. It is the correct outcome
   and it costs me a dashboard.

## Related

- [[coffee_machine_api_tasks]]
- [[coffee_machine_api_findings]]
- [[rest_api_basics]]
- [[sql_joins]]
- [[moc_development]]

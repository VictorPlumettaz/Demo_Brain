---
title: Cutting Optimizer Rewrite — Decision Log
tags: [project, decisions, optimizer]
created: 2026-05-19
updated: 2026-08-04
---

# Decision Log

Why we did it this way. Newest last, so it reads like a story.

Each entry says what was decided, when, why, and what was rejected. The rejected option is the
part I keep forgetting to write down and the part I always want six months later, when someone
asks "why didn't you just…" and I cannot remember whether we thought of it.

## 2026-05-19 — The new engine stays C#

**Decided:** rewrite in C# on .NET 8, same runtime as the rest of [[paneflow]].

**Why:** Marco's argument, and he won it in about two minutes. The team maintains this engine for
the next ten years. The team writes C#. A second language means a second build pipeline, a
second set of dependencies for [[nils_putty]] to patch, and one person who can review the code.

**Rejected:**

- **Rust.** Genuinely faster and a good fit for the geometry. Nobody on the team can review it,
  including me, and a nesting engine nobody can review is a nesting engine nobody can fix at
  17:40 on a Friday.
- **Python with an off-the-shelf solver.** Fastest to prototype. Too slow for a 500-lite batch,
  and it would put a Python runtime into every on-premise customer install.
- **Buying a third-party nesting library.** We evaluated one. Licensed per plant, and the source
  is closed — when a customer calls because their yield dropped two points, "we cannot see
  inside it" is not an answer we can give.

## 2026-05-26 — Feature flag, not a long-lived branch

**Decided:** the new engine lives in `main` from day one, behind the config flag `optimizer.v2`,
off by default.

**Why:** the report export rewrite ran on its own branch for nine months and the merge cost
almost as much as the rewrite. It is written up in [[legacy_report_export_retrospective]] and
Dana made me read it before this project started, which in hindsight was the point.

**Rejected:** a `rewrite/optimizer` branch. Also rejected: pulling the optimizer out into its own
service. It needs the whole order model in memory, and moving that across a network boundary
turns a 30-second job into a much slower one.

**Cost of this decision:** the codebase now contains two engines and an interface nobody needed
before. That is the price, and it is visible in every code review — see [[code_review_basics]].

## 2026-06-02 — The `.opt` output format does not change

**Decided:** the new engine writes `.opt` pattern files that are byte-comparable with the legacy
ones for the same input.

**Why:** saw controllers at customer sites read that file directly. It is not our format any
more, it is theirs. One plant runs a controller from 2009 with no update path — if the file
changes, that plant stops cutting glass.

**Rejected:** a clean JSON format with a converter for old controllers. Better design. But the
converter would live somewhere, and someone would maintain it for the rest of its life, and that
someone is a team of four.

**Side effect, unplanned and good:** because the output format is frozen, the two engines produce
comparable files. That made the next decision possible.

## 2026-06-11 — Golden-master tests for the engine core

**Decided:** correctness of the engine is tested by running 240 real jobs through both engines
and diffing the output files. Ordinary unit tests stay for the geometry helpers — see
[[unit_testing]].

**Why:** I cannot write a unit test for "is this the best possible cutting pattern", because
nobody knows the best possible cutting pattern. That is the entire point of the product. What I
can test is "did the answer change since yesterday", and that turns out to catch almost
everything.

**Rejected:** hand-written expected patterns. Priya estimated three weeks to produce them and
said she would not trust the result, because the person writing the expected answer is the
person who misunderstood the requirement.

**Honest note:** golden-master tests do not tell you the answer is right. They tell you it moved.
Twice now the diff was red and the change was an improvement, and both times I had to go and
look at the actual patterns to find that out. It is a smoke alarm, not a judge.

## 2026-07-14 — Remnants out of scope for v1 — REVERSED 2026-07-28

**Decided, 14 July:** v1 ignores remnants. A remnant is a usable offcut that goes back on the
rack and gets cut into a later order. Everything the optimizer does not place becomes cullet.

**Why then:** most of the complexity in the legacy engine is remnant bookkeeping. I wanted an
engine that worked end to end before touching the hardest part of it.

**Reversed, 28 July.** Lena sent Glaswerk Nord's stock numbers while preparing their onboarding:
they cover about 11 percent of their float glass demand out of the remnant rack. An optimizer
that ignores remnants does not save that plant money — it costs them money, because it would cut
new sheets while usable glass sits on the rack.

Dana's sentence, which is going in my head permanently: *"a v1 nobody switches on is not a v1."*

**What the reversal cost:** the release target moved from PaneFlow 12.2 to 12.3, decided at the
[[cutting_optimizer_rewrite_meeting_2026_08_04|design review on 4 August]]. Roughly six weeks,
plus the two weeks of work I did on the assumption that remnants were out.

**What I would do differently:** I scoped remnants out because they were hard, and I wrote down
"hard" as the reason. I never wrote down "who needs this and how much". Lena had the number the
whole time and I did not ask her, because it did not occur to me that customer success would
have anything to say about an algorithm. It did.

## Related

- [[cutting_optimizer_rewrite_overview]]
- [[cutting_optimizer_rewrite_meeting_2026_08_04]]
- [[glaswerk_nord_overview]]
- [[project_conventions]]

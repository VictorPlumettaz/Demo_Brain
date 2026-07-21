---
title: Code Review — Overview
tags: [area, code-review, process]
created: 2026-05-26
updated: 2026-08-20
---

# Code Review

Every change to [[paneflow]] reaches the main branch through a pull request, and every pull request
is read by at least one person who did not write it.

This page is here because the rules are not written down anywhere else, and as an apprentice I am on
both ends of them: my changes always get a second reviewer, and I am expected to review other
people's small changes. Reading other people's code is most of how I have learned this codebase.
The general idea is in [[code_review_basics]]; this page is how it actually runs here.

## Who reviews what

| Area | Reviewer | Approvals | Why them |
|---|---|---|---|
| Optimizer core, packing engine | [[marco_bevel]] | 2 | He owns it and he is the only person who knows why the 2019 heuristics are the way they are |
| Architecture, new dependencies, anything adding a package | [[dana_frames]] | 1 | A dependency is a decision with a maintenance cost, not a convenience |
| Test data, report output, any number a customer sees | [[priya_tempered]] | 1 | She signs off the release, so she should see it before it is merged |
| Build pipeline, deployment, infrastructure | [[nils_putty]] | 1 | It is his pager |
| Everything else | Any team member | 1 | |

My pull requests always get one of the four above, whatever they touch. That is an apprenticeship
rule, not a codebase rule, and it ends when Dana says it does.

## Turnaround

- Opened **before 15:00** → reviewed the same day.
- Opened **after 15:00** → next morning. This is why I stopped opening a pull request at 16:50 and
  then waiting for it.
- Draft pull requests are not reviewed until marked ready. Marking something ready is the request.
- If a review has not happened by the next standup, it is a blocker and belongs in the standup.

## Size

Under 400 changed lines, or split it. My first real pull request was 900 lines and Marco reviewed it
in the sense that he replied "no" → [[legacy_report_export_retrospective]]. Splitting it into four
took an afternoon and the comments afterwards were about the code rather than about the size.

A review that says "LGTM" on a 300-line diff is not a review. It is an approval, and those are not
the same thing.

## What reviewers actually comment on

Counted from my own pull requests since April. Sixty-one comments.

| Kind | Count |
|---|---|
| Naming and clarity | 24 |
| Something that already exists in the codebase | 14 |
| Missing or unconvincing test | 9 |
| Logic in the wrong layer | 8 |
| An actual defect | 6 |

The rank order is the useful part. Almost none of it is about correctness. Most of it is about the
next person to read the code, which is usually me in three months.

## Taking comments

- The comment is about the change, not about me. This is easy to write down and takes a while.
- If I disagree, I say so in the thread, once, with a reason. If it is still unresolved after one
  round, we talk instead of typing.
- Every comment gets an answer, including the ones I am not going to act on.
- "Good catch" is a complete reply. Nobody needs a paragraph.

## Before I open one

The checklist I actually run: [[code_review_checklist]].

## Related

- [[code_review_checklist]]
- [[code_review_basics]]
- [[git_basics]]
- [[unit_testing]]
- [[team_overview]]

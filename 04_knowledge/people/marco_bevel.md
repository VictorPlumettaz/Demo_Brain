---
title: Marco Bevel
tags: [knowledge, people]
created: 2026-04-15
updated: 2026-08-20
---

# Marco Bevel

Senior developer, eleven years at [[pane_relief_software|Pane Relief]], and my mentor. Wrote
large parts of [[paneflow]], including the first [[cutting_optimizer]] in 2017, and complains
about that code more than anyone else in the building.

## What he owns

- The optimizer internals. He is the only person who has read all of it.
- The old scheduling module and the build pipeline, both by default, both because nobody else survives them.
- Me, one afternoon a week on paper, and in practice whenever I ask properly.

## How to work with him

- **Ask a precise question.** "Do you have a minute?" gets a no. "Why does the optimizer open
  a second sheet when the first still has room?" gets twenty minutes and a drawing.
- Headphones on means he is holding something in his head. It can wait.
- After 14:00 is the good window. Before 10:00 is not.
- He sighs. The sigh is aimed at the code, not at me. Took me two months to stop hearing it
  as a verdict on the question.
- In review, a bare "why?" under a line means he already knows what is wrong and wants me to
  find it. "Because the example did it that way" is not an answer → [[code_review_basics]].
- When he says "that will bite you", I write it down. Three for three so far.

## What I learned from him

- Glass cutting is not free-form nesting. Every score runs edge to edge, so every break splits
  one rectangle into exactly two → [[cutting_optimizer]].
- "The optimizer is not slow. Your batch has 4000 lites in it and no material filter."
- Read the log before the code. Then read it again from the *first* error, not the last one.
- A test that needs a running database is not a unit test → [[unit_testing]].
- Most of [[paneflow]] is not badly written. It is written for a requirement nobody wrote down.

## Related

- [[moc_people]]
- [[cutting_optimizer_rewrite_overview]]
- [[code_review_overview]]
- [[legacy_report_export_retrospective]]
- [[git_basics]]

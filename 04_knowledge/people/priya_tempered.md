---
title: Priya Tempered
tags: [knowledge, people]
created: 2026-04-28
updated: 2026-08-20
---

# Priya Tempered

QA lead at [[pane_relief_software|Pane Relief]]. Four years, came over from support. She writes
the bug report you cannot argue with.

## What she owns

- Test plans and the regression suite for [[paneflow]]
- Release sign-off. No sign-off, no release, hotfixes included → [[howto_release_a_hotfix]]
- The definition of "done" in the tracker, which is hers and is not up for negotiation
- The shared test data, including the 4000-lite batch everybody uses to break the
  [[cutting_optimizer]]

## How to work with her

- A ticket from her carries: version and build number, the data set attached, numbered steps,
  expected, actual, and a screenshot with the clock visible. Nothing left to push back on.
  That is the whole point.
- If she reopens my ticket, she is right. Read the steps again *before* replying. I replied
  first twice and was wrong twice.
- Ask her before writing the fix, not after. Five minutes of "how would you test this" has
  saved me a full rework.
- She tests the correct path, then the stupid path. The stupid path is where the bugs are:
  300 rows pasted into one field, save clicked twice, an order with a 4 mm lite and a 4.1 mm one.
- Never say "works on my machine". She will ask which machine, which build, which data set,
  and I will not have an answer to any of the three.

## What I learned from her

- A bug without a data set is an opinion.
- Write the reproduction before the diagnosis. Half the time the reproduction *is* the diagnosis.
- "Cannot reproduce" needs the same detail as a bug report. Otherwise it only means "I did
  not try very hard".

## Related

- [[moc_people]]
- [[code_review_checklist]]
- [[support_ticket_patterns]]
- [[cutting_optimizer_rewrite_tasks]]
- [[unit_testing]]

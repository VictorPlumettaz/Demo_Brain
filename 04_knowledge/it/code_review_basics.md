---
title: Code Review Basics
tags: [knowledge, it, process]
created: 2026-05-27
updated: 2026-08-18
---

# Code Review Basics

A code review is a second person reading a change before it reaches the main branch.

## Why it matters here

Nothing gets merged into [[paneflow]] without one approval, and optimizer code needs two. I
have been on the receiving end of about sixty reviews and have given maybe eight, so most of
this page is written from below. The practical checklist we use is
[[code_review_checklist]]; this page is about what the thing is for.

## What it is for

1. **Catching what the author cannot see.** After four hours in a file you read what you meant
   to write.
2. **Spreading knowledge.** Reading Marco's changes is how I found out the optimizer has a
   second, undocumented rounding step.
3. **Keeping the code readable by more than one person.** The person who maintains this in
   2029 is the actual audience.

What it is not for: settling formatting arguments. `dotnet format` runs in the build, so if a
review comment is about a brace, the build should have said it instead.

## Receiving one

This is the part I had to learn.

- **The comment is about the code.** My first pull request came back with 34 comments and I
  took it personally for about an hour. Then I sorted them: twenty were the same missing
  `null` check repeated in twenty places. One mistake, not thirty-four.
- **Ask if you do not understand.** "Why is this a problem?" is a completely acceptable reply
  and has never once been held against me.
- **Disagreeing is allowed, with a reason.** "I did it this way because the import can send an
  empty list" resolves more comments than silently rewriting the code.
- **Never apply a change you do not understand.** You will be the one explaining it later. Ask
  first, then apply.
- **Reply to every comment**, even with "done". An unanswered comment looks ignored.

## Giving one

- **Say what kind of comment it is.** We prefix them, and it removes most of the friction:

  | Prefix | Means |
  |---|---|
  | `nit:` | small, take it or leave it |
  | `question:` | I do not understand, explain it to me |
  | `suggestion:` | I would do it differently, your call |
  | `blocking:` | this must change before merge |

  Without the labels every comment reads as blocking, which is how a review of four small
  remarks turns into a bad afternoon.

- **Say why.** "Move this into a method" is an order. "This is three levels of nesting, a
  guard clause at the top would flatten it" is a reason someone can agree or disagree with.
- **Praise something real, once.** Not decoration — if the change taught you something, say
  which part.
- **Approve when it is better than what is there.** Waiting for perfect blocks people. If it
  is an improvement and nothing is broken, approve with the nits attached.

## Size

The uncomfortable truth: a 40-line pull request gets real comments and a 900-line one gets
"looks good to me". That is not laziness, it is attention running out. Since I started
splitting my work into changes that fit on one screen, the reviews have been slower to arrive
and much more useful when they do.

## Related

- [[code_review_checklist]]
- [[code_review_overview]]
- [[git_basics]]
- [[unit_testing]]
- [[moc_development]]

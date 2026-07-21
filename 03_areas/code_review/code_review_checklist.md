---
title: Code Review — Checklist Before Opening a Pull Request
tags: [area, code-review, checklist]
created: 2026-06-08
updated: 2026-08-20
---

# Checklist Before Opening a Pull Request

Ten minutes here saves a review round. Every line below is on this list because a reviewer once
wrote it on one of my pull requests.

> These are **checklist items, not tasks**. They repeat on every pull request, they carry no priority
> tag and they do not belong in [[my_tasks]] — see [[task_conventions]]. I copy the block into the
> pull request description and tick it there.

## The change itself

- [x] The diff does one thing. If the description needs the word "and", it is two pull requests. [completion:: 2026-07-21]
- [ ] Under 400 changed lines → [[code_review_overview]]
- [ ] I have read my own diff top to bottom in the web view, not in the editor. Different view,
      different mistakes.
- [ ] No commented-out code, no debug output, no `TODO` without a ticket number.
- [ ] Names describe what the value is **now**, not what it was before the change.
- [ ] This does not already exist somewhere in the codebase. Search first — twice in August I
      rebuilt something that was already there.
- [ ] Configuration values come from the plant configuration, not from a constant in the calculation.
- [ ] No customer name, no IP address, no credentials in the diff.

## Tests

- [ ] New behaviour has a test that **fails without the change**. A test that passes either way tests
      nothing → [[unit_testing]]
- [ ] The fixture can actually produce the case. Test data with no remnants cannot find a remnant
      defect.
- [ ] The test name says the condition, not the method: `..._WhenRemnantExceedsReuseThreshold`.
- [ ] Full build green locally, including the slow integration tests, not only the fast ones.

## The description

- [ ] What changed, why, and how the reviewer can check it. Three short paragraphs at most.
- [ ] Ticket linked.
- [ ] Screenshot or a before/after number if a customer sees the result.
- [ ] Reviewer chosen per the table in [[code_review_overview]], and named.
- [ ] Opened before 15:00, otherwise it waits until tomorrow anyway.

## After the review

- [ ] Every comment answered, including the ones I disagree with.
- [ ] Rebase onto main, no merge commit → [[git_cheatsheet]]
- [ ] Squashed to one commit with a message that will make sense in a year → [[git_basics]]
- [ ] Ticket moved and the daily note updated.

## Related

- [[code_review_overview]]
- [[code_review_basics]]
- [[task_conventions]]
- [[git_basics]]

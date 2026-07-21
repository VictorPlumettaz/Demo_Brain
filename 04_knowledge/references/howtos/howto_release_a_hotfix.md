---
title: How-to — Release a Hotfix
tags: [knowledge, reference, howto, release]
created: 2026-07-14
updated: 2026-08-20
source: team release rules, written down after the 1.14.3 release
---

# How-to — Release a Hotfix

A hotfix is one small fix taken to production outside the normal release train.

## Why it matters here

The regular release goes out every second Wednesday. A hotfix skips that queue, which means it
also skips most of the safety that queue provides — so the steps below exist to put a bit of it
back. I have done two, both supervised, and this is the path we took.

## Is it a hotfix?

| Situation | Answer |
|---|---|
| Production is down | yes |
| Wrong cutting patterns are being produced | yes — glass is being cut right now |
| A customer cannot place orders at all | yes |
| Wrong number in a report nobody reads until Friday | no, next release |
| "While I am in there anyway" | no |

If it is not on the left, it waits. [[dana_frames]] decides when it is unclear, not the person
who wants to ship.

## Steps

1. **Ticket first.** Symptom, affected version, affected customer, and how to reproduce it. A
   hotfix with no ticket cannot be explained to anyone in three months.

2. **Branch from the tag, not from `main`.** `main` contains everything for the next release,
   and none of that is going to production today.

   ```bash
   git fetch --tags
   git switch -c hotfix/1.14.3-trim-rounding v1.14.2
   ```

3. **Write the failing test first.** It reproduces the bug, it fails, and it stays in the
   codebase afterwards — see [[unit_testing]].

4. **Make the smallest fix that works.** No refactoring, no renaming, no tidying up on the way
   past. Every extra line is a line nobody has time to review properly.

5. **No destructive database migration.** Adding a nullable column is acceptable. Dropping or
   renaming one is not, because it makes step 11 impossible.

6. **Pull request and review.** One approval from Dana or [[marco_bevel]]; two if it touches
   the [[cutting_optimizer]]. Reviewers know it is a hotfix, so they look for *risk*, not for
   style. See [[code_review_checklist]].

7. **QA sign-off from [[priya_tempered]].** She runs the regression pack against staging with
   the affected customer's real order set, and confirms both that the bug is gone and that the
   yield numbers did not move anywhere else. **In writing, in the ticket.** A verbal "looks
   fine" in the corridor does not count, and the reason it does not count is that in March it
   turned out to have been about a different build.

8. **Tag and build once.**

   ```bash
   git tag v1.14.3
   git push origin v1.14.3
   ```

   The pipeline builds one artifact from that tag. Deploy that artifact. Never rebuild from
   source at deploy time — then the thing tested and the thing shipped are two different files.

9. **Deploy in the window.** Tuesday to Thursday, 06:30–07:30 before the early shift, or
   15:00–16:00 between shifts. Announce in `#releases` half an hour before. The rolling
   restart of the three instances takes about four minutes, during which running optimisation
   runs are queued rather than lost.

10. **Watch for 30 minutes.** Health endpoint, error rate, optimizer queue length. Filter the
    log for the new version tag ([[logging_basics]]). Do not start something else during this
    half hour — that is the entire point of it.

11. **Have the rollback ready before you deploy.** The previous artifact stays on the deploy
    host, and `deploy.sh v1.14.2` puts it back in under two minutes. The decision rule: if the
    error rate is not back to normal **within 15 minutes**, roll back and debug afterwards. Do
    not debug live. Nils and Marco are the two who can run a rollback, so one of them is
    reachable during every deploy window.

12. **Forward-port the same day.** Merge the hotfix branch into `main`, or the next regular
    release ships the bug again. This is the step everyone forgets, including me, in 1.14.3.

13. **Close the loop.** Ticket updated, one line in the daily note, and if the cause was
    interesting it becomes a page in `04_knowledge/`.

## Nobody deploys on a Friday

Not a superstition, and not general good practice quoted from the internet. Here it is
specific:

- Three customers, [[glaswerk_nord_overview]] among them, run a **Saturday shift**. Their
  machines keep cutting while our office is empty. A bad cutting pattern on Saturday morning is
  not a stack trace, it is square metres of scrap glass.
- The Monday production plan is generated **Friday evening**. A bug shipped on Friday afternoon
  gets baked into an entire week of planning before anyone looks at it.
- The two people who can perform a rollback are not on call at the weekend.

The rule also covers the day before a public holiday. The one exception is an outage that is
already happening — then it is not a release, it is a repair, and Dana makes the call.

## Related

- [[git_basics]]
- [[code_review_checklist]]
- [[priya_tempered]]
- [[logging_basics]]
- [[moc_development]]

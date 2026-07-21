---
title: Legacy Report Export — Retrospective
tags: [project, archive, legacy-report-export, retrospective]
status: done
created: 2026-06-22
updated: 2026-08-17
---

# Legacy Report Export — Retrospective

Written on 22 June 2026, three days after the release. First project I owned from start to finish,
so some of this is about the project and some of it is about me.

Project details: [[legacy_report_export_overview]].

## What worked

- **Writing down what the 47 columns mean before writing any code.** Four days that felt like waste
  at the time and that I nearly skipped. It removed 16 columns from the scope and it is the only
  reason the replacement could be documented at all.
- **The golden-master test.** Thirty datasets, old output against new, byte for byte. It caught the
  rounding difference, a trailing newline difference and one date format that only appears in
  December. Two days to build, ninety seconds to run.
- **The feature flag.** Three customers switched on three different evenings. Nothing had to be
  rolled back, and the one customer who is not moving costs us a boolean.
- **Asking [[lena_mullion]] what the customers actually parse.** When I finally did it, she found the
  answer in old support mail in twenty minutes.

## What did not work

- **I treated the stored procedure as the specification.** It is not a specification. It is what one
  person did in 2014 under time pressure. I spent five days reading 1,100 lines of T-SQL to work out
  what the columns mean, when the question that mattered — which columns does anyone read — was in
  Lena's mailbox. I went to the code first because reading code is comfortable and asking a question
  is not.
- **I underestimated Excel.** Two full days went on encoding and separators. "It is only a CSV" is a
  sentence with a lot of hours hiding behind it.
- **The first pull request was 900 lines.** [[marco_bevel]] reviewed it in the sense that he replied
  "no". Splitting it into four took an afternoon, and after that the comments were about the code
  instead of about the size → [[code_review_overview]]
- **I wrote nothing down while I worked.** The whole decision log in
  [[legacy_report_export_overview]] was written from memory in one sitting at the end. Three of the
  seven entries are reconstructions. I think they are right. I am not certain, and being not certain
  about my own decision log is exactly the failure this vault is supposed to prevent — derived, not
  verified.

## What I would do differently

1. Ask **who uses the output** before reading **how it is produced**.
2. One line in the decision log on the day the decision is made. Not seven entries at the end.
3. Split the pull request before opening it, not after being told to.
4. Assume that any file a customer receives will be opened in Excel, in a German locale, by someone
   who will then save it and send it back.

## What it cost

Estimated four weeks. Took eight. The estimate assumed a specification existed; five of the extra
four weeks went into producing one.

For the record: nobody was annoyed about the eight weeks. [[dana_frames]] said the four-day column
inventory was the part that made the rest possible. I still would not want to estimate the same way
twice.

## Update 2026-08-17

Same failure mode on the optimizer yield defect. Went to the code before asking what the failing
cases had in common. Two days → [[2026_08_17]].

## Related

- [[legacy_report_export_overview]]
- [[code_review_overview]]
- [[unit_testing]]
- [[moc_development]]

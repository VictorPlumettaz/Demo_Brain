---
title: Inbox
tags: [system, inbox]
created: 2026-04-13
updated: 2026-08-11
---

# Inbox

A buffer. Not a storage.

Everything that lands here leaves again. If a file has been sitting here for a week, the system
is not working — and that is the point of having only one folder that behaves this way.

## What goes in

- photos of whiteboards and flipcharts
- voice memos, and the transcripts of them
- PDFs, spec fragments, screenshots pasted out of a ticket
- half-formed notes I typed on my phone on the train
- anything I would otherwise lose before I get back to a keyboard

Nothing in here has to be tidy. Tidying it is a separate job, done later, on purpose. A note I
was too embarrassed to write badly is a note I did not write.

Filenames follow [[file_naming]]: `YYYY_MM_DD_short_description.md`.

## What happens to it

Saying "process the inbox" starts the `/ingest` skill. Every file gets read once and split into
the parts that matter:

| Content | Where it goes |
|---|---|
| something decided | the project overview or its decision log |
| something learned | a page in `04_knowledge/` |
| something to do | the tasks file of the project it belongs to, see [[task_conventions]] |
| something that happened | today's daily note |
| nothing useful | deleted, without ceremony |

Every processed file leaves three traces: the target page, a line in [[log]], and a line in the
daily note. Then the original is deleted. The traces are what makes deleting it safe.

## Why it gets emptied completely

An inbox that is allowed to keep things turns into a second archive, and a worse one: unsorted,
unlinked, and effectively invisible, because nobody remembers what is in there to search for it.
Half-emptying it is how that starts.

Emptying it every time is the rule that keeps "material flows downward" true instead of
aspirational.

## Related

- [[index]]
- [[log]]
- [[file_naming]]
- [[linking_rules]]

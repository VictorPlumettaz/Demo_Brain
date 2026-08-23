---
title: Example prompts
tags: [system, reference]
created: 2026-08-24
updated: 2026-08-24
---

# Example prompts

You cloned the repo, you opened it in Obsidian, you started Claude Code in the folder. Now
what do you type?

These are real prompts against *this* vault. Copy one, run it, look at what changed on disk.
The point is not the answer in the chat window — it is the file that exists afterwards.

> [!tip] The one habit that matters
> Ask for the **file**, not for the answer. "Explain X" gives you a paragraph you will lose.
> "Explain X and write it to `04_knowledge/it/`" gives you something you still have in March.

## 1 · The first five minutes

| Prompt | What it proves |
|---|---|
| `Read CLAUDE.md and 00_system/index.md, then tell me in five sentences what this vault is for.` | The steering file does the work. No prompt engineering needed. |
| `What am I working on right now, and what is blocking me?` | It reads projects and daily notes instead of asking you. |
| `Who is Marco Bevel and why does he keep showing up?` | Person pages plus backlinks beat a contacts list. |
| `Find every mention of the yield defect and give me the timeline, with dates.` | Ten daily notes become one story. |

## 2 · Asking the vault

```
What did I actually learn in the last two weeks? Not what I did — what I learned.
Group it, and link the pages it came from.
```

```
Where does this vault contradict itself? Give me file and line, and say which of the two
you think is right.
```

```
Which pages are orphans — nothing links to them? For each one: link it somewhere sensible
or tell me it should be deleted.
```

```
I am about to talk to Dana about the Cutting Optimizer rewrite. Give me one page of
preparation from what is in the vault. Mark anything you derived rather than read.
```

That last sentence is worth keeping in your own prompts. It splits "read from a file" from
"made it up", and it costs you nothing.

## 3 · Writing into the vault

```
Explain SQL window functions to me — I know joins, I have never used a window function.
Then write it as a page under 04_knowledge/it/ following the wiki page layout convention,
and link it from the existing SQL pages.
```

```
Yesterday I found out why the encoding export breaks. Turn that into a knowledge page,
add a line to the log, and mention it in today's daily note.
```

```
Add a decision to the Cutting Optimizer project: we keep the old nesting engine behind a
feature flag until release 12.4. Reason: Priya cannot sign off two engines in one release.
```

```
Take 01_inbox/2026_08_27_whiteboard_notes.md and process it. Do not create a page for
anything that appears only once.
```

## 4 · The skills

A skill is a procedure written down once, so it runs the same way every time. Type the slash
command; the file under `00_system/skills/<name>/SKILL.md` is what it follows.

| Command | Try it like this |
|---|---|
| `/session-start` | first thing in the morning — it pulls, then tells you what is open |
| `/standup` | `/standup` — three sentences, nothing else |
| `/ingest` | `/ingest` after dropping anything into `01_inbox/` |
| `/weekly-report` | `/weekly-report for last week` |
| `/invoice` | `/invoice for Glaswerk Nord, August` — fills the template, prints a PDF |
| `/cleanup` | `/cleanup` on a Saturday — it reports, it does not silently repair |
| `/session-end` | last thing — daily note, log, commit |

Then open the `SKILL.md` next to it. That is the whole trick: it is not code, it is a text
file that says what to do.

## 5 · Building your own — start from an empty folder

The fastest way to understand the idea is to make a second one from nothing. Create an empty
folder for a hobby, start Claude Code in it, and paste this:

```
Create a CLAUDE.md in this folder. It is the steering file for you, and it answers four
things:

WHO I AM: <two or three sentences. Your role, how you think, what you already know.>

WHAT YOU SHOULD BE: <the assistant you want. Tone, and one behaviour you insist on.>

WHAT THE GOAL IS: <what this folder is for, and what "done" looks like.>

WHAT YOU MUST NOT DO: <the limits. Start with: invent nothing. If you derive something,
say that it is derived.>

Keep it short.
```

Four blocks. The fourth is the one everybody forgets, and it is the one that keeps the
output honest.

Then keep going in that folder:

```
Propose a folder structure for this. Explain each folder in one line, and tell me which one
you would leave out if I wanted only three.
```

```
Write me a skill that does <the thing you do every week>. Put it in 00_system/skills/,
and explain the steps in plain sentences — not code.
```

```
I have been at this for a month. Read everything and tell me what I stopped doing.
```

## 6 · Prompts that go wrong

Not everything is a good idea. These are the ones worth avoiding.

| Do not | Why |
|---|---|
| `Reorganise the vault.` | Vague and destructive. Ask for a proposal first, then approve it. |
| `Summarise my week.` | The answer lives in the chat and is gone tomorrow. Ask for the file. |
| `Is this right?` about something not in the vault | It will answer confidently and you will not know from what. |
| `Delete everything unused.` | "Unused" is not a fact this vault stores. Ask which pages are orphans and decide yourself. |

## Related

- [[index]] — the map of this vault
- `CLAUDE.md` — the steering file every one of these prompts leans on
- `00_system/skills/` — the procedures behind the slash commands

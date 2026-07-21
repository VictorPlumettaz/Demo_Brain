---
title: Claude Code
tags: [knowledge, reference, tool, ai]
created: 2026-05-11
updated: 2026-08-21
source: Anthropic documentation, plus daily use since May
---

# Claude Code

Claude Code is an AI agent that runs in the terminal and can read, write and run things inside
one folder.

## Why it matters here

It is the other half of this vault. [[obsidian]] is how I read the folder; this is how the
folder gets maintained without me spending an hour a day on it. It writes daily notes, keeps
the frontmatter consistent, and finds the note from June that I had already forgotten writing.

## Chat versus agent

This is the distinction that took me longest to actually feel.

| | Chat | Agent |
|---|---|---|
| Sees | what you paste | the whole folder |
| Produces | text you copy somewhere | changed files |
| Remembers | the conversation | whatever is written down |
| Undo | close the tab | `git checkout` |

A chat is a conversation with a very well-read colleague who has never seen our codebase. An
agent has hands. Ask it to "tidy the frontmatter in `04_knowledge/it/`" and eleven files are
different afterwards, whether or not that was a good idea.

Two consequences, both learned the boring way:

- **Git is the undo button.** Commit before a large operation. Not out of fear — so that
  `git diff` shows exactly what it did.
- **Read the diff.** Every time. The changes are usually right, which is precisely what makes
  the wrong one easy to wave through.

## How it is steered

`CLAUDE.md` at the root of the vault is read at the start of every session. It holds who I am,
what the folders mean, the writing style and the rules. Changing behaviour means editing that
file, not repeating myself in the chat.

The useful shift: when it does something wrong twice, that is not a prompt problem, it is a
missing line in `CLAUDE.md`. Half the entries in there started as an irritation.

Repeatable jobs live in `.claude/skills/` as folders with a `SKILL.md` — `/ingest`,
`/weekly-report`, `/standup`. A skill is a written-down procedure, which means it runs the same
way in August as it did in May. Obsidian cannot see that folder, see [[obsidian]].

## What it does not know

It does not know anything I have not written down. Not what [[dana_frames]] decided in the
Tuesday meeting, not why the [[cutting_optimizer]] rounds the way it does, not which customer
is annoyed this week. If it is not in a file, it does not exist.

And it will fill the gap. Confidently, in the same tone as the parts it got from a file. I have
been handed a database column that does not exist, a plausible reason for a decision that was
actually made for a different reason, and a very reasonable-sounding statement about the
optimizer that nobody in the building had ever said.

This is not the tool being broken. It is the tool doing what it is for — producing the most
likely continuation — in a place where the likely answer and the true answer differ.

## Robin's rule

**Anything derived must be labelled as derived.**

When it tells me something about our systems, there are only two honest cases:

1. It **read** it — then it says which file, and I can check.
2. It **worked it out** — then the line says `derived, not verified`, and I go and check.

This is in `00_system/writing_style.md` as a requirement for the vault, and it is the single
rule that makes the notes trustworthy six months later. A page that mixes the two, without
saying which is which, is worse than no page, because it reads exactly as convincingly.

The same rule applies to me: I got a review comment about a line I had not written and could
not explain. That was fair, and it was entirely my fault, not the tool's. I do not commit code
I cannot defend in a review — see [[code_review_basics]].

## Practical habits

- One task at a time, with the file path in the request. "Fix the vault" produces mush.
- Make it show the plan before a big change.
- `07_private/` is off limits, and that is written down in `CLAUDE.md` rather than remembered.
- If the answer matters, it goes in a file. An answer that stays in the terminal is gone.

## Related

- [[obsidian]]
- [[writing_style]]
- [[git_basics]]
- [[code_review_basics]]
- [[moc_development]]

---
title: Convention — Linking
tags: [system, convention]
created: 2026-04-13
updated: 2026-08-18
---

# Linking

Folders store. Links think. This file is about the part that thinks.

## The four connection types

| Type | Syntax | Direction | Use it for |
|---|---|---|---|
| **Wiki link** | `[[page]]` | **both ways** — the backlink appears by itself | meaning: this belongs to that |
| Tag | `#status/open` | none | filtering and grouping |
| Query | Bases / Dataview | computed on view | overviews built from what exists |
| Embed | `![[page]]` | one way | pulling content inline |

## Links beat tags

`#priority/high` says nothing about *what* something is about.
`[[dana_frames]]` does.

Tags sort. Links connect. Most people over-tag and under-link — a tag can only ever answer
a question you already thought of, a link answers questions you have not asked yet.

Use tags for **states** (`#status/open`, `#priority/high`), links for **things**
(people, projects, concepts, products).

## Rules

1. **Link the first mention.** The first time a person, project, product or concept appears
   in a note, link it. Later mentions in the same note stay plain text.
2. **Link down, not sideways.** A daily note links to the project. The project does not
   list every daily note — the backlink panel already does that, for free.
3. **Use display text when the sentence needs it:** `[[dana_frames|Dana]]`.
4. **Unresolved links are allowed and useful.** `[[fsc_certification]]` with no page behind
   it is a note to self. Obsidian shows it greyed out. Create the page when the topic comes
   up a second time — see stub first in `wiki_page_layout.md`.
5. **Never copy a paragraph between notes.** If you want to, that paragraph is its own page.
6. **Write the filename, not the path** — `[[dana_frames]]`, not `[[04_knowledge/people/dana_frames]]`.
   Moving a file then costs nothing.

## Two exceptions to rule 6

| Case | Write it as | Why |
|---|---|---|
| Several files share a name | `[[01_inbox/README\|inbox rules]]` | Three `README.md` exist. Without the path the link is ambiguous. |
| The target is not Markdown | `[[vault_layers.canvas]]` | Obsidian needs the extension for `.canvas`, images and PDFs. |

`[[CLAUDE.md]]` keeps its extension by habit, not by need — it reads like the filename it is.
Not worth changing, worth knowing.

## What a good page links to

A knowledge page should reach at least three other pages: the topic above it (its MOC),
one related concept, and one place it was actually used. A page with no outgoing links is
a dead end, and the graph view will show it sitting alone on the edge.

## What the graph is actually for

Not navigation — search and backlinks are faster. The graph is a **diagnostic**: the lonely
dots at the edge are notes you filed and never connected. That is a to-do list, not decoration.

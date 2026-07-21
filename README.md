# Demo_Brain

A demonstration vault for the talk **"AI as a Second Brain"** (26 August 2026).

Everything in here is fictional. **Pane Relief Software Ltd.** does not exist, neither do its
employees, its customers, or its coffee machine. The structure, the conventions and the
workflows are real — they mirror a vault that has been in daily use since April 2026.

## What this is

A folder of Markdown files. That is the whole trick.

- **Obsidian** renders it, shows backlinks and the graph
- **Claude Code** reads and writes it, steered by `CLAUDE.md`
- **Git** versions it

Open the folder in Obsidian as a vault, or point any editor at it. No database, no account,
no lock-in. If all three tools disappeared tomorrow, these are still readable text files.

## Structure

| Folder | Holds | Ends? |
|---|---|---|
| `00_system/` | index, log, templates, conventions, Claude's memory | — |
| `01_inbox/` | raw material waiting to be processed | emptied every time |
| `02_projects/` | work with a defined end | yes |
| `03_areas/` | ongoing responsibility | no |
| `04_knowledge/` | the permanent wiki | never |
| `05_daily_notes/` | what happened, day by day | archived after 30 days |
| `06_archive/` | finished, resting | — |
| `07_private/` | sensitive documents | not in git |

Material flows downward. Nothing lives in the inbox permanently.

## Plugins

The repo carries each plugin's `manifest.json` and `data.json` — so you can see exactly which
plugins, which versions and which settings — but **not** the plugin code. That is not ours to
redistribute, and binaries do not belong in a text repo.

| Plugin | Why | Install |
|---|---|---|
| **Claudian** | Claude Code in an Obsidian side pane — chat next to the note instead of in a terminal | via BRAT, from `YishenTu/claudian` |
| **Dataview** | powers [`00_system/my_tasks.md`](00_system/my_tasks.md), which collects every open task from every project | community store |
| **Templater** | fills dates in the templates | community store |
| **Front Matter Title** | shows the `title:` field instead of the filename in the sidebar | community store |
| **BRAT** | installs plugins that are not in the store — needed for Claudian | community store |

Everything still works without them. A Dataview block degrades to a visible code block, and
Front Matter Title changes nothing on disk. That is the test a plugin has to pass to get in
here: **the files have to survive it being uninstalled.**

## Where to start

1. [`00_system/index.md`](00_system/index.md) — the map
2. [`CLAUDE.md`](CLAUDE.md) — how the AI is steered. The most important file in the vault.
3. [`00_system/conventions/`](00_system/conventions/) — the rules that keep it consistent
4. Open the graph view in Obsidian and turn off *orphans* and *attachments*

## The point

The AI does not know who you are, what you decided last Tuesday, or why. This folder does.
Give it the folder, and it stops guessing.

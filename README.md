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
| `00_system/` | index, log, templates, conventions, the skills | — |
| `01_inbox/` | raw material waiting to be processed | emptied every time |
| `02_projects/` | work with a defined end | yes |
| `03_areas/` | ongoing responsibility | no |
| `04_knowledge/` | the permanent wiki | never |
| `05_daily_notes/` | what happened, day by day | archived after 30 days |
| `06_archive/` | finished, resting | — |
| `07_private/` | sensitive documents | not in git |

Material flows downward. Nothing lives in the inbox permanently.

## The skills

Seven recurring procedures, each a folder with a `SKILL.md` inside — a text file that says
what to do, not code:

| Skill | What it does |
|---|---|
| `session-start` | pull first, then show what is open |
| `session-end` | write the daily note, update the log, commit |
| `ingest` | empty `01_inbox/` into the vault |
| `cleanup` | weekly maintenance — reports, never repairs silently |
| `standup` | three sentences for the morning standup |
| `weekly-report` | build the training record for a calendar week |
| `invoice` | fill the invoice template and print it to PDF |

They live in [`00_system/skills/`](00_system/skills/) so Obsidian can see them. Claude Code,
though, loads skills only from `.claude/skills/` — a hardcoded path, and Obsidian hides any
folder starting with a dot. So each skill gets a link into that folder, and the links are
**not** in the repo. After cloning, run:

```powershell
powershell -ExecutionPolicy Bypass -File 00_system\skills_link.ps1
```

Once per clone, and again whenever a skill is added. Junctions, so no administrator rights.

Tracking those links instead would look tidier and quietly break: git stores a symlink as a
42-byte text file when `core.symlinks` is off, which is the default on Windows. You end up
with seven small text files where seven folders should be, and nothing loads — without an
error message.

**This vault assumes Windows.** Shell examples are PowerShell, the link script is `.ps1`, and
`.gitattributes` pins line endings to LF in the repository so a Windows clone does not turn
every file into a diff.

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
| **Style Settings** | required by the theme below to expose its options | community store |

Everything still works without them. A Dataview block degrades to a visible code block, and
Front Matter Title changes nothing on disk. That is the test a plugin has to pass to get in
here: **the files have to survive it being uninstalled.**

## Theme

**AnuPpuccin** by Anubis, with `Full rainbow` folder colouring enabled through Style Settings.
That is where the coloured folders in the file explorer come from — they are not a feature of
Obsidian and not stored in the files.

Install the theme from *Appearance → Themes → Browse*. The settings are already in
`.obsidian/appearance.json` and `.obsidian/plugins/obsidian-style-settings/data.json`, so it
should look right as soon as the theme is present.

Purely cosmetic, and worth it anyway: on a projector, colour is the fastest way for a room to
see that the folders mean different things.

## Where to start

1. [`00_system/index.md`](00_system/index.md) — the map
2. [`CLAUDE.md`](CLAUDE.md) — how the AI is steered. The most important file in the vault.
3. [`00_system/example_prompts.md`](00_system/example_prompts.md) — what to actually type once
   it is open. Start here if you want to *do* something rather than read.
4. [`00_system/conventions/`](00_system/conventions/) — the rules that keep it consistent
5. [`00_system/skills/`](00_system/skills/) — the seven procedures, in plain English
6. Open the graph view in Obsidian and turn off *orphans* and *attachments*

## The point

The AI does not know who you are, what you decided last Tuesday, or why. This folder does.
Give it the folder, and it stops guessing.

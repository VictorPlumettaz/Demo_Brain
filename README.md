# Demo_Brain

A demonstration vault for the talk **"AI as a Second Brain"** (27 August 2026).

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
folder starting with a dot. Neither side gives way, so each skill gets a link into that folder.

**You do not have to do anything for this.** [`.claude/settings.json`](.claude/settings.json)
is tracked and runs the link script on every session start, on Windows and on macOS or Linux
alike. Clone, open Claude Code, done.

One catch worth knowing: skills are read at startup, so the very first session after a clone
still starts without them. The script says so when it happens:

```
NOTE: 7 vault skill(s) were just linked into .claude/skills/.
They load on the NEXT start of Claude Code — restart once to use them.
```

Restart once and it is set up for good. After that the script is silent — it only speaks when
it actually created something.

Tracking the links themselves instead would look tidier and quietly break: git stores a symlink
as a 42-byte text file when `core.symlinks` is off, which is the default on Windows. You end up
with seven small text files where seven folders should be, and nothing loads — without an error
message. That is why the links are generated on your machine and never travel in the repo.

**This vault was built on Windows.** Shell examples are PowerShell and `.gitattributes` pins
line endings to LF in the repository, so a Windows clone does not turn every file into a diff.
The link script exists for both worlds: `skills_link.ps1` and `skills_link.sh`.

## Plugins

All six ship with the vault — code, `manifest.json` and settings — so cloning gives you a
working vault, not a shopping list. Each one carries its licence file at
`.obsidian/plugins/<id>/LICENSE`, and here is where it came from:

| Plugin | Licence | Why it is here |
|---|---|---|
| [Style Settings](https://github.com/mgmeyers/obsidian-style-settings) | GPL-3.0 | the coloured folders stop working without it |
| [Dataview](https://github.com/blacksmithgu/obsidian-dataview) | MIT | `my_tasks.md` is just code blocks without it |
| [Templater](https://github.com/SilentVoid13/Templater) | AGPL-3.0 | fills dates in the templates |
| [Front Matter Title](https://github.com/snezhig/obsidian-front-matter-title) | GPL-3.0 | shows `title:` instead of the filename |
| [Claudian](https://github.com/YishenTu/claudian) | MIT | Claude Code in a side pane |
| [BRAT](https://github.com/TfTHacker/obsidian42-brat) | MIT | installs Claudian, which is not in the store |

MIT wants the notice passed along; GPL-3.0 and AGPL-3.0 want the source reachable, and §6(d)
allows that through the public repos linked above. Everything still works without any of them —
a Dataview block degrades to a visible code block. That is the test a plugin has to pass to get
in here: **the files have to survive it being uninstalled.**

One thing a clone cannot bring: the first time you open the vault, Obsidian asks whether to
trust the author and enable plugins. That answer lives on your machine, not in the repo, and it
should — otherwise downloading a folder would quietly run somebody else's JavaScript.

**A licence is worth reading twice.** On 16 August all six bundles were removed because
GitHub's licence API reported Style Settings as having none — it returns nothing when a repo has
no file called exactly `LICENSE`. Its `package.json` says MIT. Its `LICENSE.md`, which is what
governs, says GPL-3.0. Three sources, three answers, and the first one taken at face value cost
every clone its folder colours.

Claudian's `data.json` stays out for a different reason entirely: it holds the chat history, not
settings, and this repo is public.

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

**AnuPpuccin** by Anubis (GPL-3.0). The theme is in the repo at
`.obsidian/themes/AnuPpuccin/` with its licence beside it — `theme.css` is readable source,
9080 lines of it, which is exactly what copyleft asks you to pass on. `appearance.json` already
selects it, so there is nothing to install.

The coloured folders come from the theme's `Full rainbow` option, switched on through **Style
Settings**. The setting lives in
`.obsidian/plugins/obsidian-style-settings/data.json` and the plugin ships with the repo, so
this works on a fresh clone with nothing to configure.

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

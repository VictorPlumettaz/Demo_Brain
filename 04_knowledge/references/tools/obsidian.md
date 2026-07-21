---
title: Obsidian
tags: [knowledge, reference, tool, vault]
created: 2026-04-14
updated: 2026-08-16
source: help.obsidian.md, plus four months of daily use
---

# Obsidian

Obsidian is an editor that points at a folder of Markdown files and treats it as a connected
notebook.

## Why it matters here

It is the window onto this vault. Everything below matters for one reason: the folder stays
readable without it. That is the difference between a tool I can lose and a tool I would have
to migrate out of.

## Plain files

There is no database and no proprietary format. `04_knowledge/it/git_basics.md` is a text file
with a YAML header. This buys four things that a nicer app with its own storage cannot:

- **git works.** Line-by-line diffs, blame, history. See [[git_basics]].
- **`grep` works.** So does every editor, and so does the terminal at 7am when Obsidian is not
  open — [[terminal_cheatsheet]].
- **[[claude_code]] works.** The agent reads and writes the same files, with no export step and
  no API in between.
- **It survives the tool.** If Obsidian shut down tomorrow, I would lose the reading
  experience. I would not lose a single note.

## The four connections

Full rules in [[linking_rules]]. Short version:

| Type | Syntax | Direction |
|---|---|---|
| Wiki link | `[[dana_frames]]` | both ways, automatically |
| Tag | `#status/open` | none |
| Query | Dataview block | computed when you look |
| Embed | `![[code_review_checklist]]` | one way, pulls content in |

The wiki link is the one that does the work. Writing `[[paneflow]]` in a daily note puts that
note into PaneFlow's backlink panel without me touching the PaneFlow page. Structure appears as
a side effect of writing normally, which is the only kind of structure I have ever managed to
keep up.

## Backlinks

The panel at the bottom of every page: *what points here*. It is the reason this is not just a
folder. A folder answers "what did I file here". Backlinks answer "where did this come up",
which is the question I actually have — usually about a person or a customer.

## The graph, honestly

It looks impressive in a screenshot and I have navigated with it approximately never. Quick
switcher (`Cmd+O`) and search are faster for finding a page, and backlinks are better for
finding context.

What it is genuinely good for is **diagnosis**. Filter the graph to orphans only, and the dots
sitting alone at the edge are notes I filed and never connected to anything. That is a to-do
list. When it looks like a hairball, the same view tells me a topic has grown big enough to
need a MOC — which is how [[moc_development]] came about.

For the talk on 26 August: hide attachments and orphans, or the picture is unreadable.

## Plugins I actually use

Core, on:

- Quick switcher, Search, Backlinks, Outgoing links
- Daily notes — one file per day, template applied
- Templates

Community, six:

| Plugin | For | Worth it |
|---|---|---|
| **Claudian** | chat with Claude **inside** Obsidian, in a side pane next to the note | yes — see below |
| Dataview | the queries behind [[my_tasks]] and the MOCs | yes, it stores nothing itself |
| Templater | fills `created` and `updated` in the frontmatter so I do not | yes, small |
| Front Matter Title | shows the `title:` field instead of `cutting_optimizer_rewrite_overview.md` | cosmetic, but I read the sidebar all day |
| BRAT | installs and updates plugins that are not in the community store | only because of Claudian |
| Style Settings | lets the theme expose its options | only as a dependency of the theme |

**Theme:** AnuPpuccin, with rainbow folder colouring switched on. That is where the coloured
folders come from — not from Obsidian, and not from anything stored in the notes. Turn the
theme off and every file is exactly as it was. Which is the same test as above, and the reason
I am relaxed about a theme in a way I am not about a plugin that owns my data.

I installed fourteen in the first week and removed eleven. The rule that emerged: **a plugin is
fine if the file still makes sense with the plugin uninstalled.** A Dataview block degrades to a
visible code block — acceptable. Front Matter Title changes nothing on disk at all. A plugin
that stores its state in its own format breaks the whole point and has to go.

No Git plugin. I do not need one, because Claude commits at the end of a session — see
[[claude_code]].

## Claudian — the terminal, in the sidebar

[Claudian](https://github.com/YishenTu/claudian) puts a Claude Code session in an Obsidian
pane. Same agent, same `CLAUDE.md`, same access to the vault — but next to the note instead of
in a separate terminal window.

Why that matters more than it sounds:

- **No context switch.** The note I am asking about is open on the left. I do not describe it,
  I point at it.
- **The link between chat and file collapses.** Claude writes into the file, the file updates
  live in the pane beside it. Reading the change is the same motion as asking for it.
- **It is not a chatbot in a sidebar.** It reads and writes real files, runs commands and makes
  commits. Everything in [[claude_code]] applies unchanged — the window is the only difference.

Installed via BRAT, because it is not in the community store. That is also its main
disadvantage: no automatic vetting, and updates arrive whenever the author pushes.

**When I still use the terminal:** anything long-running, anything where I want the full output,
and every `git` operation I do not fully trust yet. The pane is for working *on a note*. The
terminal is for working *on the vault*.

## One quirk

Obsidian hides folders starting with a dot, so `.claude/` is invisible from inside the app.
The skills and the agent configuration have to be edited in a normal editor. It took me an
embarrassing while to work out why I could not find files I knew were there.

## Related

- [[claude_code]]
- [[linking_rules]]
- [[wiki_page_layout]]
- [[git_basics]]
- [[moc_development]]

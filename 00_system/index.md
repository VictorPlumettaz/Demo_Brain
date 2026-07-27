---
title: Index
tags: [system, index, moc]
created: 2026-04-13
updated: 2026-08-21
---

# Index

The map of this vault. If you do not know where something is, start here.

## The eight folders

| Folder | Holds | Ends? |
|---|---|---|
| `00_system/` | the rules: conventions, templates, log, skills | — |
| `01_inbox/` | raw material, not yet processed → [[01_inbox/README\|inbox rules]] | emptied every time |
| `02_projects/` | work with a defined end | yes |
| `03_areas/` | ongoing responsibility | no |
| `04_knowledge/` | the permanent wiki | never |
| `05_daily_notes/` | what happened, day by day | archived after 30 days |
| `06_archive/` | finished, resting | — |
| `07_private/` | sensitive, not in git → [[07_private/README\|what belongs there]] | — |

Material flows downward. See [[vault_layers.canvas]] for the picture.

## Steering

- [[CLAUDE.md]] — how the AI is steered. The most important file here.
- [[writing_style]] — how everything in this vault is written (now in `conventions/`)
- [[log]] — what was processed, when
- [[my_tasks]] — every open task, collected by query

**Conventions:** [[file_naming]] · [[wiki_page_layout]] · [[linking_rules]] ·
[[project_conventions]] · [[task_conventions]]

**Templates:** [[template_project]] · [[template_daily_note]] · [[template_person]] ·
[[template_meeting]] · [[template_knowledge_page]]

**Skills:** `00_system/skills/` — one folder per recurring procedure, each with a `SKILL.md`.
Seven of them: [[00_system/skills/session-start/SKILL|session-start]] ·
[[00_system/skills/session-end/SKILL|session-end]] · [[00_system/skills/ingest/SKILL|ingest]] ·
[[00_system/skills/cleanup/SKILL|cleanup]] · [[00_system/skills/standup/SKILL|standup]] ·
[[00_system/skills/weekly-report/SKILL|weekly-report]] ·
[[00_system/skills/invoice/SKILL|invoice]].
Behaviour rules are **not** here — they live in `CLAUDE.md`.
Claude Code loads them from `.claude/skills/`, which is filled by `skills_link.ps1`.

**Getting started:** [[example_prompts]] — what to type once the vault is open.

## Active projects

| Project | Status | Ends |
|---|---|---|
| [[cutting_optimizer_rewrite_overview]] | active | with release 12.3 |
| [[glaswerk_nord_overview]] | active | go-live 5 Oct 2026 |
| [[coffee_machine_api_overview]] | active | when I get bored |

## Areas

- [[product_support_overview]] — second-line support rota
- [[code_review_overview]] — how review works here
- [[team_overview]] — meeting rhythm, who owns what
- [[billing_overview]] — monthly customer invoicing. Register: [[invoice_ledger]]

## Knowledge

Start at a map of content rather than at a file:

- [[moc_development]] — everything technical
- [[moc_company_knowledge]] — the company, the products, the industry
- [[moc_people]] — who is who

**Company:** [[pane_relief_software]] · [[paneflow]] · [[cutting_optimizer]] · [[glossary_glass_industry]]

**References:** [[git_cheatsheet]] · [[sql_cheatsheet]] · [[terminal_cheatsheet]] ·
[[howto_set_up_dev_environment]] · [[howto_release_a_hotfix]] · [[obsidian]] · [[claude_code]]

## Archive

- [[legacy_report_export_overview]] — shipped June 2026 · [[legacy_report_export_retrospective]]
- `06_archive/daily_notes/2026_kw30/` — daily notes older than 30 days

---

*This page is maintained by hand on purpose. It is the one place where I decide what matters,
instead of letting a query decide for me.*

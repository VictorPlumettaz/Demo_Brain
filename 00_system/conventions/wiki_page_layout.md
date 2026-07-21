---
title: Convention — Wiki Page Layout
tags: [system, convention]
created: 2026-04-13
updated: 2026-08-11
---

# Wiki Page Layout

Every page in `04_knowledge/` follows the same shape, so that both a human skimming and a
model reading find things in the same place.

## Frontmatter

```yaml
---
title: REST API Basics
tags: [knowledge, it, api]
created: 2026-05-04
updated: 2026-08-12
source: PaneFlow API docs, internal wiki
---
```

`title` is what shows in the UI, `tags` drive queries, `updated` tells you whether to trust
it. `source` is only there when the content came from somewhere — if it is missing, the
content is my own understanding and may be wrong.

## Body

1. **One sentence**, plain, saying what the thing is. No warm-up.
2. **Why it matters here** — the reason this page exists in *this* vault.
3. **The content**, in short sections with `##` headings.
4. **Related** — three to five wiki links at the bottom.

Never open with "In today's fast-moving world". Start with the noun.

## Stub first

Create a page when a topic appears in **at least two** notes. Before that, leave the wiki
link unresolved. This is the single rule that keeps the vault from filling with empty pages
that say nothing but exist.

## Length

If a page passes roughly 300 lines, split it and leave a MOC behind. Long pages are
expensive to read — for you at 7am and for the model on every single request.

## Related

- [[linking_rules]]
- [[file_naming]]
- [[writing_style]]

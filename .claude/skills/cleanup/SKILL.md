---
name: cleanup
description: Weekly vault maintenance, every Saturday. Use when the user says "cleanup", "tidy the vault", or "/cleanup". Archives, compresses, checks conventions, reports what it found.
---

# Cleanup

The vault decays on its own. This is the weekly pass that catches it — the immune system,
not the surgery. Run it every Saturday, in order.

**Report, do not repair silently.** Anything that could break a wiki link (renames, moves,
deletions) gets proposed to the user, not executed.

## Steps

1. **Archive daily notes older than 30 days** to `06_archive/daily_notes/YYYY_kw<NR>/` with
   `git mv`. Weekly reports follow their week once all its days are archived. Archived notes
   older than a year: propose deleting.

2. **Empty the inbox check.** List anything in `01_inbox/`. Do **not** ingest automatically —
   report it and offer `/ingest`. A buffer with something in it is fine; a buffer with the
   same thing in it three weeks running is not, so say how old each item is.

3. **Compress images.** Find JPGs over 500 KB outside `.git/`:

   ```bash
   find . -name "*.jpg" -not -path "./.git/*" -size +500k
   ```

   Resize to 1600px wide, quality 60. Convert PNGs that sit next to notes into JPEG. Report
   the bytes saved.

4. **Check file names** against `00_system/conventions/file_naming.md`:

   ```bash
   find . -name "*.md" -not -path "./.git/*" -not -path "./.obsidian/*" -not -path "./.claude/*" \
     | while read f; do b=$(basename "$f"); echo "$b" | grep -qE '[ A-Z]' && echo "$f"; done
   ```

   `README.md`, `CLAUDE.md`, `SKILL.md` and `MEMORY.md` are the four allowed exceptions.
   Everything else: report, do not rename — renaming breaks wiki links.

5. **Check for files that should never be tracked:**

   ```bash
   git ls-files '*.DS_Store' '*.tmp' '*~' '*.m4a' '*.mp3' '*.wav'
   ```

   If anything shows up: `git rm --cached`, and check `.gitignore` covers it going forward.

6. **Frontmatter check.** Find markdown files whose first line is not `---`. Report them with
   a proposed header.

7. **Find orphans — the point of the graph.** Pages nothing links to, and pages that link
   nowhere. These are notes that were filed and never used again. Report them; the user
   decides whether to link, merge or delete.

8. **Check the conventions against reality.** Pick one convention file and verify the vault
   still follows it. Conventions rot faster than notes, because nothing errors when they are
   broken.

9. **Commit and collect garbage.**

   ```bash
   git add . && git commit -m "cleanup: weekly maintenance kw<NR>"
   git gc
   ```

10. **Report** — archived notes, images compressed and bytes saved, naming violations,
    missing frontmatter, orphans, inbox age, vault size before and after.

## Why this exists

In the first three months this vault grew a duplicate folder, a Java project filed under
knowledge, and a one-gigabyte `.git`. None of it errored. All of it was found by running
this pass.

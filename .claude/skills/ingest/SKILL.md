---
name: ingest
description: Process everything in 01_inbox/ into the vault. Use when the user says "process the inbox", "ingest", or "/ingest". Turns raw material into linked pages, updates the index and log, then empties the inbox.
---

# Ingest

Turn raw material into knowledge. The inbox is a buffer — after this runs, it is empty.

## Steps

1. **List** everything in `01_inbox/`. Show the user what you found before touching anything.

2. **Classify** each item:
   - belongs to a running project → `02_projects/<project>/`
   - ongoing responsibility → `03_areas/<area>/`
   - permanent, reusable knowledge → `04_knowledge/`
   - only relevant to one day → fold into today's daily note and delete the source
   - nothing useful → say so and propose deleting it

3. **Write the page.** Follow `00_system/conventions/wiki_page_layout.md`.
   Apply **stub first**: if the topic has appeared only once so far, do not create a page —
   put it in the daily note and leave an unresolved wiki link.

4. **Link it.** Every new page links to at least one MOC and one related page. Add the link
   from the other side only where it genuinely belongs — backlinks handle the rest.

5. **Leave three traces:**
   - the target page itself
   - one line in `00_system/log.md`
   - one line in today's note in `05_daily_notes/`

6. **Deal with the original:**
   - a source worth keeping (PDF, scan, spreadsheet) → move it next to the page that
     describes it, compressed if it is large
   - audio → transcribe, process the transcript, **delete the audio**
   - a photo of a whiteboard → once the content is in a page, delete the photo
   - everything else → delete

7. **Empty the inbox.** If something cannot be processed, say why and leave exactly that
   one item. An inbox that still has five things in it did not get processed.

8. **Commit:** `git add . && git commit && git push`

## Rules

- **Never invent content** to fill a page. If the source is unclear, ask.
- **Never copy a paragraph** into two pages. It becomes its own page and both link to it.
- If an item is sensitive, it goes to `07_private/` and gets no wiki page.
- Report at the end: what was created, what was moved, what was deleted.

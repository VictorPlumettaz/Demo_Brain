---
title: Legacy Report Export — Overview
tags: [project, archive, legacy-report-export, paneflow]
status: done
started: 2026-04-27
finished: 2026-06-19
created: 2026-04-27
updated: 2026-08-17
---

# Legacy Report Export

## Goal

Replace the report export in [[paneflow]] with something we can explain, without breaking the three
customers who parse the old file with scripts they wrote themselves.

Done meant three things: the new export shipped and documented, the old format still byte-identical
behind a feature flag, and every one of the three customers either moved to the new export or
explicitly staying on the old one.

## Status

Done. Shipped in PaneFlow 4.1.6 on 19 June 2026. My first project end to end.

Two of the three customers moved to the new export by the end of July. The third has no developer of
their own and no plan to move, so the legacy flag stays on for them. That is not an open task —
there is nothing to do until they ask.

## What it was

One stored procedure, `sp_ReportExportV2`, last changed in 2014 by someone who left the company in
2016. 47 columns, semicolon separated, headers in German, three of them duplicated under different
names, two always empty. No documentation anywhere, in any system. Customers parsed it by column
position, which meant inserting a column anywhere broke a nightly job at a glass plant.

About 1,100 lines of T-SQL. Reading it is how I learned most of what I know about [[sql_joins]].

## Decisions

| Date | Decision | Why | Rejected alternative |
|---|---|---|---|
| 2026-04-29 | Keep the old format byte-identical behind a feature flag | Three customers parse by column position. Any change at all is a broken nightly job on their side | Ship only the new format with a migration window. Dropped after [[lena_mullion]] pointed out one of the three has no developer at all |
| 2026-05-04 | Write down what all 47 columns mean before writing any code | Nobody in the company could answer it. Took four days and found that 16 columns had no consumer | Reimplement the procedure as-is in C# and move on |
| 2026-05-06 | New export has 31 columns with English headers, documented | The 16 dead columns had no consumer. Verified against what the three customers' parsers actually read, not against the procedure | Keep all 47 for symmetry with the old file |
| 2026-05-11 | UTF-8 **with BOM**, semicolon separator | The customers open the file in German Excel. Without the BOM, Excel guesses Windows-1252 and the umlauts break. The semicolon is what a German Excel locale expects | Plain UTF-8, comma separated, "because that is the standard" |
| 2026-05-19 | Golden-master test: run old and new against the same 30 production-shaped datasets and compare byte for byte | The old procedure is the only specification that exists for the legacy path. A test is the only way to keep it honest | Unit test each column against what the documentation says. There was no documentation |
| 2026-06-02 | Sum first, round once, for the area columns | The old procedure rounded each line to two decimals and then summed, which was off by up to 0.4 m² on a large order. [[marco_bevel]] found it in review | Keep the old rounding for compatibility. Rejected: it was wrong, and no customer's parser depends on being wrong |
| 2026-06-15 | Ship behind the flag, default off, switch one customer at a time | Three customers going live on the same evening is three times the risk on one evening | Big-bang switch in 4.1.6 |

The column that mattered later was **Why**. In August someone asked why the export is not comma
separated like everything else, and the answer was in this table instead of in an argument.

## Open questions

All closed before the release.

- Which columns does each customer actually parse? — answered 2026-05-06 by [[lena_mullion]] out of
  old support mail, in about twenty minutes
- Can we drop the German headers? — yes, all three parse by position, answered 2026-05-06
- Does anyone use the two empty columns? — no. They have been empty since 2014

## Numbers

| | Old | New |
|---|---|---|
| Columns | 47 | 31 |
| Pages of documentation | 0 | 1 |
| Code | ~1,100 lines T-SQL | 340 lines C#, 190 lines test |
| Runtime, largest customer dataset | 41 s | 6 s |

## Related

- [[legacy_report_export_retrospective]]
- [[paneflow]]
- [[sql_joins]]
- [[unit_testing]]
- [[moc_development]]

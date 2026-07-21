---
title: SQL Joins
tags: [knowledge, it, sql]
created: 2026-05-19
updated: 2026-08-05
---

# SQL Joins

A join combines rows from two tables using a condition, and the join *type* decides what
happens to the rows that find no partner.

## Why it matters here

Nearly every support question at [[product_support_overview]] ends in a query against the
[[paneflow]] database — "which orders have no cutting pattern yet", "which panes sit on a sheet
never consumed". A wrong join type produces no error, only a plausible number that is wrong.

## The tables

Simplified from PaneFlow. A **lite** is one finished pane, a **sheet** the plate it is cut from
([[glossary_glass_industry]]).

```
orders                      lites                                  sheets
order_id  customer          lite_id  order_id  width_mm  sheet_id   sheet_id  thickness_mm
4711      Glaswerk Nord     1        4711      1200      900        900       4
4712      Glaswerk Nord     2        4711       800      900        901       6
4713      Fensterbau Sud    3        4712      1500      NULL
                            4        9999       600      901
```

Lite 4 belongs to order 9999, which does not exist: an import ran before the order was rolled
back.

## The four types

Same query throughout, only the first word changes:
`SELECT o.order_id, l.lite_id FROM orders AS o … JOIN lites AS l ON l.order_id = o.order_id`.

| Type | Keeps | Rows here |
|---|---|---|
| `INNER JOIN` | only pairs matching on both sides | 3 |
| `LEFT JOIN` | all of `orders`, matching lites, `NULL` where none | 4 |
| `RIGHT JOIN` | all of `lites`, matching orders, `NULL` where none | 4 |
| `FULL OUTER JOIN` | everything from both sides, padded with `NULL` | 5 |

`INNER` gives lites 1, 2, 3 — order 4713 and lite 4 drop out silently. `LEFT` adds
`(4713, NULL)`, the order with no panes yet. `RIGHT` adds `(NULL, 4)`, the orphan from the
import. `FULL OUTER` shows all five rows and therefore both problems at once. `RIGHT JOIN` is
just `LEFT JOIN` with the tables swapped, so I write `LEFT` and reorder; `FULL OUTER JOIN`
exists on SQL Server and PostgreSQL but not on MySQL.

## The trap

```sql
-- looks like a LEFT JOIN, is silently an INNER JOIN
SELECT o.order_id, l.lite_id
FROM orders AS o
LEFT JOIN lites AS l ON l.order_id = o.order_id
WHERE l.width_mm > 1000;
```

The join produces `(4713, NULL)` as intended. Then `WHERE` evaluates `NULL > 1000`, which is not
true, and the row is discarded. Any condition on the right-hand table in `WHERE` removes exactly
the rows the `LEFT JOIN` was there to keep.

The fix is to filter in `ON`, which is applied while the join is being built:

```sql
SELECT o.order_id, l.lite_id FROM orders AS o
LEFT JOIN lites AS l ON l.order_id = o.order_id
                    AND l.width_mm > 1000;
```

Rule of thumb: conditions about the **right** table belong in `ON`, about the **left** table in
`WHERE`. The exception is the anti-join, where the `NULL` test is the point, not an accident:

```sql
-- orders with no lites at all
SELECT o.order_id FROM orders AS o
LEFT JOIN lites AS l ON l.order_id = o.order_id
WHERE l.lite_id IS NULL;
```

## Related

- [[sql_cheatsheet]]
- [[support_ticket_patterns]]
- [[moc_development]]

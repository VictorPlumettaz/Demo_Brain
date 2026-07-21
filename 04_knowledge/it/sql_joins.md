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
[[paneflow]] database — "which orders have no cutting pattern yet", "which panes sit on a
sheet that was never consumed". Getting the join type wrong does not produce an error. It
produces a plausible number that is quietly wrong, which is worse.

## The tables

Simplified from PaneFlow. A **lite** is one finished pane, a **sheet** is the large raw plate
it is cut from — [[glossary_glass_industry]].

```
orders                      lites                                  sheets
order_id  customer          lite_id  order_id  width_mm  sheet_id   sheet_id  thickness_mm
4711      Glaswerk Nord     1        4711      1200      900        900       4
4712      Glaswerk Nord     2        4711       800      900        901       6
4713      Fensterbau Sud    3        4712      1500      NULL
                            4        9999       600      901
```

Lite 4 belongs to order 9999, which does not exist — left behind by an import that ran before
the order was rolled back.

## The four types

```sql
SELECT o.order_id, l.lite_id
FROM orders AS o
INNER JOIN lites AS l ON l.order_id = o.order_id;
```

| Type | Keeps | Rows here |
|---|---|---|
| `INNER JOIN` | only pairs matching on both sides | 3 |
| `LEFT JOIN` | all of `orders`, matching lites, `NULL` where none | 4 |
| `RIGHT JOIN` | all of `lites`, matching orders, `NULL` where none | 4 |
| `FULL OUTER JOIN` | everything from both sides, padded with `NULL` | 5 |

- `INNER` → lites 1, 2, 3. Order 4713 and lite 4 drop out silently.
- `LEFT` → those three plus `(4713, NULL)`. Order 4713 has no panes yet.
- `RIGHT` → those three plus `(NULL, 4)`, the orphan from the import.
- `FULL OUTER` → all five. Both problems visible at once.

`RIGHT JOIN` is a `LEFT JOIN` with the tables swapped, so I write `LEFT` and reorder instead —
a query containing both directions is hard to read. `FULL OUTER JOIN` exists on SQL Server and
PostgreSQL; MySQL does not have it.

## The trap

This looks like a `LEFT JOIN` and is not one:

```sql
-- WRONG: silently an INNER JOIN
SELECT o.order_id, l.lite_id
FROM orders AS o
LEFT JOIN lites AS l ON l.order_id = o.order_id
WHERE l.width_mm > 1000;
```

The join produces `(4713, NULL)` as intended. Then `WHERE` evaluates `NULL > 1000`, which is
not true, and the row is thrown away. Any condition on the right-hand table in `WHERE` removes
exactly the rows the `LEFT JOIN` was there to keep.

The fix is to filter in `ON`, which is applied while the join is being built:

```sql
SELECT o.order_id, l.lite_id
FROM orders AS o
LEFT JOIN lites AS l
       ON l.order_id = o.order_id
      AND l.width_mm > 1000;
```

Rule of thumb: conditions about the **right** table belong in `ON`, conditions about the
**left** table belong in `WHERE`.

The one deliberate exception is the anti-join — asking for rows that found no partner:

```sql
-- orders with no lites at all
SELECT o.order_id
FROM orders AS o
LEFT JOIN lites AS l ON l.order_id = o.order_id
WHERE l.lite_id IS NULL;
```

Here the `NULL` test is the point rather than an accident.

## Related

- [[sql_cheatsheet]]
- [[glossary_glass_industry]]
- [[support_ticket_patterns]]
- [[moc_development]]

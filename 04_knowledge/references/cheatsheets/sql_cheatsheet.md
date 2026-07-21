---
title: SQL Cheatsheet
tags: [knowledge, reference, cheatsheet, sql]
created: 2026-05-20
updated: 2026-08-14
source: Microsoft T-SQL reference; dialect notes checked against PostgreSQL docs
---

# SQL Cheatsheet

T-SQL, because [[paneflow]] runs on SQL Server. Where another dialect differs, it is in the
last column. Join types have their own page: [[sql_joins]].

## Clause order

Written order and execution order are not the same, which explains most surprises.

| Written | Evaluated |
|---|---|
| `SELECT` | 6 |
| `FROM` / `JOIN` … `ON` | 1 |
| `WHERE` | 2 |
| `GROUP BY` | 3 |
| `HAVING` | 4 |
| `DISTINCT` | 7 |
| `ORDER BY` | 8 |
| `OFFSET … FETCH` | 9 |

Consequence: a column alias created in `SELECT` cannot be used in `WHERE`, but can be used in
`ORDER BY`. `WHERE` filters rows, `HAVING` filters groups.

## Basics

```sql
SELECT TOP (10) o.order_id, o.customer, o.due_date
FROM   dbo.orders AS o
WHERE  o.due_date >= '2026-08-01'
   AND o.status <> 'cancelled'
ORDER BY o.due_date;
```

| Task | T-SQL | Elsewhere |
|---|---|---|
| First n rows | `SELECT TOP (10) …` | `LIMIT 10` |
| Page 3, 10 per page | `ORDER BY x OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY` | `LIMIT 10 OFFSET 20` |
| Now | `GETDATE()`, `SYSDATETIME()` | `now()` |
| Concatenate | `CONCAT(a, b)` or `a + b` | `a \|\| b` |
| Null fallback | `ISNULL(a, 0)` | `COALESCE(a, 0)` works everywhere |

`OFFSET … FETCH` requires an `ORDER BY`. Without one, the order is undefined and paging
silently repeats rows.

## Grouping

```sql
SELECT   l.sheet_id,
         COUNT(*)          AS lite_count,
         SUM(l.area_sqm)   AS area_sqm,
         MAX(l.height_mm)  AS tallest
FROM     dbo.lites AS l
GROUP BY l.sheet_id
HAVING   COUNT(*) > 5;
```

- Every selected column that is not aggregated must appear in `GROUP BY`.
- `COUNT(*)` counts rows, `COUNT(col)` skips `NULL`s. They differ more often than expected.
- `AVG` over an `int` column does integer division. Cast first:
  `AVG(CAST(width_mm AS decimal(10,2)))`.

## NULL

| Want | Write |
|---|---|
| is it empty | `WHERE sheet_id IS NULL` — `= NULL` is never true |
| default value | `COALESCE(sheet_id, -1)` |
| turn a value into NULL | `NULLIF(width_mm, 0)` — handy against divide-by-zero |

Trap: `WHERE order_id NOT IN (SELECT order_id FROM lites)` returns **no rows at all** if that
subquery contains a single `NULL`. Use `NOT EXISTS` instead:

```sql
SELECT o.order_id
FROM   dbo.orders AS o
WHERE  NOT EXISTS (SELECT 1 FROM dbo.lites AS l WHERE l.order_id = o.order_id);
```

## Strings and dates

```sql
LEN('4 mm')                     -- 4, trailing spaces ignored (use DATALENGTH for bytes)
SUBSTRING('float glass', 1, 5)  -- 'float', 1-based
UPPER(x), LOWER(x), TRIM(x), REPLACE(x, ' ', '')
x LIKE 'GN-%'                   -- % any run, _ exactly one

DATEADD(day, -7, GETDATE())
DATEDIFF(day, o.created_at, o.due_date)
CAST(o.created_at AS date)
```

Do not wrap the column in a function when filtering — the index stops being used:

```sql
-- slow
WHERE CAST(created_at AS date) = '2026-08-17'
-- fast
WHERE created_at >= '2026-08-17' AND created_at < '2026-08-18'
```

## CASE, CTE, window functions

```sql
SELECT order_id,
       CASE WHEN due_date < GETDATE() THEN 'late'
            WHEN due_date < DATEADD(day, 2, GETDATE()) THEN 'soon'
            ELSE 'ok' END AS urgency
FROM dbo.orders;
```

```sql
WITH latest AS (
    SELECT l.*,
           ROW_NUMBER() OVER (PARTITION BY l.order_id ORDER BY l.created_at DESC) AS rn
    FROM   dbo.lites AS l
)
SELECT * FROM latest WHERE rn = 1;   -- newest lite per order
```

`PARTITION BY` = "restart the numbering per group". The same shape with `rn > 1` finds
duplicates, and in T-SQL you can `DELETE FROM latest WHERE rn > 1` straight out of the CTE.

## Changing data without regret

```sql
BEGIN TRANSACTION;

UPDATE l
SET    l.sheet_id = 902
FROM   dbo.lites AS l
JOIN   dbo.orders AS o ON o.order_id = l.order_id
WHERE  o.customer = 'Glaswerk Nord';

-- check the row count, then one of:
ROLLBACK TRANSACTION;
COMMIT TRANSACTION;
```

House rules, learned from watching someone else's afternoon disappear:

1. Write it as a `SELECT` first and look at the rows.
2. Wrap it in a transaction. Type the `ROLLBACK` before the `COMMIT`.
3. Never run an `UPDATE` on production without a `WHERE`, even a pointless one.

## Looking at performance

| Want | Do |
|---|---|
| the plan | Ctrl+M in SSMS, or `SET SHOWPLAN_XML ON` |
| how much was read | `SET STATISTICS IO ON` |
| is there an index | `sp_helpindex 'dbo.lites'` |

## Related

- [[sql_joins]]
- [[paneflow]]
- [[support_ticket_patterns]]
- [[moc_development]]

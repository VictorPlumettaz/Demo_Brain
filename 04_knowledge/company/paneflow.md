---
title: PaneFlow
tags: [knowledge, company, product]
created: 2026-04-16
updated: 2026-08-20
source: internal wiki, module owners, and a lot of asking Marco
---

# PaneFlow

PaneFlow is our production and ERP system for glass plants. An order comes in as a list of
glass panes, and PaneFlow carries it all the way to the lorry: pricing, material, cutting
layouts, machine sequence, racks, delivery note, invoice.

This page is my map of it, written as an apprentice. It is what I have understood so far, not
what the product sheet says. Where I am guessing, I say so.

## What it actually does, in order

1. **Order entry** — the customer wants 40 units of a given build-up in given sizes.
2. **Master data resolves it** — a build-up like `4/16Ar/4 low-E` becomes concrete lites of
   concrete glass types. See [[glossary_glass_industry]] for the vocabulary.
3. **Optimisation** — the [[cutting_optimizer]] works out how to cut those lites out of stock
   sheets with the least waste.
4. **Scheduling** — the cutting patterns become work for real machines on real days.
5. **Shopfloor** — terminals at each station report what was made, broken, or remade.
6. **Logistics** — finished lites go onto racks in the order the lorry will unload them.
7. **Invoicing and reporting.**

Step 6 surprised me. Rack order is planned backwards from the building site, because the
first pane off the rack has to be the first one fitted.

## Modules

| Module | Does | Ownership |
|---|---|---|
| Order entry & quoting | Orders, offers, pricing | Production team |
| Master data | Glass types, build-ups, articles, machines | Production team |
| Optimisation | [[cutting_optimizer]] | [[marco_bevel|Marco]], being rewritten |
| Production scheduling | Capacity, sequence, dates | Production team |
| Shopfloor terminals | Station feedback, breakage reporting | Web & Shopfloor |
| Machine interfaces | Cutting tables, tempering ovens, IG lines | Interfaces team |
| Logistics | Racks, routes, delivery notes | Production team |
| Invoicing | Prices, credits, statistics | Production team |
| Reporting | Everything nobody else wanted | historically nobody |

## How old it is

First release 2003, C# on .NET, SQL Server underneath. Parts of the pricing logic were ported
line by line from a VB6 predecessor and still read like it. A full rewrite was started in 2014
and abandoned in 2015; people still reference it as a warning, and the branch is still in the
repository.

Roughly 1.9 million lines according to a script Marco ran once. Derived, not verified.

## The parts everyone is afraid of

- **PriceEngine.** Customer-specific pricing rules stacked over twenty years. Nobody changes
  it on a Friday. Nobody changes it alone.
- **Production scheduling.** Works. Nobody can say exactly why it works.
- **The stored procedures.** `sp_calc_2`, `sp_calc_2_new`, `sp_calc_2_new_fix`. All three are
  called from somewhere.
- **Report export.** Was so bad it got its own project to replace it →
  [[legacy_report_export_retrospective]].

## What I have understood

- The order is not the unit of work. The **batch** is. Optimisation, cutting and scheduling
  all run over batches, and a batch mixes lites from many orders that share one material.
- Almost every table has `valid_from` / `valid_to`. Prices and build-ups change, and old
  orders have to keep recalculating with the values they had at the time.
- Breakage is normal, not exceptional. A remake flowing back into an existing batch is a
  first-class case, not an edge case. It took me a month to stop treating it as an error path.

## What still confuses me

- **Article vs. item vs. position.** Three words, three tables, and in conversation people use
  all three for the same thing.
- Why one order line can produce three lites, and why the count sometimes changes after
  master data resolves it.
- The difference between the planning date and the "capacity day". Marco explained it twice.
  I can repeat the explanation but I cannot use it.
- Why the [[cutting_optimizer]] runs against a batch and the scheduler runs against an order,
  and who reconciles the two when a batch is split.

## Related

- [[pane_relief_software]]
- [[cutting_optimizer]]
- [[glossary_glass_industry]]
- [[moc_company_knowledge]]
- [[product_support_overview]]

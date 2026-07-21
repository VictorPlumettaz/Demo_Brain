---
title: Glossary — Glass Industry
tags: [knowledge, company, glossary]
created: 2026-04-18
updated: 2026-08-21
source: Lena Mullion, Marco Bevel, EN 1279 / EN 12150 / EN 14179, plus manufacturer datasheets
---

# Glossary — Glass Industry

The words our customers use in every call and every ticket. I started this page after sitting
through three onboarding calls nodding at "build-up" without knowing what it meant.

Not software terms. These are the physical things [[paneflow]] is modelling, and getting one
of them wrong in a ticket wastes somebody's afternoon.

## Raw material and sizes

| Term | Means |
|---|---|
| **Float glass** | Flat glass made by floating molten glass on a bath of molten tin, which gives it two flat parallel surfaces. Nearly all window glass is float glass. |
| **Tin side** | The face that lay on the tin bath. Slightly different chemistry, visible under UV light, and it decides which way round a pane gets coated or laminated. |
| **Jumbo sheet** | The largest standard stock size off the float line, 6000 × 3210 mm. Divided formats are roughly half that, around 3210 × 2250 mm. |
| **Lite** | One single pane of glass. A double-glazed unit is two lites, not one. Also spelled "light" in older documents. |
| **Cullet** | Broken or scrap glass, collected and melted back into the furnace. Recycled, but worth a fraction of a finished pane. |

## Heat treatment

| Term | Means |
|---|---|
| **Annealing** | Cooling the glass slowly in a long oven (a lehr) so it does not lock in internal stress. Annealed glass can still be cut and drilled. |
| **Tempering** (toughening) | Heating to around 620 °C and quenching with cold air. The surface ends up in compression: four to five times stronger, and it breaks into small blunt fragments instead of shards. It cannot be cut afterwards — a score shatters it. |
| **Heat-strengthened glass** | Same process, gentler quench. Around twice the strength of annealed, breaks into large pieces, and it is not a safety glass. |
| **Heat soak test** | After tempering, the glass is held at 290 °C for at least two hours (EN 14179) so that any pane with a nickel sulfide inclusion — a tiny impurity that expands over years — breaks in the oven instead of in a facade five years later. It is a destructive test on purpose. |

## Assembly

| Term | Means |
|---|---|
| **Laminated glass** | Two or more lites bonded by a plastic interlayer, usually PVB, under heat and pressure in an autoclave. It cracks but holds together, which is why it is used overhead and in cars. |
| **Insulating glass unit (IGU)** | Two or three lites held apart by a spacer and sealed round the edge, with the cavity filled with dry air or argon. What people mean by "double glazing". |
| **Spacer bar** | The hollow profile that holds the lites apart in an IGU. It is filled with desiccant, a drying agent that soaks up the moisture in the cavity so the unit does not fog up. "Warm edge" spacers use plastic or thin steel instead of aluminium to lose less heat at the edge. |
| **Low-E coating** | An almost invisible metallic coating, usually silver-based, that reflects long-wave heat radiation back into the room. Soft coat is applied after the float line and is fragile; hard coat is applied during production and survives handling. |
| **Edge deletion** | Grinding the low-E coating off a strip round the edge of a lite before it goes into an IGU, so the sealant bonds to bare glass and the coating cannot corrode inwards from the edge. |
| **Build-up** | The recipe for a unit, written as numbers: `4/16Ar/4` is a 4 mm lite, a 16 mm argon-filled cavity, another 4 mm lite. Our master data is full of these. |

## In the building

| Term | Means |
|---|---|
| **Mullion** | The vertical bar between one glazed unit and the next in a window or facade. |
| **Transom** | The horizontal one. |

## On the production floor

| Term | Means |
|---|---|
| **Yield** | The share of consumed sheet area that leaves as ordered panes. The number the [[cutting_optimizer]] is judged on. |
| **Remnant** | A leftover piece big enough to be worth putting back in stock and cutting from later. Below the plant's minimum handling size it is not a remnant, it is cullet. |
| **Guillotine cut** | A score that runs from one edge of a piece to the opposite edge. Every cut on a glass table is one of these, which is the whole reason cutting layouts look the way they do. |

## Terms I still get wrong

- I asked [[marco_bevel|Marco]] three times what a heat soak test is for. I could write the
  definition above only after looking up the standard myself. Ask me on Monday and I will
  probably say "it heats the glass up" and stop there.
- **Lite** and **unit**. A customer saying "40 units" and a customer saying "40 lites" mean
  numbers that differ by a factor of two or three, and both are said in the same tone of voice.
- Soft coat vs. hard coat low-E. I know they differ. I could not tell you which one a given
  order needs without asking [[lena_mullion|Lena]].

## Related

- [[paneflow]]
- [[cutting_optimizer]]
- [[pane_relief_software]]
- [[moc_company_knowledge]]
- [[support_ticket_patterns]]

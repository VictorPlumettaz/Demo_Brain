---
title: Coffee Machine API — Findings
tags: [project, api, findings, security]
created: 2026-07-11
updated: 2026-08-20
---

# Findings

What the machine actually does when you talk to it. Written up as I went, so the order is
chronological rather than sensible.

Device: bean-to-cup unit, second floor kitchen, hostname `kaffee-02`, listening on port 8080.
No documentation exists. Everything below came from watching what its own web interface sends.

## The endpoints

| Path | Method | Returns |
|---|---|---|
| `/api/v1/status` | GET | machine state, water, waste tray, boiler temperature |
| `/api/v1/counters` | GET | drink counters since midnight |
| `/api/v1/config` | GET | grinder, brew and rinse settings |
| `/api/v1/config` | POST | accepts the same object back |

There are probably more. I stopped looking after the last row of that table.

## The JSON

`GET /api/v1/counters` returns this:

```json
{
  "machine": "kaffee-02",
  "uptime_s": 486122,
  "counters": {
    "espresso": 41,
    "coffee": 63,
    "cappuccino": 22,
    "americano": 9,
    "hot_water": 14,
    "rinse": 3
  },
  "beans_g": 1840,
  "waste_tray": "ok",
  "ts": "2026-07-13T15:04:11+02:00"
}
```

Notes on the fields:

- `rinse` is the machine cleaning itself. Not a drink, excluded from all totals.
- `hot_water` is mostly tea. Counting it as coffee makes the office look more caffeinated than it
  is, so I do not.
- `beans_g` is an estimate the machine makes, not a measurement. It jumps by 40 grams sometimes.
- `ts` carries a proper timezone offset, which is more than I can say for some of our own
  interfaces.

## The auth header

GET requests returned `401 Unauthorized` until I sent the header the machine's own web interface
sends. The header is `X-Auth`.

The value is the word `service`.

Not a token. Not a hash of anything. Not rotated. The seven characters `s-e-r-v-i-c-e`, sent as
plain text over plain HTTP. I checked it three times, then wrote a test that fails if it ever
changes, mostly because I did not believe it and wanted to be told when I was wrong.

It is also printed on the machine's built-in help page, which is served without any auth at all.

## The counters reset at midnight

The counters are since local midnight, not lifetime totals. I found this out from my own data:
the first chart showed the office drinking 63 coffees and then, at 00:00, minus 63 coffees.

Fixed by storing the delta between consecutive polls and discarding any negative delta, which by
definition is the reset. Consequence: if the poller is asleep at 23:55, the last five minutes of
that day are lost forever. Two days in the dataset are short for exactly this reason and I have
left them short rather than guess.

## POST /api/v1/config

This is the part I did not expect.

The endpoint that returns the settings also accepts them. I sent back the object I had just read,
with `grind` changed from 6 to 4 — a finer grind, which over-extracts and tastes burnt.

The machine answered:

```
HTTP/1.1 200 OK
{"ok": true}
```

The next coffee was noticeably worse. I set the value back to 6 about ninety seconds later.
Nobody said anything, which I am choosing not to read too much into.

Written out plainly, without the coffee:

- an unauthenticated device on the office network accepts configuration writes over plain HTTP
- the credential is a fixed string printed on the device's own unauthenticated help page
- the device is not on a separate VLAN — I reached it from my laptop with no special access,
  from a wifi network that a visitor could be on
- the grind setting is the least interesting thing on that endpoint. `config` also contains brew
  temperature and the rinse schedule, and I did not test those and will not
- it is a coffee machine, so nobody has ever patched it and nobody was ever going to

Should I have sent that POST? No. I wanted to know whether it would refuse. It did not refuse.
That is the finding, and I could not have had the finding without doing the thing I had agreed
not to do, which is an uncomfortable sentence that I am leaving in.

## What I am doing about it

Telling [[nils_putty]] on Monday 24 August, in person, before he finds it in a log and asks me
about it in a worse setting.

The reason is not the coffee. The reason is that "an undocumented device on the office network
accepts unauthenticated configuration writes" is a sentence that stops being funny the moment you
take the word coffee out of it, and Nils is the person whose job that sentence belongs to.

I am also telling him that I wrote to it, because he will find that too, and because
[[dana_frames]] set exactly one hard condition on this project and I broke it. That goes into the
conversation as well. It is a worse conversation and it is the correct one.

Both are on the task list in [[coffee_machine_api_tasks]] so that I cannot quietly not do them.

## Related

- [[coffee_machine_api_overview]]
- [[coffee_machine_api_tasks]]
- [[rest_api_basics]]
- [[logging_basics]]

---
title: REST API Basics
tags: [knowledge, it, api]
created: 2026-05-04
updated: 2026-08-12
source: PaneFlow API docs, internal wiki
---

# REST API Basics

A REST API is a set of URLs that stand for things, which you read and change with the normal
HTTP verbs.

## Why it matters here

The [[paneflow]] API is how customers get orders in and cutting patterns out, and it is the
first thing I get asked about in [[product_support_overview]]. I also learned most of this the
hard way on the [[coffee_machine_api_overview]] side project, where the machine does nearly
everything wrong and therefore explains what "right" means.

## Verbs

| Verb | Means | Safe? | Idempotent? |
|---|---|---|---|
| `GET` | read, change nothing | yes | yes |
| `POST` | create, or trigger something | no | no |
| `PUT` | replace the whole resource | no | yes |
| `PATCH` | change part of the resource | no | not guaranteed |
| `DELETE` | remove it | no | yes |

*Idempotent* means sending it five times leaves the same result as sending it once. Networks
drop answers, and a client that retries must not end up creating five orders.

```http
GET    /api/v1/orders/4711            → the order
GET    /api/v1/orders/4711/lites      → the panes belonging to it
POST   /api/v1/optimization-runs      → start a run, returns 202
```

The URL names a **thing**, not an action. `POST /orders/4711/cancel` is a verb glued onto a
noun and strictly not REST — we have three of those in v1 and nobody is going to remove them.

## Status codes

| Code | Meaning | Where it shows up here |
|---|---|---|
| 200 | fine, body attached | every `GET` |
| 201 | created, `Location` header points at it | `POST /orders` |
| 202 | accepted, not finished yet | optimisation runs, they take minutes |
| 204 | fine, nothing to send back | `DELETE` |
| 400 | your request is malformed | broken JSON |
| 401 | I do not know who you are | token missing or expired |
| 403 | I know who you are, you may not do this | wrong customer's order |
| 404 | no such thing | wrong order number |
| 409 | conflict with the current state | order already in production |
| 429 | too many requests | the import script of [[glaswerk_nord_overview]] |
| 500 | our fault | check the logs, see [[logging_basics]] |

401 and 403 get mixed up constantly. 401 is authentication, 403 is permission.

## JSON and headers

The body is JSON; the headers say how to read it and who is asking.

| Header | Purpose |
|---|---|
| `Content-Type: application/json` | what I am sending |
| `Accept: application/json` | what I want back |
| `Authorization: Bearer <token>` | who I am |
| `X-Request-Id` | correlation id, ends up in our logs |

## Stateless

The server remembers nothing about the client between two requests. Every request carries what
is needed to answer it, including the token. The payoff: any of the three PaneFlow instances
behind the load balancer can answer any request, and restarting one loses nobody's session.

The coffee machine is the counter-example. It keeps one "current brew" in memory and any client
on the network can cancel it, because that state is not tied to who asked — which is exactly
the race in [[coffee_machine_api_findings]]. It also answers `200 OK` with
`{"ok": false, "error": "NO_CUP"}`: the status line says success, the body says failure, and
every HTTP client believes the status line.

## Related

- [[coffee_machine_api_findings]]
- [[logging_basics]]
- [[support_ticket_patterns]]
- [[moc_development]]

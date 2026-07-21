---
title: Logging Basics
tags: [knowledge, it, operations, status/draft]
created: 2026-07-07
updated: 2026-08-13
---

# Logging Basics

A log is the only record of what the software did on a machine you cannot reach.

## Why it matters here

"It works on my machine" almost always means nobody logged anything. Half the tickets in
[[support_ticket_patterns]] arrive as a customer describing a symptom plus a log file that says
`Error occurred`. One of those cost three days.

## Levels

| Level | Use it for | Read by |
|---|---|---|
| `Trace` | every step, off in production | me, for an hour |
| `Debug` | values inside a calculation | me, on staging |
| `Information` | something happened that a human would name | support |
| `Warning` | wrong but survivable — retry worked, fallback used | support |
| `Error` | this operation failed | whoever is on call |
| `Critical` | the service is down | everyone |

If everything is a `Warning`, nobody reads warnings.

## Never log

Customer names, addresses, order contents. Connection strings, tokens, passwords. Whole request
bodies "just in case". Log the **id**, not the data: `Order 4711 failed` is enough to find it
in the database and does not put a customer address into a text file that gets emailed around.

## Structured logging

Do not build the message by concatenation. Use the template and pass the values — Serilog then
stores each one as its own searchable field.

```csharp
// no
_logger.LogInformation("Run " + runId + " took " + ms + " ms");

// yes
_logger.LogInformation(
    "Optimization run {RunId} finished in {ElapsedMs} ms with yield {Yield}",
    runId, ms, yield);
```

The first is a sentence. The second lets me ask "all runs slower than 30 seconds last week",
which is a question I have actually needed.

## Still missing

Ran out of time. To finish when I next touch this:

- correlation ids — `X-Request-Id` from [[rest_api_basics]] is passed through, [[nils_putty]]
  explained how the log pipeline picks it up and I did not write it down
- where the logs go once they leave the container
- per-namespace levels in `appsettings.json`

## Related

- [[rest_api_basics]]
- [[support_ticket_patterns]]
- [[howto_release_a_hotfix]]
- [[moc_development]]

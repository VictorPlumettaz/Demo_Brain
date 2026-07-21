---
title: Dependency Injection
tags: [knowledge, it, csharp, architecture]
created: 2026-06-23
updated: 2026-08-20
---

# Dependency Injection

Dependency injection means a class is handed the things it needs from outside, instead of
building them itself.

## Why it matters here

The legacy half of [[paneflow]] builds everything inside itself, and that is the single reason
it cannot be tested. The new services in the [[cutting_optimizer_rewrite_overview]] use
constructor injection throughout, so I have the comparison side by side.

## The problem

```csharp
public class PriceCalculator
{
    public decimal PriceFor(int orderId)
    {
        var repo = new SqlPriceRepository("Server=paneflow-db;Database=PaneFlow;...");
        return repo.GetRates(orderId).Sum(r => r.Amount);
    }
}
```

This class works. It is also untestable, and the reason is the word `new`. To check one line of
arithmetic I need a SQL Server, that exact database, and rates for order 4711 in it — and when
the test fails I cannot tell whether the maths is wrong or somebody changed a row.

## The fix

Say what you need in the constructor and let someone else supply it.

```csharp
public interface IPriceRepository { IReadOnlyList<Rate> GetRates(int orderId); }

public class PriceCalculator
{
    private readonly IPriceRepository _repo;

    public PriceCalculator(IPriceRepository repo) => _repo = repo;

    public decimal PriceFor(int orderId)
        => _repo.GetRates(orderId).Sum(r => r.Amount);
}
```

Nothing clever happened. The class stopped choosing and started asking. A test can now hand it
a fake returning two rates from memory, and it runs in a millisecond with no database in sight
— [[unit_testing]]. The constructor is also documentation: `PriceCalculator(IPriceRepository)`
says what this class touches, where the old version said nothing until you had read it all.

## Who does the handing over

In ASP.NET Core, a container. Register which class stands behind each interface, once:

```csharp
builder.Services.AddScoped<IPriceRepository, SqlPriceRepository>();
builder.Services.AddScoped<PriceCalculator>();
```

| Lifetime | One instance per | Use for |
|---|---|---|
| `AddTransient` | every request for it | small, cheap, stateless things |
| `AddScoped` | one HTTP request | repositories, anything holding a DbContext |
| `AddSingleton` | the whole application | config, caches, clients safe to share |

The rule I got wrong once: a singleton must not take a scoped service in its constructor, or it
holds on to something meant to live for one request. In Development the app now throws at
startup when I do it, which is nicer than the bug it used to be.

## Honest bit

I still do not fully understand why this needs an interface when there is exactly one real
implementation and never will be a second. [[dana_frames]] said: there are always two, the real
one and the test double, and the test double is the one you use every day. Satisfying answer,
still feels like ceremony some mornings. Also true: a constructor with nine parameters is not
good dependency injection, it is a class doing nine things with the injection making it visible.

## Related

- [[unit_testing]]
- [[cutting_optimizer_rewrite_overview]]
- [[moc_development]]

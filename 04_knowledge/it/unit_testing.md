---
title: Unit Testing
tags: [knowledge, it, testing, csharp]
created: 2026-06-09
updated: 2026-08-19
---

# Unit Testing

A unit test runs one small piece of code on its own, checks the result automatically, and
fails loudly when someone changes the behaviour.

## Why it matters here

The [[cutting_optimizer_rewrite_overview]] is the reason this page exists. The old optimizer
has no tests at all, so every change to it is a bet. The rewrite has 140, and twice already one
caught a rounding change I would have shipped — the sort of thing that becomes scrap glass at
[[glaswerk_nord_overview]] rather than a red build.

## Arrange, act, assert

Every test has the same three parts in the same order. Keeping them visually separate is half
the value.

```csharp
[Fact]
public void Pack_PlacesNothing_WhenLiteIsLargerThanSheet()
{
    // Arrange
    var sheet = new Sheet(widthMm: 3210, heightMm: 2250);
    var lite = new Lite(widthMm: 4000, heightMm: 2000);
    var packer = new PatternPacker();

    // Act
    var result = packer.Pack(sheet, new[] { lite });

    // Assert
    Assert.Empty(result.PlacedLites);
    Assert.Equal(0d, result.Yield);
}
```

We use xUnit. `[Fact]` is a test with no input; `[Theory]` with `[InlineData]` runs the same
test over several sets of values, which is how boundaries get covered without four copies:

```csharp
[Theory]
[InlineData(1000, 500, true)]
[InlineData(3210, 2250, true)]   // exactly the sheet
[InlineData(3211, 2250, false)]  // one millimetre too wide
public void Fits_ChecksBothDimensions(int widthMm, int heightMm, bool expected)
    => Assert.Equal(expected, new Sheet(3210, 2250).Fits(new Lite(widthMm, heightMm)));
```

Expected value first in `Assert.Equal`, always. The failure message reads "expected X, actual
Y", and it lies to you for ten minutes if the arguments are swapped.

## What is worth testing

| Worth it | Not worth it |
|---|---|
| Calculations — yield, offcuts, prices | properties that only get and set |
| Every branch of an `if` chain | the framework itself |
| Boundaries: 0, 1, exactly-fits, one over | a test that just repeats the code |
| A bug, before you fix it | anything needing a database or the network |

The bottom left is the habit worth having: when [[priya_tempered]] reports a bug, write the
test that reproduces it *first*. It fails, you fix it, it passes, and it stays there so the bug
cannot come back quietly.

A test that needs a database is an integration test. Different project, nightly build, 90
seconds — see [[dependency_injection]] for how the unit ones avoid needing one.

## The oracle trick

For the rewrite we do something [[dana_frames]] suggested: run the old engine and the new one
over the same 200 real orders and assert the yields match to within 0.1 %. Not a unit test in
any strict sense, but it is the only thing giving us confidence that 20 years of undocumented
behaviour survived the move. When they disagree we decide which is right, and the decision goes
into [[cutting_optimizer_rewrite_decisions]].

## Honest bit

I still write the tests after the code. Dana says that is acceptable as long as they exist and
I do not quietly write the test to match whatever the code happens to do. I have caught myself
doing exactly that twice.

## Related

- [[dependency_injection]]
- [[cutting_optimizer_rewrite_overview]]
- [[moc_development]]

# 07_private

**This folder is not in git.** See `.gitignore` — everything in here is excluded except
this README, which exists so the structure is visible to anyone cloning the repo.

## What lives here

- Payslips, the apprenticeship contract, certificates
- Credentials that have not made it into the password manager yet
- Anything about a colleague that is not mine to publish
- Medical and personal documents

## Why a folder and not just "be careful"

Because "be careful" fails silently. A single gitignored folder is one rule that is easy to
follow at 6pm on a Friday, and it fails closed: if you are unsure whether something is
sensitive, it goes here, and nothing is lost.

The AI can still read these files locally when asked — it just cannot push them anywhere.
That is the correct split: private from the network, not private from me.

## The rule

Sensitive data goes here **first**, not "for now". There is no step two where you move it
somewhere better.

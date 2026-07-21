# Memory Index

Behaviour rules only. **Facts never go in here** — facts go in the vault.

That split is the whole point: if a fact lives in the AI's memory instead of in a file, I
cannot find it, cannot check it, and cannot tell where it came from.

- [Label derivations](feedback_label_derivations.md) — when Claude works something out
  instead of reading it, it must say so
- [Ask before restructuring](feedback_ask_before_restructuring.md) — new folders or bulk
  moves get discussed first
- [Do not summarise, write it down](feedback_write_do_not_summarise.md) — a useful answer
  belongs in a file, not only in the chat

## How an entry gets in here

Something goes wrong twice → it becomes a rule here instead of a correction I repeat.
If the rule matters on *every* request, it belongs in `CLAUDE.md` instead — that file is
always loaded, these are only read when needed.

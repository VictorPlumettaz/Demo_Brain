---
title: Nils Putty
tags: [knowledge, people]
created: 2026-04-22
updated: 2026-08-13
---

# Nils Putty

IT and infrastructure at [[pane_relief_software|Pane Relief]]. Servers, network, VPN, accounts,
backups, build agents, laptops. One and a half people for all of it — him plus a contractor
two days a week.

## What he owns

- VPN and the customer access accounts, including ours into [[glaswerk_nord_overview|Glaswerk Nord]]
- The test environment and its nightly restore
- Active Directory, mail, licences
- Laptop setup for new starters → [[howto_set_up_dev_environment]]

## How to work with him

- **Anything security-shaped goes to him directly and gets answered in minutes.** A credential
  in a chat message, a customer mailing us a password, a login alert at 03:00: walk over. He
  has never once made me feel like I overreacted.
- **Everything else goes in a ticket** and takes two to five days. That is a queue, not an
  opinion about the request.
- Give him the exact error text, the machine name and the time. Half a ticket comes back as
  a question and costs another day.
- "The internet is broken" is not a report, and he will say so.
- Walking over works where writing does not. His door is open. His inbox is a landfill.

## What I learned from him

- The test database is restored from a production copy every night at 02:00. Anything I set
  up in it by hand is gone by morning. I found this out by losing two hours of test data and
  then finally asking why.
- Nothing customer-shaped leaves the network without asking first, and "it is only a
  screenshot" does not help — a plant layout is customer data too.
- The VPN certificate expires once a year, always on a Friday.

## Related

- [[moc_people]]
- [[howto_set_up_dev_environment]]
- [[coffee_machine_api_findings]] — he worked out the machine sits on the guest VLAN
- [[glaswerk_nord_tasks]]
- [[terminal_cheatsheet]]

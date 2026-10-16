---
name: implement
description: "Implement a single issue: one ticket, one agent-ready issue, or the work agreed in this conversation. A spec split into tickets goes to /implement-spec instead."
disable-model-invocation: true
---

Implement one issue: a ticket from `/to-tickets`, an issue `/triage` made agent-ready, or the work agreed in this conversation.

If the user passes an issue reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask.

A spec that has been split into tickets (it has child tickets, or `.scratch/<feature>/issues/` beside it on a local tracker) is not yours to build: stop and point the user to `/implement-spec` for the whole spec, or to `/implement` on one of its tickets.

Call the Skill tool with "tdd" where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Note `HEAD` before you start: it is the fixed point for the review.

Once done, commit your work to the current branch, then call the Skill tool with "review-changes", passing that starting commit as the fixed point. Commit any fixes the review leads to.

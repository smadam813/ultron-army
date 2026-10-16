---
name: implement
description: "Implement a single issue or ticket, or work described in the conversation. For a whole spec split into tickets, use /implement-spec."
disable-model-invocation: true
---

Implement the issue or ticket the user passes, or the work described in the conversation. If the user passes a whole spec that has been split into tickets, point them at `/implement-spec` instead.

If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask.

Call the Skill tool with "tdd" where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Note `HEAD` before you start: it is the fixed point for the review.

Once done, commit your work to the current branch, then call the Skill tool with "review-changes", passing that starting commit as the fixed point. Commit any fixes the review leads to.

---
name: implement
description: "Implement one or more issues or tickets, or work described in the conversation. To implement a spec, use /implement-spec."
disable-model-invocation: true
---

Implement the issues or tickets the user passes, or the work described in the conversation. If the user passes a spec, point them at `/implement-spec` instead.

If the user passes ticket references, fetch each from the issue tracker and state its title before starting. If the reference is ambiguous, ask.

Call the Skill tool with "tdd" where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Note `HEAD` before you start: it is the fixed point for the review.

Once done, commit your work to the current branch, then call the Skill tool with "review-changes", passing that starting commit as the fixed point. Commit any fixes the review leads to.

# builder-skills

Skills for building software well: engineering practices for Principal / Staff engineers.

```
/plugin marketplace add smadam813/ultron-army
/plugin install builder-skills@ultron-army
```

Not sure where to start? Run **[`/ask-builder`](skills/ask-builder/SKILL.md)**: it routes you to the right skill or flow. Before your first engineering flow in a repo, run **[`/setup-builder-skills`](skills/setup-builder-skills/SKILL.md)** once.

**User-invoked** skills are reachable only when you type them (`disable-model-invocation: true`). **Model-invoked** skills can also be reached for by the model on its own.

## Engineering

### User-invoked

- **[ask-builder](skills/ask-builder/SKILL.md)**: Ask which skill or flow fits your situation. A router over the skills in this plugin.
- **[grill-with-docs](skills/grill-with-docs/SKILL.md)**: Grilling session that also builds your project's domain model, sharpening terminology and updating `GLOSSARY.md` and ADRs inline.
- **[triage](skills/triage/SKILL.md)**: Move issues through a state machine of triage roles.
- **[improve-codebase-architecture](skills/improve-codebase-architecture/SKILL.md)**: Scan a codebase for deepening opportunities, present them as a self-contained visual HTML report, then grill through whichever one you pick.
- **[setup-builder-skills](skills/setup-builder-skills/SKILL.md)**: Configure this repo for the engineering skills (issue tracker, triage labels, domain doc layout). Run once per repo.
- **[to-spec](skills/to-spec/SKILL.md)**: Turn the current conversation into a spec and publish it to the issue tracker.
- **[to-tickets](skills/to-tickets/SKILL.md)**: Break any plan, spec, or conversation into a set of tracer-bullet tickets, each declaring its blocking edges, whether as text in a local file or as native blocking links on a real tracker.
- **[implement](skills/implement/SKILL.md)**: Build a single issue or ticket (or work described in the conversation), driving `/tdd` at pre-agreed seams, then committing and closing out with `/review-changes`.
- **[implement-spec](skills/implement-spec/SKILL.md)**: Implement a whole spec on one integration branch. Works the tickets as a task graph, running implementer subagents across the ready frontier for maximum concurrency, then closes out with `/review-changes`.
- **[wayfinder](skills/wayfinder/SKILL.md)**: Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on the issue tracker, resolved one at a time until the way to the destination is clear.
- **[retro](skills/retro/SKILL.md)**: Suggest improvements to the coding agent's environment (navigation, automated checks, coding standards, steering files, tooling) after a session, most severe first.

### Model-invoked

- **[prototype](skills/prototype/SKILL.md)**: Build a throwaway prototype to answer a design question: a single shareable HTML file for state/logic, or several toggleable UI variations.
- **[diagnosing-bugs](skills/diagnosing-bugs/SKILL.md)**: Disciplined diagnosis loop for hard bugs and performance regressions: build a feedback loop that goes red on this bug → minimise → hypothesise → instrument → fix → regression-test.
- **[research](skills/research/SKILL.md)**: Investigate a question against high-trust primary sources and capture the findings as a cited Markdown file in the repo, run as a background agent.
- **[tdd](skills/tdd/SKILL.md)**: Test-driven development with a red-green-refactor loop. Builds features or fixes bugs one vertical slice at a time.
- **[domain-modeling](skills/domain-modeling/SKILL.md)**: Actively build and sharpen a project's domain model by challenging terms, stress-testing with scenarios, and updating `GLOSSARY.md` and ADRs inline.
- **[codebase-design](skills/codebase-design/SKILL.md)**: Shared discipline and vocabulary for designing deep modules: small interfaces, clean seams, testable through the interface.
- **[review-changes](skills/review-changes/SKILL.md)**: Two-axis review of the diff since a fixed point: **Standards** (does it follow the repo's coding standards, plus a Fowler smell baseline?) and **Spec** (does it faithfully implement the originating issue/spec?), run as parallel sub-agents.
- **[receiving-code-review](skills/receiving-code-review/SKILL.md)**: Evaluate code review feedback with technical rigor before implementing it: verify, ask, push back where warranted.
- **[pr](skills/pr/SKILL.md)**: The shape a pull request body should take: a summary as the smallest visual that makes the change clear, before/after evidence that it works, and a merge-danger call (one-way or two-way door, plus blast radius).
- **[wizard](skills/wizard/SKILL.md)**: Generate an interactive bash wizard that walks a human through steps only they can perform: provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover.

## Productivity

### User-invoked

- **[grill-me](skills/grill-me/SKILL.md)**: Get relentlessly interviewed about a plan or design until every branch of the design tree is resolved.
- **[handoff](skills/handoff/SKILL.md)**: Compact the current conversation into a handoff document so another agent can continue the work.
- **[teach](skills/teach/SKILL.md)**: Teach the user a new skill or concept over multiple sessions, using the current directory as a stateful teaching workspace.
- **[to-questionnaire](skills/to-questionnaire/SKILL.md)**: Turn a decision you can't answer alone into a Markdown questionnaire for the one person who can (filled in async, or together over a meeting).
- **[wait-what](skills/wait-what/SKILL.md)**: Fire this the moment a message doesn't land. The agent re-pitches it with the context you're missing, in plain English, using your `GLOSSARY.md` vocabulary.

### Model-invoked

- **[grilling](skills/grilling/SKILL.md)**: Interview the user relentlessly about a plan, decision, or idea until every branch of the design tree is resolved.
- **[writing-for-agents](skills/writing-for-agents/SKILL.md)**: Writing documents for agents: skills, CLAUDE.md/AGENTS.md, and any doc an agent reaches by a pointer.

## Credits

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

# Smart zone

The **smart zone** is the part of a session's context window in which the model still reasons sharply. On state-of-the-art models it is roughly the first **~150k tokens**, regardless of how large the advertised window is.

Past it, the model doesn't fail loudly; it degrades quietly. It loses track of earlier decisions, re-asks settled questions, contradicts constraints it agreed to, and drifts toward plausible-but-wrong answers. The window still accepts tokens; the reasoning over them gets worse.

## Why it matters

- **It's the real budget.** Plan work against the smart zone, not the context limit. A phase that won't fit in what's left of the zone shouldn't start in this session.
- **Primary sources are expensive.** Keeping a whole grilling session verbatim (see [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md)) is worth it only while it fits inside the zone.
- **Degradation is gradual and hard to see from inside.** The model won't announce that it has left the zone. Watch token usage instead of waiting for symptoms.

## What to do near the edge

- Don't push on degraded. Stop at the **nearest phase boundary**, not mid-phase.
- Pick the cheapest move that frees room: `/clear` if the context is disposable, a subagent if the next task can run AFK, `/compact` (with an instruction about what to keep) otherwise. See [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md) for the order.
- Push bulky, self-contained work (searches, reviews, research) into subagents so their reading never lands in the main window.

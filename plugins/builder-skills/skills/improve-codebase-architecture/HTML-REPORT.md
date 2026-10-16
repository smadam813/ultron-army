# HTML Report Format

The architectural review is rendered as a single self-contained HTML file in the OS temp directory. Everything it needs is inline: one `<style>` block for layout and styling, and inline SVG plus hand-built divs for every diagram. No CDNs, no external scripts, fonts, or stylesheets: the file must render identically with the network off. SVG graphs handle graph-shaped diagrams; hand-built divs handle the more editorial visuals (mass diagrams, cross-sections). Mix the two: don't lean on one pattern for everything, it'll start to look generic.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Architecture review for {{repo name}}</title>
    <style>
      :root {
        --bg: #fafaf9; --ink: #0f172a; --muted: #64748b; --line: #e2e8f0; --card: #ffffff;
        --accent: #059669; --leak: #dc2626; --warn: #d97706; --deep: #0f172a;
      }
      * { box-sizing: border-box; }
      body { margin: 0; background: var(--bg); color: var(--ink);
             font: 16px/1.5 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
      main { max-width: 64rem; margin: 0 auto; padding: 3rem 1.5rem; display: grid; gap: 3rem; }
      h1, h2, h3 { font-family: Georgia, "Times New Roman", serif; line-height: 1.2; margin: 0 0 .5rem; }
      #candidates { display: grid; gap: 2.5rem; }
      .card { background: var(--card); border: 1px solid var(--line); border-radius: .5rem; padding: 1.5rem; }
      .badges { display: flex; flex-wrap: wrap; gap: .5rem; margin: .5rem 0 1rem; }
      .badge { font-size: .75rem; font-weight: 600; padding: .125rem .5rem; border-radius: 999px; border: 1px solid; }
      .badge.strong { color: #047857; background: #ecfdf5; border-color: #a7f3d0; }
      .badge.explore { color: #b45309; background: #fffbeb; border-color: #fde68a; }
      .badge.speculative { color: #475569; background: #f1f5f9; border-color: #cbd5e1; }
      .badge.tag { color: var(--muted); background: transparent; border-color: var(--line); }
      .files { font: .875rem/1.6 ui-monospace, SFMono-Regular, Consolas, monospace; padding: 0; list-style: none; }
      .before-after { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
      @media (max-width: 640px) { .before-after { grid-template-columns: 1fr; } }
      .diagram { border: 1px solid var(--line); border-radius: .5rem; padding: 1rem; min-height: 20rem; position: relative; }
      .diagram svg { width: 100%; height: auto; display: block; }
      .label { font-size: .75rem; text-transform: uppercase; letter-spacing: .08em; }
      .module { border: 1px solid #94a3b8; border-radius: .25rem; padding: .5rem; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); color: #f8fafc; border: 3px solid var(--deep); }
      .faded { opacity: .35; }
      .band { height: 3rem; border-left: 4px solid #94a3b8; display: flex; align-items: center; padding-left: .75rem; }
      .adr { background: #fffbeb; border: 1px solid #fde68a; border-radius: .375rem; padding: .5rem .75rem; }
      /* SVG strokes */
      .edge { stroke: #475569; stroke-width: 1.5; fill: none; }
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: var(--leak); stroke-width: 2; }
    </style>
  </head>
  <body>
    <main>
      <header>...</header>
      <section id="candidates">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

Extend the `<style>` block as needed, but keep every rule inline in the file.

## Header

Repo name, date, and a compact legend: solid box = module, dashed line = seam, red arrow = leakage, thick dark box = deep module. No introduction paragraph. Straight into the candidates.

## Candidate card

The diagrams carry the weight. Prose is sparse, plain, and uses the glossary terms (from the `/codebase-design` skill) without ceremony.

Each candidate is one `<article>`:

- **Title**: short, names the deepening (e.g. "Collapse the Order intake pipeline").
- **Badge row**: recommendation strength (`Strong` = `.badge.strong`, emerald; `Worth exploring` = `.badge.explore`, amber; `Speculative` = `.badge.speculative`, slate), plus a `.badge.tag` for the dependency category (`in-process`, `local-substitutable`, `ports & adapters`, `mock`).
- **Files**: monospaced `<ul class="files">`.
- **Before / After diagram**: the centrepiece. Two columns, side by side, in a `.before-after` grid of `.diagram` boxes. See patterns below.
- **Problem**: one sentence. What hurts.
- **Solution**: one sentence. What changes.
- **Wins**: bullets, ≤6 words each. e.g. "Tests hit one interface", "Pricing logic stops leaking", "Delete 4 shallow wrappers".
- **ADR callout** (if applicable): one line in an amber-tinted `.adr` box.

No paragraphs of explanation. If the diagram needs a paragraph to be understood, redraw the diagram.

## Diagram patterns

Pick the pattern that fits the candidate. Mix them. Don't make every diagram look the same. Variety is part of the point.

### Inline SVG graph (the workhorse for dependencies / call flow)

Use an inline `<svg>` when the point is "X calls Y calls Z, and look at the mess." Modules are `<rect>` + `<text>`, calls are `<line>` or `<path>` with a shared `<marker>` arrowhead. Put it inside a `.diagram` container so it doesn't feel parachuted in. Colour leakage edges with `.leak`, dash seams with `.seam`, and fill the deep module dark. Lay nodes out by hand on a simple grid: left-to-right for call flow, top-to-bottom for layers. For sequences ("before: 6 round-trips; after: 1"), draw vertical lifelines and horizontal message arrows. Define the `<marker>`s once per page, in the first diagram's `<defs>` as below; later diagrams reuse `url(#arrow)` and `url(#arrow-leak)` without redefining them, since element IDs must be unique in the document.

```html
<div class="diagram">
  <svg viewBox="0 0 560 140" role="img" aria-label="Order intake call flow">
    <defs>
      <marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
        <path d="M0,0 L10,5 L0,10 z" fill="#475569" />
      </marker>
      <marker id="arrow-leak" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
        <path d="M0,0 L10,5 L0,10 z" fill="#dc2626" />
      </marker>
    </defs>
    <g font-size="11" text-anchor="middle" font-family="system-ui, sans-serif">
      <rect x="10"  y="50" width="110" height="40" rx="4" fill="#fff" stroke="#94a3b8" />
      <text x="65"  y="74">OrderHandler</text>
      <rect x="150" y="50" width="110" height="40" rx="4" fill="#fff" stroke="#94a3b8" />
      <text x="205" y="74">OrderValidator</text>
      <rect x="290" y="50" width="110" height="40" rx="4" fill="#fff" stroke="#dc2626" />
      <text x="345" y="74">OrderRepo</text>
      <rect x="430" y="50" width="120" height="40" rx="4" fill="#fff" stroke="#dc2626" />
      <text x="490" y="74">PricingClient</text>
    </g>
    <line class="edge" x1="120" y1="70" x2="148" y2="70" marker-end="url(#arrow)" />
    <line class="edge" x1="260" y1="70" x2="288" y2="70" marker-end="url(#arrow)" />
    <line class="edge leak seam" x1="400" y1="70" x2="428" y2="70" marker-end="url(#arrow-leak)" />
    <text x="414" y="40" font-size="10" fill="#dc2626" text-anchor="middle">leak</text>
  </svg>
</div>
```

### Hand-built boxes-and-arrows (when a node graph is the wrong shape)

Modules as `<div class="module">`s with borders and labels. Arrows as inline SVG `<line>` or `<path>` elements positioned absolutely over a relative container. Reach for this when you want the "after" diagram to feel like one thick-bordered `.deep` module with `.faded` internals, which a plain node graph won't render with the right weight.

### Cross-section (good for layered shallowness)

Stack horizontal `.band` divs to show layers a call passes through. Before: 6 thin layers each doing nothing. After: 1 thick band labelled with the consolidated responsibility.

### Mass diagram (good for "interface as wide as implementation")

Two rectangles per module: one for interface surface area, one for implementation. Before: interface rectangle is nearly as tall as the implementation rectangle (shallow). After: interface rectangle is short, implementation rectangle is tall (deep).

### Call-graph collapse

Before: a tree of function calls rendered as nested boxes. After: the same tree collapsed into one box, with the now-internal calls shown faded inside it.

## Style guidance

- Lean editorial, not corporate-dashboard. Generous whitespace. Serif optional for headings (the scaffold's Georgia stack works well with the stone/slate palette).
- Colour sparingly: one accent (emerald or indigo) plus red for leakage and amber for warnings.
- Keep diagrams ~320px tall so before/after sits comfortably side by side without scrolling.
- Use the `.label` class (small, uppercase, letter-spaced) for module labels inside diagrams, so they read as schematic, not as UI.
- No scripts and no external resources: the report is a single static file that renders offline. Use system font stacks, never web fonts.

## Top recommendation section

One larger card. Candidate name, one sentence on why, anchor link to its card. That's it.

## Tone

Plain English, concise, but the architectural nouns and verbs come straight from the `/codebase-design` skill. Concision is not an excuse to drift.

**Use exactly:** module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

**Never substitute:** component, service, unit (for module) · API, signature (for interface) · boundary (for seam) · layer, wrapper (for module, when you mean module).

**Phrasings that fit the style:**

- "Order intake module is shallow: interface nearly matches the implementation."
- "Pricing leaks across the seam."
- "Deepen: one interface, one place to test."
- "Two adapters justify the seam: HTTP in prod, in-memory in tests."

**Wins bullets** name the gain in glossary terms: *"locality: bugs concentrate in one module"*, *"leverage: one interface, N call sites"*, *"interface shrinks; implementation absorbs the wrappers"*. Don't write *"easier to maintain"* or *"cleaner code"*, because those terms aren't in the glossary and don't earn their place.

No hedging, no throat-clearing, no "it's worth noting that…". If a sentence could be a bullet, make it a bullet. If a bullet could be cut, cut it. If a term isn't in the `/codebase-design` glossary, reach for one that is before inventing a new one.

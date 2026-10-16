# Third-Party Notices

## obra/superpowers

The following files are copied verbatim from [obra/superpowers](https://github.com/obra/superpowers)
at commit `bb92a77741419a4ab5f06e711a283343f1ada0c3`:

- `skills/receiving-code-review/SKILL.md` (from `skills/receiving-code-review/SKILL.md`)

They are distributed under the following license:

```
MIT License

Copyright (c) 2025 Jesse Vincent

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## mattpocock/skills

The following skills are copied, with modifications, from [mattpocock/skills](https://github.com/mattpocock/skills)
at commit `49dd158d1076134a641b33efb035946536778336` (`skills/engineering/*` and `skills/productivity/*`):

- Engineering: `ask-builder` (from `ask-matt`), `codebase-design`, `diagnosing-bugs`, `domain-modeling`,
  `grill-with-docs`, `implement`, `implement-spec`, `improve-codebase-architecture`, `pr`, `prototype`,
  `research`, `retro`, `review-changes` (from `code-review`), `setup-builder-skills`
  (from `setup-matt-pocock-skills`), `tdd`, `to-spec`, `to-tickets`, `triage`, `wayfinder`, `wizard`
- Productivity: `grill-me`, `grilling`, `handoff`, `teach`, `to-questionnaire`, `wait-what`, `writing-for-agents`

Modifications:

- Renamed `ask-matt` → `ask-builder`, `code-review` → `review-changes`, `setup-matt-pocock-skills` →
  `setup-builder-skills`, and updated every cross-reference to them.
- Replaced links to external sites with local content: the "smart zone" definition now lives in
  `skills/ask-builder/SMART-ZONE.md`; the `glab` CLI link was removed.
- `improve-codebase-architecture`'s HTML report no longer loads Tailwind or Mermaid from CDNs; it uses
  inline CSS and inline SVG and renders offline.
- Dropped the Codex-specific `agents/openai.yaml` files and the category READMEs (replaced by this plugin's `README.md`).
- Specs carry a `spec` label instead of the `ready-for-agent` triage label.

`skills/pr` also reproduces content from Dex Horthy's `show-me` skill (HumanLayer); see `skills/pr/CREDITS.md`.

They are distributed under the following license:

```
MIT License

Copyright (c) 2026 Matt Pocock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

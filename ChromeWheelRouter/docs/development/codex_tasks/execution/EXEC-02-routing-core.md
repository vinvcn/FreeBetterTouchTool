# EXEC-02 — Routing Core Completion

## Codex Cloud prompt

Read:

- `AGENTS.md`
- `ChromeWheelRouter/docs/specs/safety_invariants.md`
- `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/scenarios.json`
- `project_control/engineering_nodes.md`

Task:

Complete the pure Swift routing core. This node must remain pure logic. No AppKit, no CoreGraphics event tap, no UI.

Required model:

- Input:
  - frontmost app bundle id
  - horizontal delta
  - vertical delta
  - modifier state
  - router enabled flag
- Output:
  - `passThrough`
  - `zoomInAndSwallow`
  - `zoomOutAndSwallow`
  - `nextTabAndSwallow`
  - `previousTabAndSwallow`

Rules:

- Only Chrome bundle ids match:
  - `com.google.Chrome`
  - `com.google.Chrome.beta`
  - `com.google.Chrome.canary`
  - `com.google.Chrome.dev`
- Only horizontal scroll with Option-only modifier maps to zoom.
- Only horizontal scroll with Control-only modifier maps to tab switching.
- `Chrome + no modifier + horizontal scroll` must be `passThrough`.
- Command, Shift, and mixed modifier combinations must be `passThrough`.
- Non-Chrome must be `passThrough`.
- Disabled router must be `passThrough`.

Required tests:

- Every scenario in `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/scenarios.json` has a corresponding Swift test.
- Add explicit regression test named similar to:
  - `testChromeBareHorizontalScrollPassesThroughForLogiOptions`

Deliverables:

- Updated core code.
- Updated tests.
- `ChromeWheelRouter/docs/development/node_reports/EXEC-02.md`.
- Updated agent state.

Hard constraints:

- Do not add CGEventTap.
- Do not inject keyboard shortcuts.
- Do not add UI.
- Do not introduce networking or filesystem side effects in core.

Acceptance:

- `swift test` passes.
- `scripts/check_all.sh` passes.

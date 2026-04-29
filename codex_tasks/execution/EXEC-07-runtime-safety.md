# EXEC-07 — Runtime Safety Controls

## Codex Cloud prompt

Task:

Add runtime safety controls so the tool can be stopped and recovered cleanly.

Required behavior:

- Disable state fully pass-through.
- Quit disables event tap before exit.
- Handle tap disabled by timeout/user input by safely re-enabling only when app is Enabled.
- Add kill switch file:
  - `~/Library/Application Support/ChromeWheelRouter/disabled`
  - if present on startup, app starts disabled or exits safely according to design.
- Add safe logging outside hot path.
- Add minimal status info:
  - current mode
  - last decision
  - last error if any

Hard callback constraints:

- no disk IO inside callback
- no network IO inside callback
- no shell commands inside callback
- no sleep inside callback
- no blocking locks inside callback

Deliverables:

- Runtime safety implementation.
- Updated static safety checks if useful.
- Updated troubleshooting docs.
- `node_reports/EXEC-07.md`.
- Updated agent state.

Acceptance:

- Disable immediately stops effects.
- Quit leaves no running process.
- Kill switch prevents active behavior.
- Tests and static checks pass.

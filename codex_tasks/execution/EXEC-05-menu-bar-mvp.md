# EXEC-05 — Menu Bar MVP

## Codex Cloud prompt

Task:

Build the first menu bar app shell around the working router.

App name:

- `ChromeWheelRouter.app`

Required menu items:

- Status: Enabled / Disabled / Missing Permissions
- Toggle Enabled
- Toggle Dry Run
- Open Logs
- Quit

Required behavior:

- Disabled means no active routing; all events pass through.
- Dry Run means classify and log only; no swallow, no injection.
- Quit must cleanly stop event tap and exit.
- App must be a menu bar app, not a normal dock app if practical.

Out of scope for this node:

- Start at login.
- DMG packaging.
- Signing/notarization.

Hard constraints:

- Do not add new product features.
- Do not add generic user configurable shortcuts.
- Do not add telemetry/network.

Deliverables:

- App target.
- Minimal menu UI.
- Local run instructions.
- `node_reports/EXEC-05.md`.
- Updated agent state.

Acceptance:

- App builds.
- Menu appears.
- Enable/Disable works.
- Dry Run works.
- Quit exits process.

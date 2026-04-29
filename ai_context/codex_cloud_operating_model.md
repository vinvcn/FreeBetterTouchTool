# Codex Cloud Operating Model

## How Codex should work on this project

Codex Cloud should work in small PRs. Every task must preserve the safety invariants.

## Setup command

No custom setup should be required for the current scaffold.

## Validation commands

```bash
swift test
python3 agent_state_harness/scripts/state_harness.py validate
python3 mvp_user_flow_harness/scripts/run_mvp_user_flow_harness.py
```

## What Codex Cloud can safely do

- Edit Swift core logic.
- Add tests.
- Update docs.
- Add scripts.
- Add GitHub Actions workflows.
- Prepare macOS adapter code for local testing.

## What Codex Cloud cannot prove alone

- Real MX Master horizontal wheel behavior.
- Logi Options+ event ordering.
- macOS TCC permission dialogs.
- Actual menu bar interaction.
- DMG drag-and-drop user experience.
- Notarization with real Apple credentials.

These require local macOS verification.

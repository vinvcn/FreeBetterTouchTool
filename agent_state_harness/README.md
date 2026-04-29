# Agent State Harness

Purpose: keep Codex Cloud agents aligned across tasks and PRs.

Codex agents should read:

1. `AGENTS.md`
2. `ChromeWheelRouter/docs/specs/*.md`
3. `agent_state_harness/current_state.json`
4. the current issue / task prompt

Agents may update `current_state.json` only when the task meaningfully changes state. Any update must validate against `state_schema.json`.

## Files

```text
current_state.json       Machine-readable project state
state_schema.json        JSON schema for state
scripts/check_state.py   Lightweight validator
scripts/print_state.py   Human-readable state summary
templates/state_update.md Template for PR state updates
```

## Validate

```bash
python3 agent_state_harness/scripts/check_state.py
```

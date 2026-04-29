# EXEC-03 — macOS Event Tap CLI Spike

## Codex Cloud prompt

Read:

- `AGENTS.md`
- `ChromeWheelRouter/docs/specs/technical_design.md`
- `ChromeWheelRouter/docs/specs/safety_constraints.md`
- `project_control/go_no_go_policy.md`

Task:

Create a developer-only CLI target to validate the macOS scroll event tap path.

Target name:

- `ChromeWheelRouterCLI`

Modes:

- `--listen-only`: observe scroll events and print classification, never swallow, never inject shortcuts.
- `--dry-run`: classify matching events, say what would happen, never swallow, never inject shortcuts.
- `--active`: execute actual router behavior for matching events.

Required behavior:

- Event mask must include only `CGEventType.scrollWheel`.
- Non-matching events must return original event.
- Matching behavior in active mode may initially log only; actual keyboard injection is EXEC-04.
- CLI must not create LaunchAgent.
- CLI must not require sudo.

Required safety:

- No keyDown/keyUp event tap.
- No networking.
- No disk IO inside callback.
- No shell commands inside callback.
- No sleep inside callback.
- No blocking locks inside callback.

Deliverables:

- CLI target.
- Documentation for local testing.
- Updated static safety checks.
- `ChromeWheelRouter/docs/development/node_reports/EXEC-03.md`.
- Updated agent state.

Manual test instructions to include:

1. Build CLI.
2. Run `ChromeWheelRouterCLI --listen-only`.
3. Open Chrome.
4. Move horizontal wheel with and without Option.
5. Confirm logs classify correctly.
6. Confirm no behavior is changed in listen-only/dry-run.

Acceptance:

- `scripts/check_all.sh` passes.
- Owner can run CLI locally in dry-run without breaking Logi Options+ behavior.

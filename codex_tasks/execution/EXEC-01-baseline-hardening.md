# EXEC-01 — Baseline Hardening

## Codex Cloud prompt

Read these files first:

- `AGENTS.md`
- `ai_context/project_brief.md`
- `ai_context/safety_invariants.md`
- `project_control/engineering_nodes.md`
- `project_control/go_no_go_policy.md`

Task:

Harden the current scaffold into a reliable engineering baseline.

Do not implement CGEventTap yet. Do not build the menu bar app yet.

Required work:

1. Ensure `swift test` runs from repo root.
2. Ensure `scripts/check_static_safety.sh` exists and fails on forbidden patterns:
   - `CGEventType.keyDown`
   - `CGEventType.keyUp`
   - `URLSession`
   - `Network.framework`
   - `NWConnection`
   - `socket(`
   - `/Library/LaunchDaemons`
   - `/System`
   - `sudo`
3. Ensure `scripts/check_all.sh` runs:
   - Swift tests
   - static safety checks
   - agent state harness validation
   - MVP user flow harness validation
4. Add or update CI to run `scripts/check_all.sh` on PRs.
5. Add `node_reports/EXEC-01.md` using `templates/node_report.md`.
6. Update `agent_state_harness/current_state.json`:
   - current_node = `EXEC-01`
   - status = `ready_for_review`
   - next_action = `owner reviews baseline hardening PR`

Hard constraints:

- Do not add networking.
- Do not add telemetry.
- Do not add macOS event tap implementation.
- Do not modify product scope.

Acceptance:

- `scripts/check_all.sh` passes.
- CI runs the same checks.
- Safety constraints are stricter, not weaker.

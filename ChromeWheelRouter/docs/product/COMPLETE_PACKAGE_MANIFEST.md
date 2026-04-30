# Complete Package Manifest

This package merges the earlier ChromeWheelRouter project materials into one repository-ready directory.

## Included layers

| Layer | Purpose | Key locations |
|---|---|---|
| Project definition | Defines scope, constraints, execution model, acceptance target | `ChromeWheelRouter/docs/specs/`, `AGENTS.md`, `README.md` |
| Agent state harness | Tracks current decision, state transition rules, next action, definition of done | `agent_state_harness/` |
| MVP user flow harness | Captures functional user flows, P0/P1 priorities, and failure modes | `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/` |
| Engineering flow | Breaks execution, acceptance, and release into controlled nodes | `project_control/`, `ChromeWheelRouter/docs/development/codex_tasks/`, `gate_checklists/` |
| Autopilot control | Minimizes owner intervention while keeping gates and human acceptance | `codex_automation/`, `owner_control/`, `ChromeWheelRouter/docs/acceptance/` |
| CI / GitHub | Runs safety gates and PR workflow | `.github/` |
| Codex config | Codex-oriented execution metadata | `.codex/` |

## Execution sequence

1. `P0 Project Definition` — already complete.
2. `EXEC-01` to `EXEC-09` — Codex execution nodes.
3. `ACCEPT-01` to `ACCEPT-04` — owner/human acceptance.
4. `REL-01` to `REL-03` — release planning and automation.

## Owner checkpoint rule

You should not review low-level implementation details unless a gate fails.

Your required decisions are:

- Approve/reject each execution-node PR.
- Run local acceptance on your Mac for the RC DMG.
- Decide whether to proceed to release planning.

## Safety invariant

The tool must remain a Chrome-only router that swallows only Option-only horizontal scroll for page zoom and Control-only horizontal scroll for tab switching until you explicitly change the project scope.


## Merged addenda

The former root-level `*_addendum` directories have been merged into their canonical locations:

- `agent_state_harness/state_transition_rules.md`
- `ChromeWheelRouter/docs/specs/engineering_execution_model.md`
- `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/p0_p1_user_flows.md`

No root-level `*_addendum` directories should remain.

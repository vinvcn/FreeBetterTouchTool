# Autopilot Execution Model

## Control principle

The owner controls decisions, not implementation details.

The owner should not have to manually debug or code during the execution phase unless a gate fails and Codex cannot recover.

## Stage map

| Stage | Owner role | Codex role | Output |
|---|---|---|---|
| P0 Project Definition | Done | Read and obey | Scope baseline |
| EXEC-01..09 | Trigger nodes / approve gates | Implement, test, document | Working RC package |
| ACCEPT-01..04 | Install and use on real Mac | Prepare package and reports | Human-confirmed build |
| REL-* | Decide release strategy | Prepare publishing pipeline | Release plan |

## Human intervention levels

| Level | Meaning | Examples |
|---|---|---|
| H0 | No human action | Codex edits code, runs tests, updates node report |
| H1 | Owner trigger only | Start next Codex node, merge PR after checks |
| H2 | Owner decision | Gate override, scope clarification, signing strategy |
| H3 | Owner physical verification | Install DMG on Mac, test MX Master + Logi Options+ + Chrome |

Target: EXEC phase should be H0/H1 only. ACCEPT phase necessarily includes H3.

## Go/no-go rule

A node is GO only when:

- Required files are changed.
- Tests pass.
- Static safety checks pass.
- Node report exists under `ChromeWheelRouter/docs/development/node_reports/`.
- The next node is explicitly named.
- No scope expansion occurred.

A node is NO-GO when:

- It adds keyDown/keyUp listeners.
- It adds network/telemetry.
- It modifies Chrome or Logi Options+ config.
- It installs privileged helpers, daemons, drivers, or root services.
- It makes non-matching events anything other than pass-through.

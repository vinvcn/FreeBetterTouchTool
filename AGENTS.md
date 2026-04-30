# AGENTS.md

Project: `ChromeWheelRouter`.

This is a narrowly scoped macOS menu bar utility for Chrome-only horizontal scroll routing. It is not a general input automation platform and not a BetterTouchTool clone.

## Read Order

1. [Scope](ChromeWheelRouter/docs/specs/scope.md)
2. [Safety constraints](ChromeWheelRouter/docs/specs/safety_constraints.md)
3. [Hot-path rules](ChromeWheelRouter/docs/specs/hot_path_rules.md)
4. [Architecture](ChromeWheelRouter/docs/specs/architecture.md)
5. [Current state](agent_state_harness/current_state.json)
6. [Engineering nodes](project_control/engineering_nodes.md)
7. The current issue or task

## Task Modes

- Product or behavior changes: start with scope and safety constraints.
- Runtime/event-tap changes: read hot-path rules before editing code.
- Architecture changes: update the focused spec or ADR that owns the decision.
- Execution-node work: update project memory under `ChromeWheelRouter/docs/development/project_memory/` when the task creates new knowledge.

## Before PR

```bash
./scripts/check_all.sh
```

If Swift tooling is available, also run:

```bash
swift test
swift build -c release
```

## Non-Negotiable Safety Warning

Never weaken safety constraints. Never expand scope without a Project Definition change. Unmatched events must pass through unchanged, and only Chrome + Option-only + horizontal scroll or Chrome + Control-only + horizontal scroll may be swallowed.

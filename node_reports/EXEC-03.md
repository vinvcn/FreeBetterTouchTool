# EXEC-03 Node Report — macOS Event Tap CLI Spike

Date: 2026-04-29
Branch: codex/exec-03

## Scope
Implemented a CLI spike for safe `scrollWheel` event observation and classification:
- added `ChromeWheelRouterMac` target with a `CGEventTapService` using an event tap mask containing only `scrollWheel`
- added `ScrollEventAdapter` for translating `CGEvent` into pure core `ScrollEventModel`
- added `ChromeWheelRouterCLI` executable target with modes:
  - `--listen-only`
  - `--dry-run`
  - `--active`
- for EXEC-03, all modes return the original event (no swallowing)
- no keyboard event listening
- no keyboard injection

## Commands Run
1. `./scripts/check_all.sh`
2. `swift build -c release`

## Results
- `agent_state_harness` validation: PASS
- `mvp_user_flow_harness` validation: PASS
- static safety checks: PASS
- core routing shell test: SKIPPED (non-Darwin)
- `swift test` (via `check_all`): PASS
- `swift build -c release`: PASS

## Safety Confirmation
- Event tap mask includes only `scrollWheel`.
- No keyDown/keyUp event tap added.
- Callback does not perform disk IO, network IO, shell execution, sleep, or blocking locks.
- No menu bar UI introduced in this node.

## Manual Mac Verification Command (listen-only)
Run locally on a real Mac (with required privacy permissions):

```bash
swift run ChromeWheelRouterCLI --listen-only
```

Expected behavior for EXEC-03:
- CLI logs classification decisions.
- Original scroll events continue to pass through unchanged.

## Next Node
Next node: **EXEC-04**.

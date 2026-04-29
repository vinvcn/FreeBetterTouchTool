# EXEC-05 Node Report — Menu Bar MVP

Date: 2026-04-29
Branch: codex/exec-05

## Scope
Implemented a minimal macOS menu bar app target that reuses the existing event-tap/router pipeline:
- added `ChromeWheelRouterApp` executable target
- added menu bar UI entries:
  - Status
  - Enable / Disable
  - Dry Run
  - Open Logs
  - Quit
- app now starts disabled by default
- runtime starts event tap only when:
  - user has enabled router
  - Accessibility and Input Monitoring preflight checks pass
- menu `Quit` action explicitly stops the event tap before termination
- kept `ChromeWheelRouterCLI` target unchanged for debugging workflows

## Commands Run
1. `swift test`
2. `swift build -c release`
3. `./scripts/check_all.sh`

## Results
- `swift test`: PASS
- `swift build -c release`: PASS
- `./scripts/check_all.sh`: PASS

## Safety Confirmation
- no new event tap kinds were added; `scrollWheel` remains the only tap mask
- disable path stops event tap service, resulting in full pass-through
- quit path stops event tap service before process exit
- no keyDown/keyUp listeners were introduced
- no new permissions beyond Accessibility/Input Monitoring were introduced

## Notes
- Start at Login intentionally not included in EXEC-05 per node constraints.
- Installer/package work intentionally not included in EXEC-05 per node constraints.

## Next Node
Next node: **EXEC-06**.

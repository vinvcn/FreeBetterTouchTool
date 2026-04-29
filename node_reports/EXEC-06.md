# EXEC-06 Node Report — Permission UX and Fail-Closed

Date: 2026-04-29
Branch: codex/exec-06

## Scope
Implemented permission UX so missing permissions are visible and safe:
- added explicit permission status menu row (`Permissions: Granted` / `Permissions: Missing`)
- added menu actions:
  - Open Accessibility Settings
  - Open Input Monitoring Settings
- ensured runtime remains fail-closed when permissions are missing:
  - active event tap is not started
  - existing tap is stopped when permission state is missing
- updated troubleshooting guidance with direct permission recovery steps

## Commands Run
1. `swift test`
2. `swift build -c release`
3. `./scripts/check_all.sh`

## Results
- `swift test`: PASS
- `swift build -c release`: PASS
- `./scripts/check_all.sh`: PASS

## Safety Confirmation
- no TCC/privacy bypasses were implemented
- no additional permissions were requested
- no keyDown/keyUp listeners were introduced
- event tap creation remains contingent on permissions in app runtime
- missing permissions path is non-crashing and fail-closed

## Next Node
Next node: **EXEC-07**.

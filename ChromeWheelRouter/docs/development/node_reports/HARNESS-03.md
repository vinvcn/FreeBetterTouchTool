# HARNESS-03 - Architecture Boundary and Hot-Path Safety Sensors

## Scope

Issue #30 adds mechanical checks for Swift module boundaries and event-tap hot-path safety.

## Changes

- Tightened `scripts/check_swift_boundaries.sh` to enforce Core purity, App event-tap ownership boundaries, and CLI routing delegation.
- Added `scripts/check_hot_path_safety.sh` to reject slow or unsafe operations in `CGEventTapService`.
- Wired the hot-path check into the fast quality gate in `harness/quality_gates.yml`.
- Removed the default per-event `NSWorkspace.shared.frontmostApplication` lookup from `CGEventTapService`.
- Updated the CLI to provide cached frontmost-app state through workspace activation notifications.
- Documented the boundary model in `ChromeWheelRouter/docs/specs/architecture.md`.

## Validation

- `./scripts/check_swift_boundaries.sh`
- `./scripts/check_hot_path_safety.sh`


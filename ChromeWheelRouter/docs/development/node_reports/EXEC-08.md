# EXEC-08 Node Report — Dev Install / Uninstall

Date: 2026-04-29
Branch: codex/exec-08

## Scope
Implemented developer install/uninstall scripts for local owner testing with strict user-level paths and no privileged operations:
- added `scripts/install_dev.sh` with release build + install flow
- added `scripts/uninstall_dev.sh` with cleanup flow for installed artifacts
- both scripts support dry-run mode and are idempotent

## Install behavior
- installs only to user-controlled directories:
  - `~/Library/Application Support/ChromeWheelRouter/bin/ChromeWheelRouterApp`
  - `~/Applications/ChromeWheelRouter.command`
  - `~/Library/Logs/ChromeWheelRouter` (directory only)
- writes install metadata to:
  - `~/Library/Application Support/ChromeWheelRouter/install-meta.txt`

## Uninstall behavior
- attempts to stop running ChromeWheelRouter process (best effort)
- removes:
  - `~/Applications/ChromeWheelRouter.command`
  - `~/Library/Application Support/ChromeWheelRouter`
  - `~/Library/Logs/ChromeWheelRouter`
- operation is idempotent; missing paths are ignored

## Safety Constraints Confirmation
- no `sudo`
- no writes to `/System`
- no writes to `/Library/LaunchDaemons`
- no privileged helpers
- no Chrome or Logi Options+ config modifications

## Privacy Permission Note
Both scripts document that Accessibility/Input Monitoring permissions must be revoked manually in macOS System Settings.

## Commands Run
1. `bash -n scripts/install_dev.sh`
2. `bash -n scripts/uninstall_dev.sh`
3. `./scripts/install_dev.sh --dry-run --skip-build`
4. `./scripts/uninstall_dev.sh --dry-run`
5. `./scripts/check_all.sh`

## Results
- all commands: PASS

## Notes
- Hardware/input-device QA remains required on a real Mac.
- Next node is **EXEC-09**.

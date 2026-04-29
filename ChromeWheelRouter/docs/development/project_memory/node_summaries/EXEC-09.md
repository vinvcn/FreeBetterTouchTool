# EXEC-09 Summary

- Added `scripts/package_rc.sh` to generate RC artifacts in `dist/`.
- Packaging supports macOS DMG creation and emits a clear placeholder/report when run outside macOS.
- Added RC install and manual QA docs (`ChromeWheelRouter/docs/product/INSTALL.md`, `ChromeWheelRouter/docs/product/MANUAL_QA.md`) and created `ChromeWheelRouter/docs/development/node_reports/EXEC-09.md`.
- Signing support remains optional via `APPLE_CODESIGN_IDENTITY`; no mandatory credentials for dev RC.

- Recorded portability lesson in `ChromeWheelRouter/docs/development/project_memory/lessons_learned/2026-04-29-swiftpm-path-portability.md`.
- Added architectural decision ADR-001 for universal macOS RC artifacts in `ChromeWheelRouter/docs/development/project_memory/decisions/ADR-001-universal-macos-rc-artifacts.md`.

# EXEC-09 Node Report — RC Packaging

Date: 2026-04-29
Branch: codex/exec-09

## Scope
Implemented RC packaging automation on macOS CI so the owner can download an installable DMG artifact for local acceptance.

## Delivered
- Added `scripts/package_rc.sh` (macOS DMG build path + non-macOS local fallback).
- Added GitHub Actions workflow `.github/workflows/rc-packaging.yml`:
  - runs on `macos-latest`
  - runs `./scripts/package_rc.sh`
  - verifies required `dist/` artifact files exist
  - validates `dist/build_manifest.json` has `packaging_status: "created"`
  - uploads `dist/` using `actions/upload-artifact@v4`
- Removed committed `dist/*` artifacts from git tracking so placeholder DMGs are not committed.

## Expected downloadable artifact location
After the RC Packaging workflow completes in GitHub Actions:
1. Open the workflow run (`Actions` → `RC Packaging` → latest run).
2. Download artifact: `ChromeWheelRouter-v0.1.0-rc1-dist`.
3. Confirm artifact bundle includes:
   - `ChromeWheelRouter-v0.1.0-rc1.dmg`
   - `SHA256SUMS`
   - `build_manifest.json`
   - `test_report.txt`
   - `static_safety_report.txt`

## Hard constraints check
- No required Apple Developer signing credentials.
- Optional signing remains env-driven (`APPLE_CODESIGN_IDENTITY`).
- No installer auto-start behavior.
- No placeholder DMG committed to repository.

## Local commands run in this node
1. `./scripts/package_rc.sh`
2. `./scripts/check_all.sh`

## Notes
- A real, installable DMG is produced only on macOS runners.
- Do not proceed to acceptance until the `RC Packaging` workflow run artifact is available for download.

## Compatibility fix (post-owner install feedback)
- Observed owner error on install: "You can’t open the application ‘ChromeWheelRouter’ because this Mac does not support this application."
- Likely cause: single-architecture app binary from CI runner architecture.
- Fix: package script now builds both `arm64` and `x86_64` release binaries and combines them with `lipo` into a universal executable before DMG creation.
- Added manifest fields for `macos_deployment_target` and `binary_architectures` to aid artifact verification.
- CI fix: replaced hardcoded `.build/<triple>/release` binary paths with `swift build --show-bin-path` lookup per target triple to support SwiftPM output-path differences across Xcode toolchains.

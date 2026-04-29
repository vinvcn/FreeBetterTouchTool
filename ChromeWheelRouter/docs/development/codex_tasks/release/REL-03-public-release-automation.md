# REL-03 — Public Release Automation

## Purpose

Automate release artifacts after human acceptance.

## Required behavior

When pushing a tag like `v0.1.0`:

- build app
- run tests
- run static safety checks
- package DMG
- optionally sign/notarize
- generate SHA256SUMS
- upload GitHub Release artifacts
- publish release notes

## Release artifact list

- `ChromeWheelRouter-v0.1.0.dmg`
- `SHA256SUMS`
- `build_manifest.json`
- `test_report.txt`
- `static_safety_report.txt`
- `ChromeWheelRouter/docs/product/CHANGELOG.md`

## Rollback plan

Document how to:

- disable app
- quit app
- uninstall app
- downgrade to previous DMG
- revoke macOS permissions

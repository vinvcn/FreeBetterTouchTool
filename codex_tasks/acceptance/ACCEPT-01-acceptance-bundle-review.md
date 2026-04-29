# ACCEPT-01 — Acceptance Bundle Review

## Purpose

Before installing anything on the owner's Mac, verify that the RC package is complete and auditable.

## Codex / CI responsibility

Codex must produce or update:

- `dist/ChromeWheelRouter-v0.1.0-rc1.dmg`
- `dist/SHA256SUMS`
- `dist/build_manifest.json`
- `dist/test_report.txt`
- `dist/static_safety_report.txt`
- `Docs/INSTALL.md`
- `Docs/UNINSTALL.md`
- `Docs/SECURITY.md`
- `Docs/TROUBLESHOOTING.md`
- `Docs/MANUAL_QA.md`

## Owner review checklist

- [ ] DMG exists.
- [ ] SHA256 checksum exists.
- [ ] Build manifest identifies commit and version.
- [ ] Automated tests passed.
- [ ] Static safety checks passed.
- [ ] Docs explain permissions clearly.
- [ ] Docs explain uninstall clearly.
- [ ] Docs explain unsigned build limitations if not notarized.

## Go / No-Go

GO only if all checklist items are true.

If any item is missing, return to EXEC-09.

# EXEC-09 — RC Packaging

## Codex Cloud prompt

Task:

Create the Release Candidate package that the human owner can install and accept.

Required artifacts:

- `dist/ChromeWheelRouter-v0.1.0-rc1.dmg`
- `dist/SHA256SUMS`
- `dist/build_manifest.json`
- `dist/test_report.txt`
- `dist/static_safety_report.txt`

DMG requirements:

- Contains `ChromeWheelRouter.app`.
- Does not auto-start the app.
- Does not install launch daemons.
- Does not modify Chrome or Logi Options+.
- If signing credentials are unavailable, produce unsigned RC and document Gatekeeper limitations.

Build manifest must include:

- version
- git commit
- build timestamp
- swift version
- macOS runner info if available
- artifact checksums
- whether signed/notarized

Docs required:

- `ChromeWheelRouter/docs/product/INSTALL.md`
- `ChromeWheelRouter/docs/product/UNINSTALL.md`
- `SECURITY.md`
- `ChromeWheelRouter/docs/product/TROUBLESHOOTING.md`
- `ChromeWheelRouter/docs/product/MANUAL_QA.md`

Deliverables:

- Packaging scripts.
- CI artifact upload if using GitHub Actions.
- RC docs.
- `ChromeWheelRouter/docs/development/node_reports/EXEC-09.md`.
- Updated agent state to `ready_for_human_acceptance`.

Acceptance:

- Owner can download DMG.
- Owner has all docs needed to install, test, and uninstall.

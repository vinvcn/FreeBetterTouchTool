# EXEC-09 — RC Packaging

Read first:
- AGENTS.md
- node_reports/EXEC-08.md

Goal:
Produce a release candidate package that the owner can install locally for acceptance.

Tasks:
1. Add packaging script for DMG.
2. Produce release candidate artifacts under `dist/`:
   - ChromeWheelRouter-v0.1.0-rc1.dmg
   - SHA256SUMS
   - build_manifest.json
   - test_report.txt
   - static_safety_report.txt
3. Ensure docs exist:
   - INSTALL.md
   - UNINSTALL.md
   - SECURITY.md
   - TROUBLESHOOTING.md
   - MANUAL_QA.md
4. Add `node_reports/EXEC-09.md`.

Hard constraints:
- Do not require Apple Developer signing credentials for dev RC.
- If signing/notarization support is added, it must be optional and driven by secrets/env vars.
- Do not auto-start app from installer.

Definition of done:
- DMG exists or the report clearly states why packaging is unavailable in the environment.
- Owner can run local acceptance using docs.
- Next stage is ACCEPT-01.

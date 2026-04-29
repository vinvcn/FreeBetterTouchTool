# Acceptance Gate Checklist

## Before local install

- [ ] DMG exists.
- [ ] SHA256 exists.
- [ ] Build manifest exists.
- [ ] Test report exists.
- [ ] Safety report exists.
- [ ] Install docs exist.
- [ ] Uninstall docs exist.
- [ ] Security docs exist.

## Local install

- [ ] App installs.
- [ ] App launches.
- [ ] Menu bar visible.
- [ ] Permissions flow understandable.
- [ ] App can enable.
- [ ] App can disable.
- [ ] App can quit.

## Functional acceptance

- [ ] Chrome bare horizontal wheel follows Logi Options+ existing behavior.
- [ ] Chrome Option + horizontal wheel zooms.
- [ ] Non-Chrome is unaffected.
- [ ] Disable restores pass-through.
- [ ] Quit restores system behavior.
- [ ] Uninstall removes files.

## Human confirmation

- [ ] `templates/human_acceptance_report.md` filled.
- [ ] All P0 tests PASS.
- [ ] Owner explicitly confirms human acceptance.

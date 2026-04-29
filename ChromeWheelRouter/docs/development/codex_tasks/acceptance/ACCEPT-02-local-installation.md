# ACCEPT-02 — Local Installation Acceptance

## Purpose

The owner installs the RC package on the real Mac.

## Human steps

1. Download RC DMG from CI/GitHub Release artifact.
2. Verify checksum if practical:

```bash
shasum -a 256 ChromeWheelRouter-v0.1.0-rc1.dmg
```

3. Open DMG.
4. Drag `ChromeWheelRouter.app` to Applications or documented target.
5. Launch app.
6. Confirm menu bar icon appears.
7. Enable app.
8. Grant required macOS permissions if prompted.
9. Restart app if macOS requires it after permission grant.

## Pass criteria

- [ ] App installs.
- [ ] App launches.
- [ ] Menu bar icon appears.
- [ ] Missing permissions state is understandable.
- [ ] Permission flow is documented correctly.
- [ ] App does not crash.
- [ ] App does not affect non-Chrome apps during install.

## Fail handling

If install fails, create a defect issue and route to:

- EXEC-08 if install/uninstall issue.
- EXEC-06 if permission issue.
- EXEC-09 if DMG/package issue.

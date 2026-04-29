# Install (Release Candidate)

This repository provides a **dev RC** packaging flow for local acceptance.

## What you get

Running the packaging script creates artifacts under `dist/`:

- `ChromeWheelRouter-v0.1.0-rc1.dmg`
- `SHA256SUMS`
- `build_manifest.json`
- `test_report.txt`
- `static_safety_report.txt`

## Build RC artifacts

```bash
./scripts/package_rc.sh
```

## Install on macOS

1. Build artifacts on a Mac (required for a real DMG).
2. Open `dist/ChromeWheelRouter-v0.1.0-rc1.dmg`.
3. Drag `ChromeWheelRouter.app` into `Applications` or `~/Applications`.
4. Launch the app manually (installer does **not** auto-start the app).
5. Grant permissions in System Settings when prompted:
   - Privacy & Security → Accessibility
   - Privacy & Security → Input Monitoring

## Verify artifact integrity

```bash
cd dist
shasum -a 256 -c SHA256SUMS
```

## Notes

- Apple signing credentials are **not required** for this RC flow.
- Optional signing is supported via `APPLE_CODESIGN_IDENTITY` only when provided.

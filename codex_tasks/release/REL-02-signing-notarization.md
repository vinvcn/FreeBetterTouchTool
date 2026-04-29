# REL-02 — Signing and Notarization Plan

## Purpose

Prepare the project for clean macOS distribution.

## Important boundary

Do not put Apple Developer credentials into Codex Cloud tasks.

Signing/notarization should run in one of:

- your local Mac
- GitHub Actions with encrypted secrets

## Required plan

- Developer ID Application certificate
- App-specific password or notarytool credentials
- GitHub Actions secrets names
- fallback behavior when secrets are missing
- verification commands
- Gatekeeper test steps

## Deliverables

- `scripts/sign_app.sh`
- `scripts/notarize_dmg.sh`
- `Docs/SIGNING_AND_NOTARIZATION.md`
- CI workflow updates guarded by missing-secret fallback

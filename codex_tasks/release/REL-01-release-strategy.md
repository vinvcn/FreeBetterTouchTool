# REL-01 — Release Strategy

## Purpose

Define how the accepted RC becomes a public or personal release.

## Decisions to make

- Release audience:
  - personal-only
  - private GitHub release
  - public GitHub release
- Package format:
  - DMG only
  - DMG + PKG
- Signing:
  - unsigned dev build
  - Developer ID signed build
- Notarization:
  - not notarized
  - notarized and stapled
- Support level:
  - no support, personal use
  - issue tracker support
  - documented rollback path

## Recommended v0.1.0 release policy

- DMG first.
- PKG only if there is a real need.
- Personal/private release can be unsigned.
- Public release should be Developer ID signed and notarized.

## Codex task

After human acceptance, ask Codex to draft:

- `RELEASE_PLAN.md`
- `CHANGELOG.md`
- `Docs/RELEASE_CHECKLIST.md`
- GitHub Release notes template

# ADR-003: Tag-Based Dist Release Workflow

Date: 2026-04-29

## Status

Accepted

## Context

The project already has CI and RC packaging, but release automation needs to build distributable artifacts for pull requests and publish GitHub Release assets for version tags.

## Decision

Add `.github/workflows/release-dist.yml` with:

- `pull_request`, `push` tags matching `v*`, and `workflow_dispatch` triggers.
- Build job permissions limited to `contents: read`.
- Release job permissions set to `contents: write` only when running from a tag.
- Existing `scripts/package_rc.sh` reused as the dist build path.
- Workflow artifacts uploaded for pull requests without creating releases.
- GitHub Releases created or updated with `gh release upload --clobber` for tag reruns.

## Consequences

Pull requests produce downloadable `dist` assets for review, while tag pushes can update release assets in place if a version tag is moved and the workflow reruns.

# ADR-002 - Feature Documentation Layout

Date: 2026-04-29

## Decision

Feature-specific ChromeWheelRouter documentation lives under `ChromeWheelRouter/docs/`.

The top-level buckets are:

- `product/` for user-facing product, install, uninstall, troubleshooting, release, and manual QA docs.
- `specs/` for feature scope, architecture, safety invariants, and technical design.
- `qa/` for user-flow and manual QA harness material.
- `acceptance/` for owner acceptance reports, runbooks, and local context capture.
- `development/` for execution prompts, node reports, project memory, lessons learned, and ADRs related to ChromeWheelRouter feature work.

Project-level policy, constraints, owner controls, automation, gates, templates, and repo-level security docs remain at the repository root.

## Rationale

This keeps feature development artifacts close to the feature they describe, while preserving root-level visibility for project-wide policies and controls.

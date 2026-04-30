# ChromeWheelRouter Docs

Feature-specific documentation for ChromeWheelRouter lives here.

## Layout

- `product/` - user-facing product docs, release notes, install/uninstall, troubleshooting, and manual QA instructions.
- `specs/` - feature scope, architecture, hot-path rules, safety invariants, product decisions, and technical design.
- `qa/` - user-flow scenarios and manual QA harness material.
- `acceptance` - owner acceptance runbooks, reports, and local acceptance context capture.
- `development/` - execution prompts, node reports, project memory, lessons learned, and ADRs tied to ChromeWheelRouter feature work.

Project-level policy, repository control, automation, templates, and owner-control material remain at the repository root.

## Repository Organization Invariant

No root-level `*_addendum` directories should be introduced. Supplemental materials belong in their canonical directories, for example:

- `agent_state_harness/`
- `ChromeWheelRouter/docs/specs/`
- `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/`

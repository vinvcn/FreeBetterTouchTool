# HARNESS-04 Node Report

## Goal

Add an approved-scenarios fixture layer for pure router decisions.

## Changes

- Added `ChromeWheelRouter/docs/qa/router_decision_fixtures/scenarios.json`.
- Added documentation for reviewing and extending router decision fixtures.
- Added `scripts/check_router_fixtures.sh` and a Swift fixture runner wired to
  `Router.decide`.
- Added the fixture check to the fast quality gate used by `check_all.sh`.

## Safety Scope

The fixtures encode the HARNESS-00 scope decision:

- Chrome + Option-only + horizontal scroll may zoom and swallow.
- Chrome + Control-only + horizontal scroll may switch tabs and swallow.
- Non-Chrome, bare horizontal scroll, mixed modifiers, disabled state,
  vertical-only scroll, and diagonal scroll pass through.

No runtime event tap behavior was changed.

## Validation

Run:

```bash
./scripts/check_router_fixtures.sh
./scripts/check_all.sh
```

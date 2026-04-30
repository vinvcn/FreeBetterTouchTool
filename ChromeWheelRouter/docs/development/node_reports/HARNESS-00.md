# HARNESS-00 Node Report - Reconcile Project Source of Truth

Date: 2026-04-30

## Scope Decision

Kept the accepted two-gesture MVP:

- Chrome + Option-only + horizontal scroll maps to page zoom and may swallow the original scroll event.
- Chrome + Control-only + horizontal scroll maps to tab switching and may swallow the original scroll event.
- Chrome bare horizontal scroll, mixed modifiers, vertical scroll, non-Chrome apps, and disabled mode pass through.

This matches `AGENTS.md`, `README.md`, the current router tests, implementation, and ADR-002. It resolves the stale `current_state.json` claim that only Option-only horizontal scroll may be swallowed.

## Changes

- Updated `agent_state_harness/current_state.json` and its validator safety invariant.
- Updated stale source-of-truth docs in specs, product manifest, engineering nodes, and execution task prompts.
- Added project memory for the source-of-truth drift.

## Safety Confirmation

- No new event types were added.
- The event tap mask remains scrollWheel-only.
- No keyboard event listeners, network APIs, telemetry, sudo, LaunchDaemons, privileged helpers, or system extensions were added.
- Chrome bare horizontal scroll remains pass-through.

## Validation

Run in this task:

- `./scripts/check_all.sh`

Result:

- `agent_state_harness`: PASS
- `mvp_user_flow_harness`: PASS
- `scripts/check_static_safety.sh`: PASS
- `scripts/run_core_routing_tests.sh`: PASS
- `swift test`: BLOCKED on this machine because the selected developer directory is `/Library/Developer/CommandLineTools`, `xcrun --find xctest` cannot find `xctest`, and Swift test compilation fails with `no such module 'XCTest'`.

The first sandboxed run also failed before Swift compilation because Swift could not write `/Users/vinvancan/.cache/clang/ModuleCache`; rerunning outside the sandbox cleared that permission issue and exposed the local XCTest/toolchain blocker.

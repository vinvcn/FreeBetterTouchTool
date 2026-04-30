# ADR-004 - Event tap hot path performance guardrails

## Status

Accepted

## Context

User testing observed visible pointer latency while ChromeWheelRouter was enabled, especially when moving the pointer between displays. Review found that the app recreated the global scroll event tap from periodic status polling and logged every scroll event from inside the event tap callback.

Even though the app subscribes only to `scrollWheel`, blocking or repeatedly disturbing global event tap plumbing can create broader input-system pressure.

## Decision

ChromeWheelRouter treats event tap performance regressions as safety regressions.

The event tap callback must not perform per-event logging, disk IO, stdout/stderr IO, shell commands, sleeps, blocking waits, or avoidable workspace/process lookups. Runtime polling must be idempotent and must not recreate, restart, or re-enable event taps unless the desired running state or mode changed.

Frontmost-app state should be cached outside the callback when practical and passed into the event adapter as cheap state.

## Consequences

- Diagnostic logging from the scroll path must be sampled, aggregated, or moved outside the callback.
- Static safety checks should reject hot-path logging or file/stdout IO in `CGEventTapService`.
- Manual QA for releases should include long-running enabled state, scroll bursts, and multi-display pointer movement.
- Future permission/status polling changes must prove they do not churn event taps in steady state.

# Source-of-Truth Drift in Routing Scope

Date: 2026-04-30

## Lesson

When routing scope changes, update the state harness and execution prompts in the same PR as implementation and tests. Otherwise future agents can receive conflicting instructions from stale project-control files.

## Applied Fix

HARNESS-00 aligned the current state, validator, specs, engineering nodes, and execution prompts to the accepted two-gesture MVP:

- Chrome + Option-only horizontal scroll => page zoom
- Chrome + Control-only horizontal scroll => tab switching
- all unmatched events => pass-through

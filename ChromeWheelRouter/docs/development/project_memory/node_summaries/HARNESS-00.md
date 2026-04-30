# HARNESS-00 Summary

Reconciled project source of truth around MVP routing scope. The project now consistently documents the accepted two-gesture MVP: Chrome + Option-only horizontal scroll zooms, Chrome + Control-only horizontal scroll switches tabs, and all unmatched events pass through.

The outdated Option-only state invariant in `agent_state_harness/current_state.json` and its validator was updated to match `AGENTS.md`, router tests, implementation, and ADR-002.

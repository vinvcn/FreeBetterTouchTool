# HARNESS-04 Summary

Added router decision fixtures as a reviewable behavior matrix under
`ChromeWheelRouter/docs/qa/router_decision_fixtures/scenarios.json`.

The fixture check compiles the pure Swift router with
`scripts/check_router_fixtures.swift` and asserts each scenario against
`Router.decide`. The fast quality gate now runs `./scripts/check_router_fixtures.sh`,
so `./scripts/check_all.sh` covers the approved scenario matrix before SwiftPM
tests run.

The fixture layer documents how agents can add scenarios without changing
generated assertion code, and keeps HARNESS-00 routing scope visible in diffs.

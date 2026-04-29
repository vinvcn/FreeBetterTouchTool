# EXEC-01 Node Report — Baseline Hardening

Date: 2026-04-29
Branch: codex/exec-01

## Scope
Hardened repository baseline checks without expanding product scope:
- strengthened static safety checks for forbidden patterns
- wired `swift test` into `check_all` when Swift sources/tests are present
- kept state harness and MVP flow harness in `check_all`
- no CGEventTap implementation
- no app UI work

## Commands Run
1. `./scripts/check_all.sh`
   - First run failed due to over-broad safety regex matching test strings.
2. `./scripts/check_all.sh`
   - Final run passed in cloud environment.

## Results
- `agent_state_harness` validation: PASS
- `mvp_user_flow_harness` validation: PASS
- static safety checks: PASS
- core routing shell test: SKIPPED (non-Darwin)
- `swift test`: PASS (10 tests)

## Risks / Notes
- Static safety checks are regex-based and may require periodic tuning to reduce false positives/negatives.
- macOS-specific runtime validation remains out of scope for cloud environment and must be done on a real Mac in later acceptance nodes.

## Next Node
Next node: **EXEC-02**.

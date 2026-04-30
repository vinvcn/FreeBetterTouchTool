# HARNESS-02 Node Report - Machine-Readable Quality Gates

Date: 2026-04-30

## Scope

Added a single machine-readable quality gate manifest and a repository-local runner for fast, integration, release, and manual gates.

## Changes

- Added `harness/quality_gates.yml`.
- Added `scripts/run_gate.py`.
- Updated `scripts/check_all.sh` to delegate its reusable check set to the fast gate while preserving conditional `swift test` behavior.
- Updated CI workflows to run the integration gate.
- Documented when to run each gate in `README.md`.

## Safety Confirmation

- No app runtime code changed.
- No event tap behavior changed.
- No network APIs, telemetry, privileged helpers, launch daemons, system extensions, or root requirements were added.

## Validation

Run in this task:

- `env PYTHONPYCACHEPREFIX=/private/tmp/cwr_pycache python3 -m py_compile scripts/run_gate.py scripts/check_harness_consistency.py`
- `./scripts/check_swift_boundaries.sh`
- `python3 -S ./scripts/check_harness_consistency.py`
- `python3 scripts/run_gate.py fast`
- `python3 scripts/run_gate.py integration`
- `python3 scripts/run_gate.py missing_gate`
- `./scripts/check_all.sh`

Result:

- Python compile check: PASS with cache redirected to `/private/tmp/cwr_pycache`.
- `./scripts/check_swift_boundaries.sh`: PASS.
- `python3 -S ./scripts/check_harness_consistency.py`: PASS.
- `python3 scripts/run_gate.py fast`: PASS when rerun outside the sandbox.
- `python3 scripts/run_gate.py integration`: updated fast gate PASS outside the sandbox, then BLOCKED at `swift test` for the same local `XCTest` toolchain issue.
- `python3 scripts/run_gate.py missing_gate`: PASS for failure behavior; exits 2 and lists available gates.
- First sandboxed gate/check runs hit Swift module cache permission denial under `/Users/vinvancan/.cache/clang/ModuleCache`.
- `./scripts/check_all.sh`: updated fast gate PASS outside the sandbox, then BLOCKED at `swift test` because this machine's selected Command Line Tools environment cannot import `XCTest` (`no such module 'XCTest'`).

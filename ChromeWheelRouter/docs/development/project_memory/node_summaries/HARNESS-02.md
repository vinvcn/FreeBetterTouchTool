# HARNESS-02 - Machine-Readable Quality Gates

Date: 2026-04-30

Added `harness/quality_gates.yml` as the single quality gate manifest and `scripts/run_gate.py` as its runner. `check_all.sh` now delegates shared harness/static/core checks to the fast gate, while CI workflows run the integration gate before merge. Follow-up review fixes made the manual gate runnable as a listing command and kept fast-gate consistency checks from preflighting integration/release-only tools.

#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 -S agent_state_harness/scripts/check_state.py
python3 -S mvp_user_flow_harness/scripts/check_user_flows.py
./scripts/check_static_safety.sh

if [ "$(uname -s)" = "Darwin" ]; then
  ./scripts/run_core_routing_tests.sh
else
  echo "core routing tests skipped: non-Darwin environment"
fi

if [ "${CWR_RUN_XCTEST:-0}" = "1" ]; then
  if [ "$(uname -s)" != "Darwin" ]; then
    echo "swift test skipped: XCTest gate is intended for macOS CI"
  elif ! command -v swift >/dev/null 2>&1; then
    echo "swift test skipped: swift not found"
  else
    swift test
  fi
else
  echo "swift test skipped: set CWR_RUN_XCTEST=1 to run SwiftPM/XCTest tests"
fi

echo "all checks: OK"

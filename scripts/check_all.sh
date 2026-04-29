#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 -S agent_state_harness/scripts/check_state.py
python3 -S ChromeWheelRouter/docs/qa/mvp_user_flow_harness/scripts/check_user_flows.py
./scripts/check_static_safety.sh

if [ "$(uname -s)" = "Darwin" ]; then
  ./scripts/run_core_routing_tests.sh
else
  echo "core routing tests skipped: non-Darwin environment"
fi

run_xtest="${CWR_RUN_XCTEST:-0}"
has_swift_package=0
if [ -f "Package.swift" ]; then
  has_swift_package=1
elif rg -l --glob '*.swift' . Sources Tests >/dev/null 2>&1; then
  has_swift_package=1
fi

if [ "$run_xtest" = "1" ] || [ "$has_swift_package" = "1" ]; then
  if ! command -v swift >/dev/null 2>&1; then
    echo "swift test skipped: swift not found"
  else
    swift test
  fi
else
  echo "swift test skipped: no Swift package detected (set CWR_RUN_XCTEST=1 to force)"
fi

echo "all checks: OK"

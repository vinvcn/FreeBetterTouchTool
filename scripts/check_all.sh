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

if rg --files Sources Tests >/dev/null 2>&1; then
  if ! command -v swift >/dev/null 2>&1; then
    echo "swift test skipped: swift not found"
  else
    swift test
  fi
else
  echo "swift test skipped: no Swift source/test files detected"
fi

echo "all checks: OK"

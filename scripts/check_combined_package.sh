#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

./scripts/check_all.sh

for path in   AGENTS.md   ChromeWheelRouter/docs/specs/project_brief.md   ChromeWheelRouter/docs/specs/engineering_execution_model.md   agent_state_harness/state_transition_rules.md   ChromeWheelRouter/docs/qa/mvp_user_flow_harness/p0_p1_user_flows.md   project_control/engineering_nodes.md   codex_automation/CODEX_ORCHESTRATION.md   owner_control/OWNER_QUICKSTART.md   ChromeWheelRouter/docs/acceptance/LOCAL_ACCEPTANCE_RUNBOOK.md; do
  if [ ! -e "$path" ]; then
    echo "missing required file: $path" >&2
    exit 1
  fi
done

if find . -maxdepth 1 -type d -name '*_addendum' | grep -q .; then
  echo "unexpected *_addendum directory remains at repo root" >&2
  find . -maxdepth 1 -type d -name '*_addendum' >&2
  exit 1
fi

if grep -RInE "agent_state_harness_addendum|ai_context_addendum|mvp_user_flow_harness_addendum" .   --exclude-dir=.git   --exclude-dir=.build   --exclude='*.zip'   --exclude='check_combined_package.sh' >/tmp/chromewheelrouter_addendum_refs.txt 2>/dev/null; then
  cat /tmp/chromewheelrouter_addendum_refs.txt >&2
  echo "unexpected stale addendum directory reference remains" >&2
  exit 1
fi

echo "combined package checks: OK"

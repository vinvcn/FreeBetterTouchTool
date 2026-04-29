#!/usr/bin/env bash
set -euo pipefail

QUEUE="codex_automation/execution_queue.yml"
STATE=".autopilot_state"

if [[ ! -f "$STATE" ]]; then
  echo "EXEC-01" > "$STATE"
fi

NODE_ID="$(cat "$STATE" | tr -d '[:space:]')"
./scripts/submit_codex_node.sh "$NODE_ID"

cat <<EOF2

Submitted: $NODE_ID

After Codex finishes and the PR is merged, advance state manually:
  ./scripts/mark_node_done.sh $NODE_ID

This script intentionally does not auto-advance. Dependency gates matter.
EOF2

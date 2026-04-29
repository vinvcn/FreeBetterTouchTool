#!/usr/bin/env bash
set -euo pipefail
NODE_ID="${1:-}"
if [[ -z "$NODE_ID" ]]; then
  echo "Usage: $0 EXEC-01" >&2
  exit 2
fi
REPORT="node_reports/${NODE_ID}.md"
if [[ ! -f "$REPORT" ]]; then
  echo "Missing node report: $REPORT" >&2
  exit 1
fi

if [[ -x ./scripts/check_all.sh ]]; then
  ./scripts/check_all.sh
else
  echo "WARN: ./scripts/check_all.sh not found or not executable"
fi

if ! grep -qi "next node" "$REPORT"; then
  echo "Node report should state next node." >&2
  exit 1
fi

echo "Gate passed for $NODE_ID"

#!/usr/bin/env bash
set -euo pipefail
NODE_ID="${1:-}"
if [[ -z "$NODE_ID" ]]; then
  echo "Usage: $0 EXEC-01" >&2
  exit 2
fi
case "$NODE_ID" in
  EXEC-01) NEXT=EXEC-02 ;;
  EXEC-02) NEXT=EXEC-03 ;;
  EXEC-03) NEXT=EXEC-04 ;;
  EXEC-04) NEXT=EXEC-05 ;;
  EXEC-05) NEXT=EXEC-06 ;;
  EXEC-06) NEXT=EXEC-07 ;;
  EXEC-07) NEXT=EXEC-08 ;;
  EXEC-08) NEXT=EXEC-09 ;;
  EXEC-09) NEXT=ACCEPT-01 ;;
  *) echo "Unknown or terminal node: $NODE_ID" >&2; exit 2 ;;
esac

echo "$NEXT" > .autopilot_state
echo "Next node: $NEXT"

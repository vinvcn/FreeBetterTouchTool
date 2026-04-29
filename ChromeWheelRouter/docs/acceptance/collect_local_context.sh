#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${SCRIPT_DIR}/local_context_$(date +%Y%m%d_%H%M%S).txt"
{
  echo "ChromeWheelRouter local context"
  echo "Date: $(date)"
  echo "macOS: $(sw_vers 2>/dev/null || true)"
  echo "Hardware: $(system_profiler SPHardwareDataType 2>/dev/null | sed -n '1,20p' || true)"
  echo "Chrome app:"
  mdls -name kMDItemVersion /Applications/Google\ Chrome.app 2>/dev/null || true
  echo "Running ChromeWheelRouter processes:"
  pgrep -af ChromeWheelRouter || true
} > "$OUT"
echo "Wrote $OUT"

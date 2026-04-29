#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

SCAN_PATHS=(Sources Tests scripts)

# These patterns are forbidden in implementation and install/build scripts.
# Documentation may mention them as safety constraints.
for pattern in \
  "CGEventType.keyDown" \
  "CGEventType.keyUp" \
  "URLSession" \
  "NWConnection" \
  "import Network" \
  "\/Library\/LaunchDaemons" \
  "\/Library\/PrivilegedHelperTools" \
  "sudo "; do
  if grep -R --line-number --exclude='check_static_safety.sh' "$pattern" "${SCAN_PATHS[@]}" >/tmp/chromewheelrouter_grep.txt 2>/dev/null; then
    cat /tmp/chromewheelrouter_grep.txt >&2
    fail "forbidden pattern found in implementation/scripts: $pattern"
  fi
done

echo "static safety checks: OK"

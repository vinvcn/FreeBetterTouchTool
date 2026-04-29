#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

SCAN_PATHS=(Sources Tests scripts)
EXCLUDE_GLOBS=(
  "!scripts/check_static_safety.sh"
)

scan_forbidden() {
  local pattern="$1"
  local description="$2"
  local out

  if out=$(rg --line-number --hidden --glob "${EXCLUDE_GLOBS[0]}" -- "$pattern" "${SCAN_PATHS[@]}" 2>/dev/null); then
    if [[ -n "$out" ]]; then
      echo "$out" >&2
      fail "forbidden pattern found (${description}): ${pattern}"
    fi
  fi
}

# 1) keyDown / keyUp event taps
scan_forbidden 'CGEventType\\.keyDown|\\.keyDown\\b|kCGEventKeyDown' 'keyboard keyDown event tap usage'
scan_forbidden 'CGEventType\\.keyUp|\\.keyUp\\b|kCGEventKeyUp' 'keyboard keyUp event tap usage'

# 2) network APIs / telemetry
scan_forbidden 'URLSession|NSURLSession|NWConnection|NWPathMonitor|import[[:space:]]+Network|CFNetwork|Alamofire|Telemetry|analytics|Mixpanel|Segment|Sentry|Datadog' 'network/telemetry API usage'

# 3) privileged/system installation patterns
scan_forbidden '\\bsudo\\b|LaunchDaemon|/Library/LaunchDaemons|/Library/PrivilegedHelperTools|SMJobBless|AuthorizationExecuteWithPrivileges|kernel extension|kext|system extension|OSSystemExtensionRequest' 'privileged install/system extension usage'

# 4) Chrome / Logi Options+ config touching
scan_forbidden 'defaults[[:space:]]+write[[:space:]].*(com\\.google\\.Chrome|Logi)|PlistBuddy.*(Chrome|Logi)|/Google/Chrome/.*/(Preferences|Local State)|Logi Options\\+/.+\\.(json|plist)|sqlite3.*(Chrome|Logi)' 'Chrome/Logi config modification or access'

echo "static safety checks: OK"

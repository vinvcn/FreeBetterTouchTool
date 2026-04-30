#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

event_tap="Sources/ChromeWheelRouterMac/CGEventTapService.swift"

if [ ! -f "$event_tap" ]; then
  echo "missing event tap service source: $event_tap" >&2
  exit 1
fi

fail_if_found() {
  local pattern="$1"
  local description="$2"

  if search_file "$pattern"; then
    echo "hot-path safety violation: $description" >&2
    exit 1
  fi
}

search_file() {
  local pattern="$1"

  if command -v rg >/dev/null 2>&1; then
    rg -n -- "$pattern" "$event_tap"
  else
    grep -nE -- "$pattern" "$event_tap"
  fi
}

fail_if_found 'NSWorkspace\.shared\.frontmostApplication' "event tap service must receive cached frontmost app state, not query NSWorkspace per event"
fail_if_found '(^|[^[:alnum:]_])(FileManager|FileHandle|Data\(contentsOf:|write\(to:|OutputStream|InputStream)([^[:alnum:]_]|$)' "event tap service must not perform filesystem IO"
fail_if_found '(^|[^[:alnum:]_])(URLSession|NSURLSession|NWConnection|NWPathMonitor|CFNetwork)([^[:alnum:]_]|$)|^import[[:space:]]+Network([^[:alnum:]_]|$)' "event tap service must not use network APIs"
fail_if_found '(^|[^[:alnum:]_])(Task\.sleep|Thread\.sleep|sleep|usleep|nanosleep)([^[:alnum:]_]|$)' "event tap service must not sleep"
fail_if_found '(^|[^[:alnum:]_])(print|fputs|NSLog|os_log)[[:space:]]*\(|(^|[^[:alnum:]_])(logger|appendLog)([^[:alnum:]_]|$)' "event tap service must not synchronously log or print"
fail_if_found '(^|[^[:alnum:]_])(DispatchSemaphore|NSLock|NSRecursiveLock|pthread_mutex|objc_sync_enter)([^[:alnum:]_]|$)|\.sync[[:space:]]*(\(|\{)' "event tap service must not take blocking locks"
fail_if_found '(^|[^[:alnum:]_])(keyDown|keyUp|kCGEventKeyDown|kCGEventKeyUp)([^[:alnum:]_]|$)' "event tap service must not listen for keyboard events"

if command -v rg >/dev/null 2>&1; then
  mask_found=$(rg -n 'CGEventMask\(1 << CGEventType\.scrollWheel\.rawValue\)' "$event_tap" || true)
else
  mask_found=$(grep -nF 'CGEventMask(1 << CGEventType.scrollWheel.rawValue)' "$event_tap" || true)
fi

if [ -z "$mask_found" ]; then
  echo "hot-path safety violation: event tap mask must be scrollWheel-only" >&2
  exit 1
fi

echo "hot-path safety checks: OK"

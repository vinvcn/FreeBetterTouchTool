#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

core_dir="Sources/ChromeWheelRouterCore"
app_dir="Sources/ChromeWheelRouterApp"
cli_dir="Sources/ChromeWheelRouterCLI"

search_dir() {
  local pattern="$1"
  local dir="$2"

  if command -v rg >/dev/null 2>&1; then
    rg -n -- "$pattern" "$dir"
  else
    grep -RInE -- "$pattern" "$dir"
  fi
}

if [ ! -d "$core_dir" ]; then
  echo "missing core source directory: $core_dir" >&2
  exit 1
fi

if search_dir '^import (AppKit|CoreGraphics|ApplicationServices)$' "$core_dir"; then
  echo "swift boundary violation: core must not import AppKit, CoreGraphics, or ApplicationServices" >&2
  exit 1
fi

if [ -d "$app_dir" ] && search_dir '(^|[^[:alnum:]_])(CGEvent|CGEventTap|CGEventMask|CGEventType|CGEventSource|CGKeyCode|CGEventFlags)([^[:alnum:]_]|$)|\.tapCreate([^[:alnum:]_]|$)|kCGEvent' "$app_dir"; then
  echo "swift boundary violation: app must not bypass ChromeWheelRouterMac with raw CoreGraphics event tap APIs" >&2
  exit 1
fi

if [ -d "$cli_dir" ] && search_dir '(^|[^[:alnum:]_])(Router|ScrollEventModel|RouteDecision)([^[:alnum:]_]|$)|\.zoomInAndSwallow|\.zoomOutAndSwallow|\.nextTabAndSwallow|\.previousTabAndSwallow' "$cli_dir"; then
  echo "swift boundary violation: CLI must delegate routing decisions to ChromeWheelRouterCore/ChromeWheelRouterMac" >&2
  exit 1
fi

echo "swift boundary checks: OK"

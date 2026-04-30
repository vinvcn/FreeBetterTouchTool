#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

core_dir="Sources/ChromeWheelRouterCore"

if [ ! -d "$core_dir" ]; then
  echo "missing core source directory: $core_dir" >&2
  exit 1
fi

if rg -n '^import (AppKit|CoreGraphics)$' "$core_dir"; then
  echo "swift boundary violation: core must not import AppKit or CoreGraphics" >&2
  exit 1
fi

echo "swift boundary checks: OK"

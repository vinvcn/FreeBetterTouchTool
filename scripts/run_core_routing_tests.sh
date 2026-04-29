#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v swiftc >/dev/null 2>&1; then
  echo "core routing tests skipped: swiftc not found"
  exit 0
fi

TMPDIR="${TMPDIR:-/tmp}"
BIN="$TMPDIR/chromewheelrouter-core-routing-tests.$$"
trap 'rm -f "$BIN"' EXIT

swiftc Sources/ChromeWheelRouterCore/*.swift scripts/run_core_routing_tests.swift -o "$BIN"
"$BIN"

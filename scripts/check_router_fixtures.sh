#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v swiftc >/dev/null 2>&1; then
  echo "router fixture check skipped: swiftc not found"
  exit 0
fi

TMPDIR="${TMPDIR:-/tmp}"
BIN="$TMPDIR/chromewheelrouter-router-fixtures.$$"
trap 'rm -f "$BIN"' EXIT

swiftc Sources/ChromeWheelRouterCore/*.swift scripts/check_router_fixtures.swift -o "$BIN"
"$BIN" ChromeWheelRouter/docs/qa/router_decision_fixtures/scenarios.json

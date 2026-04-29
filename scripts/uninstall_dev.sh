#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
VERBOSE=0

usage() {
  cat <<'USAGE'
Usage: scripts/uninstall_dev.sh [--dry-run] [--verbose] [--help]

Removes ChromeWheelRouter developer install artifacts from user-owned locations:
- ~/Applications/ChromeWheelRouter.command
- ~/Library/Application Support/ChromeWheelRouter
- ~/Library/Logs/ChromeWheelRouter

This script does not and cannot revoke macOS privacy permissions automatically.
USAGE
}

verbose() { [[ "$VERBOSE" -eq 1 ]] && echo "[verbose] $*"; }
run_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    verbose "$*"
    "$@"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run) DRY_RUN=1 ;;
    -v|--verbose) VERBOSE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1"; usage; exit 2 ;;
  esac
  shift
done

APP_COMMAND="$HOME/Applications/ChromeWheelRouter.command"
APP_SUPPORT_DIR="$HOME/Library/Application Support/ChromeWheelRouter"
LOG_DIR="$HOME/Library/Logs/ChromeWheelRouter"

echo "Uninstalling ChromeWheelRouter developer artifacts..."
run_cmd pkill -f "ChromeWheelRouter(App|CLI)?" || true
run_cmd rm -f "$APP_COMMAND"
run_cmd rm -rf "$APP_SUPPORT_DIR"
run_cmd rm -rf "$LOG_DIR"

echo "Uninstall complete (idempotent: missing paths are ignored)."
echo "If granted previously, revoke Accessibility/Input Monitoring permissions manually in System Settings → Privacy & Security."

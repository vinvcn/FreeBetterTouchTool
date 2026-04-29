#!/usr/bin/env bash
set -euo pipefail

APP_PATH="$HOME/Applications/ChromeWheelRouter.app"
CONFIG_PATH="$HOME/Library/Application Support/ChromeWheelRouter"
LOG_PATH="$HOME/Library/Logs/ChromeWheelRouter"

echo "Stopping ChromeWheelRouter if running..."
pkill -f "ChromeWheelRouter" 2>/dev/null || true

rm -rf "$APP_PATH"
rm -rf "$CONFIG_PATH"
rm -rf "$LOG_PATH"

echo "Removed user-level ChromeWheelRouter files where present."
echo "If macOS permissions were granted, revoke them manually in System Settings → Privacy & Security."

#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DRY_RUN=0
VERBOSE=0
SKIP_BUILD=0

usage() {
  cat <<'USAGE'
Usage: scripts/install_dev.sh [--dry-run] [--verbose] [--skip-build] [--help]

Installs ChromeWheelRouter developer artifacts to user-owned locations only:
- ~/Applications
- ~/Library/Application Support/ChromeWheelRouter

Options:
  -n, --dry-run    Print actions without changing files
  -v, --verbose    Print detailed command progress
      --skip-build Skip swift build -c release
  -h, --help       Show this help
USAGE
}

log() { echo "$*"; }
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
    --skip-build) SKIP_BUILD=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1"; usage; exit 2 ;;
  esac
  shift
done

APP_NAME="ChromeWheelRouterApp"
APP_SUPPORT_DIR="$HOME/Library/Application Support/ChromeWheelRouter"
BIN_DIR="$APP_SUPPORT_DIR/bin"
LOG_DIR="$HOME/Library/Logs/ChromeWheelRouter"
USER_APPS_DIR="$HOME/Applications"
LAUNCHER_PATH="$USER_APPS_DIR/ChromeWheelRouter.command"
INSTALL_META="$APP_SUPPORT_DIR/install-meta.txt"
BUILD_BIN="$REPO_ROOT/.build/release/$APP_NAME"
INSTALLED_BIN="$BIN_DIR/$APP_NAME"

log "Installing ChromeWheelRouter developer build to user-owned locations."

if [[ "$SKIP_BUILD" -eq 0 ]]; then
  run_cmd swift build -c release --product "$APP_NAME" --package-path "$REPO_ROOT"
else
  log "Skipping build because --skip-build was provided."
fi

if [[ ! -x "$BUILD_BIN" ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] would require built binary at: $BUILD_BIN"
  else
    echo "Expected built binary at: $BUILD_BIN" >&2
    echo "Build first or remove --skip-build." >&2
    exit 1
  fi
fi

run_cmd mkdir -p "$USER_APPS_DIR" "$BIN_DIR" "$LOG_DIR"
run_cmd cp "$BUILD_BIN" "$INSTALLED_BIN"
run_cmd chmod 755 "$INSTALLED_BIN"

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "[dry-run] write launcher at $LAUNCHER_PATH"
else
  cat > "$LAUNCHER_PATH" <<LAUNCHER
#!/usr/bin/env bash
exec "$INSTALLED_BIN" "\$@"
LAUNCHER
  chmod 755 "$LAUNCHER_PATH"
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "[dry-run] write install metadata at $INSTALL_META"
else
  {
    echo "installed_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "source_repo=$REPO_ROOT"
    echo "binary=$INSTALLED_BIN"
    echo "launcher=$LAUNCHER_PATH"
  } > "$INSTALL_META"
fi

log "Install complete."
log "Installed binary: $INSTALLED_BIN"
log "Launcher: $LAUNCHER_PATH"
log "Note: macOS Accessibility/Input Monitoring permissions, if granted, must be revoked manually in System Settings."

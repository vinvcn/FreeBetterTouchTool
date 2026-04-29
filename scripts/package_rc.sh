#!/usr/bin/env bash
set -euo pipefail

VERSION="${VERSION:-0.1.0-rc1}"
APP_NAME="ChromeWheelRouter"
APP_BUNDLE="${APP_NAME}.app"
DMG_NAME="${APP_NAME}-v${VERSION}.dmg"
DIST_DIR="dist"
BUILD_DIR=".build/rc"
MACOS_APP_DIR="${BUILD_DIR}/${APP_BUNDLE}"
DMG_ROOT="${BUILD_DIR}/dmg-root"
DEPLOYMENT_TARGET="${MACOS_DEPLOYMENT_TARGET:-12.0}"

mkdir -p "${DIST_DIR}" "${BUILD_DIR}"

TEST_REPORT="${DIST_DIR}/test_report.txt"
SAFETY_REPORT="${DIST_DIR}/static_safety_report.txt"
MANIFEST="${DIST_DIR}/build_manifest.json"
DMG_PATH="${DIST_DIR}/${DMG_NAME}"

: > "${TEST_REPORT}"
: > "${SAFETY_REPORT}"

echo "[package_rc] Running tests" | tee -a "${TEST_REPORT}"
if swift test >>"${TEST_REPORT}" 2>&1; then
  TEST_STATUS="pass"
else
  TEST_STATUS="fail"
fi

echo "[package_rc] Running static safety checks" | tee -a "${SAFETY_REPORT}"
if ./scripts/check_static_safety.sh >>"${SAFETY_REPORT}" 2>&1; then
  SAFETY_STATUS="pass"
else
  SAFETY_STATUS="fail"
fi

PACKAGING_STATUS="unavailable"
PACKAGING_NOTE="DMG packaging requires macOS tooling (xcodebuild/hdiutil)."
BINARY_ARCHS="n/a"

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "[package_rc] Building macOS universal release binary"
  ARM_TRIPLE="arm64-apple-macosx${DEPLOYMENT_TARGET}"
  X64_TRIPLE="x86_64-apple-macosx${DEPLOYMENT_TARGET}"

  swift build -c release --product ChromeWheelRouterApp --triple "${ARM_TRIPLE}"
  swift build -c release --product ChromeWheelRouterApp --triple "${X64_TRIPLE}"

  ARM_BIN_DIR="$(swift build -c release --product ChromeWheelRouterApp --triple "${ARM_TRIPLE}" --show-bin-path)"
  X64_BIN_DIR="$(swift build -c release --product ChromeWheelRouterApp --triple "${X64_TRIPLE}" --show-bin-path)"
  ARM_BIN="${ARM_BIN_DIR}/ChromeWheelRouterApp"
  X64_BIN="${X64_BIN_DIR}/ChromeWheelRouterApp"
  UNIVERSAL_BIN="${BUILD_DIR}/ChromeWheelRouterApp-universal"

  if [[ ! -f "${ARM_BIN}" || ! -f "${X64_BIN}" ]]; then
    echo "[package_rc] Missing architecture binaries:" >&2
    echo "  ARM: ${ARM_BIN}" >&2
    echo "  X64: ${X64_BIN}" >&2
    exit 1
  fi

  lipo -create -output "${UNIVERSAL_BIN}" "${ARM_BIN}" "${X64_BIN}"
  BINARY_ARCHS="$(lipo -archs "${UNIVERSAL_BIN}")"

  mkdir -p "${MACOS_APP_DIR}/Contents/MacOS"
  cp "${UNIVERSAL_BIN}" "${MACOS_APP_DIR}/Contents/MacOS/ChromeWheelRouterApp"

  cat > "${MACOS_APP_DIR}/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>${APP_NAME}</string>
  <key>CFBundleIdentifier</key><string>local.dev.${APP_NAME}</string>
  <key>CFBundleVersion</key><string>${VERSION}</string>
  <key>CFBundleShortVersionString</key><string>${VERSION}</string>
  <key>CFBundleExecutable</key><string>ChromeWheelRouterApp</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>LSUIElement</key><true/>
  <key>NSPrincipalClass</key><string>NSApplication</string>
  <key>LSMinimumSystemVersion</key><string>${DEPLOYMENT_TARGET}</string>
</dict></plist>
PLIST

  if [[ -n "${APPLE_CODESIGN_IDENTITY:-}" ]]; then
    codesign --force --deep --sign "${APPLE_CODESIGN_IDENTITY}" "${MACOS_APP_DIR}"
  fi

  mkdir -p "${DMG_ROOT}"
  ditto "${MACOS_APP_DIR}" "${DMG_ROOT}/${APP_BUNDLE}"
  hdiutil create -volname "${APP_NAME}" -srcfolder "${DMG_ROOT}" -ov -format UDZO "${DMG_PATH}"
  PACKAGING_STATUS="created"
  PACKAGING_NOTE="DMG built successfully."
else
  cat > "${DMG_PATH}" <<MSG
Placeholder artifact generated on non-macOS environment.
Real DMG packaging is unavailable here because hdiutil is not present.
Run scripts/package_rc.sh on macOS to produce an installable DMG.
MSG
fi

(
  cd "${DIST_DIR}"
  shasum -a 256 "${DMG_NAME}" test_report.txt static_safety_report.txt > SHA256SUMS
)

cat > "${MANIFEST}" <<JSON
{
  "app": "${APP_NAME}",
  "version": "${VERSION}",
  "date_utc": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "artifacts": [
    "${DMG_NAME}",
    "SHA256SUMS",
    "build_manifest.json",
    "test_report.txt",
    "static_safety_report.txt"
  ],
  "test_status": "${TEST_STATUS}",
  "static_safety_status": "${SAFETY_STATUS}",
  "packaging_status": "${PACKAGING_STATUS}",
  "packaging_note": "${PACKAGING_NOTE}",
  "macos_deployment_target": "${DEPLOYMENT_TARGET}",
  "binary_architectures": "${BINARY_ARCHS}",
  "optional_signing": {
    "supported": true,
    "env_var": "APPLE_CODESIGN_IDENTITY"
  }
}
JSON

echo "[package_rc] Done: ${DIST_DIR}"

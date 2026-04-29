# Lesson Learned — SwiftPM output paths are toolchain-dependent

Date: 2026-04-29
Node: EXEC-09

## Issue
RC macOS packaging failed in CI when `lipo` attempted to read binaries from hardcoded paths:
- `.build/arm64-apple-macosx12.0/release/ChromeWheelRouterApp`
- `.build/x86_64-apple-macosx12.0/release/ChromeWheelRouterApp`

## Why it happened
SwiftPM output folder layout differs across Xcode/Swift toolchains and may not include the exact triple/version string in the hardcoded form.

## Resolution
- Resolve architecture-specific binary paths with `swift build --show-bin-path` per triple.
- Validate resolved files exist before calling `lipo`.

## Preventive rule
Do not hardcode SwiftPM build output paths in packaging/CI scripts. Always discover paths using tool-supported queries (`--show-bin-path`) and verify them.

# ADR-001: RC DMG must ship a universal macOS binary (arm64 + x86_64)

- Status: Accepted
- Date: 2026-04-29
- Context: Owner acceptance may run on Intel or Apple Silicon Macs. Single-architecture RC builds caused install/runtime compatibility failures.

## Decision
RC packaging will produce a universal executable by:
1. Building `ChromeWheelRouterApp` for `arm64-apple-macosx<target>`.
2. Building `ChromeWheelRouterApp` for `x86_64-apple-macosx<target>`.
3. Merging binaries with `lipo` into one executable packaged in the app bundle.

## Consequences
- Improves cross-Mac compatibility for owner acceptance.
- Increases build time slightly due to dual builds.
- Requires CI/package validation to confirm architecture coverage.

## Verification requirements
- `build_manifest.json` must report architecture metadata (`binary_architectures`).
- RC packaging workflow must run on macOS and fail if universal assembly steps fail.

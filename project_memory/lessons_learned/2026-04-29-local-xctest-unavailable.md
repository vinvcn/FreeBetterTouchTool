# Local XCTest Unavailable in Current Toolchain

Date: 2026-04-29

## Observation

`swift test` and `./scripts/check_all.sh` reached SwiftPM after sandbox escalation but failed locally with:

```text
error: no such module 'XCTest'
```

`swift build -c release` completed successfully, and `./scripts/run_core_routing_tests.sh` passed.

## Impact

The local machine can compile release products and run the standalone pure routing harness, but cannot execute the XCTest suite until the local Swift/Xcode command line tools installation exposes XCTest correctly.

## Follow-up

Use GitHub Actions or a repaired local Xcode/Command Line Tools setup for full XCTest validation.

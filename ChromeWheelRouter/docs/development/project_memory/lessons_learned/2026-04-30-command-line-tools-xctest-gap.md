# Command Line Tools XCTest Gap

Date: 2026-04-30

## Lesson

On this machine, `./scripts/check_all.sh` can complete the harness validators, static safety checks, and core routing script, but `swift test` cannot run with only the selected Command Line Tools developer directory.

Observed state:

- `xcode-select -p` => `/Library/Developer/CommandLineTools`
- `xcrun --find xctest` => not found
- `swift test` => `no such module 'XCTest'`

## Impact

Full XCTest validation requires a matching full Xcode installation or another Swift toolchain that provides XCTest. The lightweight core routing script remains useful for local safety checks when XCTest is unavailable.

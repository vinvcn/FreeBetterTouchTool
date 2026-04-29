# EXEC-04 Node Report — Chrome Zoom Injection

Date: 2026-04-29
Branch: codex/exec-04

## Scope
Implemented real zoom injection for the CLI spike with strict mode safety:
- added `KeyboardInjecting` abstraction and `CGKeyboardInjector` implementation for:
  - Command + `=` (zoom in)
  - Command + `-` (zoom out)
- wired router decisions into event tap handling
- implemented active mode behavior:
  - only `zoomInAndSwallow` / `zoomOutAndSwallow` decisions attempt injection
  - matching events return `nil` only when injection succeeds
- ensured `listen-only` and `dry-run` never swallow and never inject
- extracted mode/decision action policy into `EventAction`

## Commands Run
1. `./scripts/check_all.sh`
2. `swift build -c release`

## Results
- static safety checks: PASS
- `swift test`: PASS
- `swift build -c release`: PASS

## Safety Confirmation
- event tap mask remains `scrollWheel`-only
- unmatched events return original event
- only Chrome + Option-only + horizontal scroll routes to swallow path (in active mode)
- listen-only and dry-run always pass through
- no keyDown/keyUp event taps were added

## Manual Mac QA Steps
Run locally on a real Mac with Accessibility and Input Monitoring permissions:

```bash
swift run ChromeWheelRouterCLI --active
```

1. In Chrome, hold Option and perform horizontal scroll right.
   - Expected: page zooms in (Command + `=` behavior)
   - Expected: original horizontal scroll is swallowed
2. In Chrome, hold Option and perform horizontal scroll left.
   - Expected: page zooms out (Command + `-` behavior)
   - Expected: original horizontal scroll is swallowed
3. Verify all non-matching inputs pass through unchanged:
   - non-Chrome app
   - vertical scroll
   - no modifier
   - Command/Shift/Control
   - Option+Command
4. Verify dry run never injects or swallows:

```bash
swift run ChromeWheelRouterCLI --dry-run
```

5. Verify listen-only never injects or swallows:

```bash
swift run ChromeWheelRouterCLI --listen-only
```

## Next Node
Next node: **EXEC-05**.

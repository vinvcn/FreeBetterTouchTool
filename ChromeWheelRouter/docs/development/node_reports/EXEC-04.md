# EXEC-04 Node Report — Chrome Shortcut Injection

Date: 2026-04-29
Branch: codex/exec-04

## Scope
Implemented real Chrome shortcut injection for the CLI spike with strict mode safety:
- added `KeyboardInjecting` abstraction and `CGKeyboardInjector` implementation for:
  - Command + `=` (zoom in)
  - Command + `-` (zoom out)
  - Control + `Tab` (next tab)
  - Control + Shift + `Tab` (previous tab)
- wired router decisions into event tap handling
- implemented active mode behavior:
  - only matched zoom or tab-switch decisions attempt injection
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
- only Chrome + Option-only + horizontal scroll or Chrome + Control-only + horizontal scroll routes to the swallow path (in active mode)
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
  - Command/Shift
  - Option+Control
   - Option+Command
4. Verify dry run never injects or swallows:

```bash
swift run ChromeWheelRouterCLI --dry-run
```

5. Verify listen-only never injects or swallows:

```bash
swift run ChromeWheelRouterCLI --listen-only
```

## Owner Manual QA Update
Reported by owner on 2026-04-29: the required routing safety matrix passed on real local usage:
- non-Chrome + Option + horizontal scroll => pass-through
- Chrome + vertical scroll => pass-through
- Chrome + horizontal scroll + no modifier => pass-through
- Chrome + horizontal scroll + Command => pass-through
- Chrome + horizontal scroll + Shift => pass-through
- Chrome + horizontal scroll + Control-only + positive dx => next tab and swallow
- Chrome + horizontal scroll + Control-only + negative dx => previous tab and swallow
- Chrome + horizontal scroll + Option+Command => pass-through
- Chrome + horizontal scroll + Option+Control => pass-through
- Chrome + horizontal scroll + Option-only + positive dx => zoom-in and swallow
- Chrome + horizontal scroll + Option-only + negative dx => zoom-out and swallow
- disabled router => pass-through

## HARNESS-00 Scope Reconciliation

On 2026-04-30, HARNESS-00 reconciled the project source of truth with ADR-002 and the current router implementation. The current MVP also allows Chrome + Control-only + horizontal scroll to switch tabs and swallow after successful injection. Bare horizontal scroll and mixed modifiers remain pass-through.

## Next Node
Next node: **EXEC-05**.

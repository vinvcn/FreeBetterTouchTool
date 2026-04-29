# Initial Codex Cloud Tasks

## Task 1: Confirm scaffold health

```text
Read AGENTS.md and ai_context/*.md.
Run ./scripts/check_all.sh.
Report any gaps in the scaffold without changing behavior.
```

## Task 2: Expand routing tests

```text
Add additional tests for all default Chrome bundle ids and disabled router behavior.
Do not add any macOS event tap code.
Run swift test.
```

## Task 3: Add macOS adapter skeleton

```text
Add a new module ChromeWheelRouterMac.
Implement type definitions for a future CGEventTapService, but do not create the event tap yet.
Keep the core pure and unit-testable.
Respect AGENTS.md safety rules.
```

## Task 4: Implement event tap in a small PR

```text
Implement CGEventTapService.
It must listen only to scrollWheel.
Pass-through must return the original event.
Only zoom decisions may return nil.
Do not add keyDown/keyUp taps.
Do not add network or telemetry.
```

## Task 5: Build menu bar app

```text
Add a macOS menu bar app shell with Enabled, Dry Run, Permissions, Logs, and Quit.
Do not add features outside MVP.
```

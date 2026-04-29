# Project Brief

## Product

`ChromeWheelRouter` is a narrow macOS utility for Chrome + Logitech MX Master users.

## User problem

The user wants Chrome horizontal scrolling to keep its existing Logi Options+ behavior, while adding a second mode:

- bare horizontal scroll: leave existing Logi Options+ behavior untouched
- Option + horizontal scroll: zoom Chrome page

The tool must not destabilize macOS or interfere with other apps.

## Current decision

Build it.

## MVP scope

Only Chrome.

Only one exact interception rule:

```text
Chrome frontmost
+ horizontal scroll
+ Option is the only modifier
=> send Chrome zoom shortcut and swallow original scroll event
```

Everything else passes through unchanged.

## Non-goals

- No Wuying / remote desktop support in MVP.
- No Action Ring.
- No general BetterTouchTool replacement.
- No arbitrary mouse combos.
- No keyboard event recorder.
- No cloud sync.
- No telemetry.

## Product shape

Target product after engineering phase:

```text
ChromeWheelRouter.app
ChromeWheelRouter.dmg
README / user guide / uninstall guide / security notes
```

The app should eventually be a menu bar app with enable/disable, permission status, dry-run mode, logs, start-at-login, and quit.

# Scope

ChromeWheelRouter is a small macOS menu bar utility for Chrome-only horizontal scroll routing. It is not a general input automation platform and not a BetterTouchTool clone.

## MVP Behavior

Only these Chrome-only horizontal scroll behaviors may be changed:

- If Google Chrome is the frontmost app, the event is horizontal scroll, and the only active modifier is Option, map scroll direction to Chrome page zoom and swallow the original scroll event.
- If Google Chrome is the frontmost app, the event is horizontal scroll, and the only active modifier is Control, map scroll direction to Chrome tab switching and swallow the original scroll event.

Everything else must pass through untouched.

## In Scope

1. Pure Swift routing core.
2. macOS event tap adapter.
3. Chrome-only zoom mapping.
4. Chrome-only tab switching mapping.
5. Menu bar control surface.
6. User-level installation.
7. Clean uninstall instructions.
8. Safety-focused documentation.
9. GitHub Actions CI.
10. DMG packaging.

## Out of Scope

1. Wuying / cloud desktop support.
2. System-wide mouse remapping.
3. General browser automation.
4. Keyboard event monitoring.
5. Reading user content.
6. Reading Chrome profile files.
7. Reading or writing Logi Options+ configuration.
8. Any network feature.
9. Any telemetry.
10. Any root installation.
11. Any kernel extension or driver.

## Target Product Shape

The first real product is a macOS menu bar app with:

- Enable / Disable
- Dry Run
- Permission status
- Open Accessibility settings
- Open Input Monitoring settings
- Start at Login toggle
- Open Logs
- Quit

The app should ship as a `.dmg` first. A `.pkg` installer is optional.

## Feature Gate Principle

If a requested feature requires broader event interception, new permissions, or behavior outside Chrome-only horizontal scroll routing, it must be explicitly recorded as a product decision before implementation.

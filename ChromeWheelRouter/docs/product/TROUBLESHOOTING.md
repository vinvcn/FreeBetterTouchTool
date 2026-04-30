# Troubleshooting

## Missing permissions status in menu

If the menu bar app shows `Status: Missing Permissions` or `Permissions: Missing`, ChromeWheelRouter is intentionally fail-closed and will **not** create the active event tap.

Grant both permissions in System Settings:

- Privacy & Security → Accessibility
- Privacy & Security → Input Monitoring

You can use these menu actions directly from ChromeWheelRouter:

- Open Accessibility Settings
- Open Input Monitoring Settings

After granting access, quit and relaunch the app.

## Pointer or mouse movement feels delayed

Disable ChromeWheelRouter from the menu bar and check whether pointer latency immediately disappears.

If latency only occurs while enabled, collect:

- macOS version
- display count and arrangement
- mouse model and Logi Options+ version if applicable
- whether latency happens during scroll bursts, display crossing, or both

The event tap must not perform per-event logging or disk IO, and the app must not repeatedly recreate the tap while running. These are performance safety invariants and regressions should be treated as release blockers.

## Bare horizontal wheel stopped working in Chrome

Expected code behavior is pass-through. Check:

1. Is ChromeWheelRouter disabled? If yes, behavior should be fully normal.
2. Is Logi Options+ still configured for Chrome horizontal wheel behavior?
3. Does the app log show pass-through for bare horizontal scroll?

## Option + horizontal wheel zooms and also switches tabs

Likely Logi Options+ handles the event before or independently from the app.

Possible future fallback:

- Let ChromeWheelRouter own Chrome horizontal wheel behavior entirely:
  - bare horizontal wheel → tab switch
  - Option + horizontal wheel → zoom

This is not the default MVP because the user asked to preserve Logi Options+ behavior.

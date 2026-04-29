# Troubleshooting

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

## Permissions do not appear

Quit and reopen the app. If still missing, open System Settings manually:

- Privacy & Security → Input Monitoring
- Privacy & Security → Accessibility

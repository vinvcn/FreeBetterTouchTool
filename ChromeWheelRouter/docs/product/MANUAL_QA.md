# Manual QA (Owner-Run on Real Mac)

Codex Cloud cannot validate physical input-device behavior. Run this on a real Mac with Chrome and the target mouse.

## Preconditions

- `ChromeWheelRouter.app` installed from RC DMG.
- Accessibility + Input Monitoring granted.
- Chrome is installed and running.

## Test matrix

1. Non-Chrome + Option + horizontal scroll => pass-through.
2. Chrome + vertical scroll => pass-through.
3. Chrome + horizontal scroll + no modifier => pass-through.
4. Chrome + horizontal scroll + Command => pass-through.
5. Chrome + horizontal scroll + Shift => pass-through.
6. Chrome + horizontal scroll + Control => pass-through.
7. Chrome + horizontal scroll + Option+Command => pass-through.
8. Chrome + horizontal scroll + Option-only + positive dx => zoom-in and swallow.
9. Chrome + horizontal scroll + Option-only + negative dx => zoom-out and swallow.
10. Disable router => pass-through.

## Acceptance recording

- Record results in `ChromeWheelRouter/docs/acceptance/HUMAN_ACCEPTANCE_REPORT.md`.
- Include macOS version, mouse model, Chrome version, and Logi Options+ version.
- If any case fails, include exact reproduction steps.

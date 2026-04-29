# Local Acceptance Runbook

This is the unavoidable human-confirmed stage.

## Prerequisites

- Your Mac.
- MX Master connected through your normal setup.
- Logi Options+ installed and configured.
- Chrome installed.
- RC DMG from EXEC-09.

## Test cases

### A1 — Install

1. Open RC DMG.
2. Move ChromeWheelRouter.app to Applications.
3. Launch the app.
4. Confirm menu bar item appears.

Pass if:

- App launches.
- No crash.
- Menu bar status is visible.

### A2 — Permissions

1. Enable the app.
2. Follow prompts for Accessibility/Input Monitoring.
3. Relaunch if macOS requires it.

Pass if:

- App shows permissions OK.
- App does not require Full Disk Access, Screen Recording, Bluetooth, Location, Camera, Microphone, or network permissions.

### A3 — Logi pass-through invariant

1. Open Chrome.
2. Use bare MX Master horizontal wheel.

Pass if:

- Your existing Logi Options+ behavior still works, e.g. tab switching.
- Page zoom does not trigger.

### A4 — Chrome zoom behavior

1. Open Chrome.
2. Hold Option.
3. Use MX Master horizontal wheel left/right.

Pass if:

- Page zooms in/out.
- Bare tab-switch behavior does not simultaneously trigger while Option is held.

### A5 — Non-Chrome pass-through

1. Open Finder, Terminal, VS Code, or another app.
2. Use horizontal wheel with and without Option.

Pass if:

- No Chrome zoom shortcut is injected.
- Other apps behave as before.

### A6 — Disable / Quit

1. Disable from menu.
2. Repeat Chrome wheel tests.
3. Quit app.
4. Confirm process is gone.

Pass if:

- Disabled app is full pass-through.
- Quit app leaves no running process.
- Mouse behavior returns to pre-app behavior.

### A7 — Uninstall

1. Run uninstall script or delete app per docs.
2. Remove config/logs created by app.
3. Revoke privacy permissions manually.

Pass if:

- No background process remains.
- Mouse behavior is unchanged.

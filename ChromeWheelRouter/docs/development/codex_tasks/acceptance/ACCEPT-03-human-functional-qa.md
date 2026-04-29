# ACCEPT-03 — Human Functional QA

## Purpose

Confirm the app works on the owner's real Mac with the real MX Master + Logi Options+ + Chrome setup.

Codex cannot complete this node. Only the human owner can.

## Required environment

- macOS laptop.
- MX Master mouse.
- Logi Options+ installed and configured.
- Chrome installed.
- ChromeWheelRouter RC installed.

## P0 test cases

### P0-01: Chrome bare horizontal scroll remains Logi-owned

Steps:

1. Open Chrome with multiple tabs.
2. Do not hold any modifier key.
3. Use MX Master horizontal wheel.

Expected:

- Existing Logi Options+ behavior still happens.
- If Logi was configured to switch tabs, it still switches tabs.
- ChromeWheelRouter should not zoom.

### P0-02: Chrome Option + horizontal scroll zooms

Steps:

1. Open Chrome page.
2. Hold Option.
3. Use MX Master horizontal wheel left/right.

Expected:

- Page zoom changes.
- It should not also switch tabs.

### P0-03: Non-Chrome pass-through

Steps:

1. Open Finder / Terminal / VS Code.
2. Try horizontal wheel with and without Option.

Expected:

- No ChromeWheelRouter zoom behavior.
- Existing app behavior remains.

### P0-04: Disable pass-through

Steps:

1. In menu bar, Disable ChromeWheelRouter.
2. Repeat Chrome Option + horizontal wheel.

Expected:

- ChromeWheelRouter no longer affects behavior.
- No injected zoom.

### P0-05: Quit restores system behavior

Steps:

1. Quit ChromeWheelRouter from menu.
2. Confirm process is gone.
3. Repeat Chrome and non-Chrome tests.

Expected:

- All behavior returns to pre-app state.

## P1 test cases

### P1-01: Restart app

Expected:

- App starts cleanly again.
- Enable/Disable still works.

### P1-02: Uninstall

Expected:

- Uninstall removes app/config/logs.
- Privacy permissions can be revoked manually.
- No background process remains.

## Human signoff

Use `templates/human_acceptance_report.md`.

Only mark accepted if every P0 test passes.

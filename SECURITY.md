# Security and Safety Model

ChromeWheelRouter is designed to be fail-open and user-local.

## What it should do

- Listen only for scroll wheel events.
- Handle only Chrome + Option-only + horizontal scroll.
- Pass through all other events unchanged.
- Inject only Chrome zoom shortcuts for matched events.

## What it must not do

- No keyboard event tap.
- No keylogging.
- No network.
- No telemetry.
- No root.
- No drivers.
- No kernel extensions.
- No privileged helper tools.
- No modification of Chrome settings.
- No modification of Logi Options+ settings.
- No reading Chrome profile files.

## Failure behavior

If the app quits or crashes, its event tap disappears with the process. Mouse behavior should return to normal system / Logi Options+ behavior.

## Permission model

The eventual menu bar app may need macOS Accessibility and Input Monitoring permissions. These must be user-granted through System Settings. The app must not attempt to bypass macOS privacy controls.

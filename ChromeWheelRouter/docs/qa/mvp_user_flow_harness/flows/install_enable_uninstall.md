# Flow: Install, Enable, Disable, Quit, Uninstall

## Install

Expected final path:

```text
/Applications/ChromeWheelRouter.app
```

or dev path:

```text
~/Applications/ChromeWheelRouter.app
```

Installer must not require root for dev install.

## First launch

The app should show:

- menu bar icon
- enabled/disabled state
- permission status
- open permission settings actions

## Enable

If permissions are missing:

- do not create event tap
- show missing permissions clearly

If permissions are granted:

- enable event routing
- still pass through all unmatched events

## Disable

Disable must stop routing behavior immediately.

## Quit

Quit must terminate the process. Event tap disappears with the process.

## Uninstall

Uninstall must remove:

- app bundle
- config directory
- log directory
- optional login item

macOS privacy permission records may need manual removal in System Settings. That must be documented.

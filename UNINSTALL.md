# Uninstall

For the current scaffold, no app is installed.

For the future app build:

1. Quit ChromeWheelRouter from the menu bar.
2. Delete `ChromeWheelRouter.app` from Applications or `~/Applications`.
3. Remove user data:

```bash
rm -rf "$HOME/Library/Application Support/ChromeWheelRouter"
rm -rf "$HOME/Library/Logs/ChromeWheelRouter"
```

4. Revoke permissions manually:

```text
System Settings → Privacy & Security → Input Monitoring
System Settings → Privacy & Security → Accessibility
```

The app must not install system daemons, kernel extensions, drivers, or privileged helpers.

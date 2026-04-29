# Manual QA Checklist

Run this on a real Mac with MX Master and Logi Options+.

## Precondition

- Logi Options+ already handles Chrome bare horizontal wheel behavior.
- ChromeWheelRouter is installed and visible in the menu bar.
- ChromeWheelRouter is enabled.
- Required macOS permissions are granted.

## Tests

### 1. Chrome bare horizontal wheel

Action:

```text
Chrome frontmost → horizontal wheel without modifier
```

Expected:

```text
Existing Logi Options+ behavior still happens.
No page zoom occurs.
```

### 2. Chrome Option + horizontal wheel

Action:

```text
Chrome frontmost → hold Option → horizontal wheel
```

Expected:

```text
Chrome page zooms.
Existing Logi tab switching should not also fire.
```

### 3. Non-Chrome apps

Action:

```text
Finder / VS Code / Terminal frontmost → Option + horizontal wheel
```

Expected:

```text
No Chrome zoom shortcut is injected.
No visible effect from ChromeWheelRouter.
```

### 4. Disable

Action:

```text
Menu bar → Disable
```

Expected:

```text
All behavior returns to Logi Options+ / system default.
```

### 5. Quit

Action:

```text
Menu bar → Quit
```

Expected:

```text
Process exits.
All behavior returns to Logi Options+ / system default.
```

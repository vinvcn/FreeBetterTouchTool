# Flow: Chrome Option + Horizontal Scroll Zoom

## Goal

Add zoom mode without breaking existing Logi Options+ bare horizontal wheel behavior.

## Exact rule

```text
Chrome frontmost
+ horizontal scroll
+ Option is the only modifier
=> send Chrome zoom shortcut
=> swallow original event
```

## Pass-through rules

Must pass through:

- bare horizontal scroll
- vertical scroll
- non-Chrome apps
- Chrome + Command
- Chrome + Shift
- Chrome + Control
- Chrome + Option + any other modifier
- disabled router

## User test

1. Open Chrome.
2. Verify bare horizontal wheel still does the old Logi Options+ behavior.
3. Hold Option and move horizontal wheel right.
4. Page should zoom in.
5. Hold Option and move horizontal wheel left.
6. Page should zoom out.
7. Release Option and move horizontal wheel again.
8. Old Logi Options+ behavior should still happen.

# Safety Constraints

This project changes low-level input routing. Scope discipline matters more than feature count.

## Non-negotiable constraints

1. Do not listen to `keyDown`.
2. Do not listen to `keyUp`.
3. Do not record keyboard input.
4. Do not record typed text.
5. Do not read Chrome profile data.
6. Do not read Logi Options+ config or data.
7. Do not modify Chrome settings.
8. Do not modify Logi Options+ settings.
9. Do not modify macOS keyboard shortcuts.
10. Do not use network APIs.
11. Do not add telemetry.
12. Do not require root.
13. Do not use `sudo` in install scripts.
14. Do not install kernel extensions.
15. Do not install system extensions.
16. Do not install LaunchDaemons.
17. Do not install privileged helpers.
18. Do not write to `/System`.
19. Do not write to `/Library/LaunchDaemons`.
20. Do not write to `/Library/PrivilegedHelperTools`.
21. The event tap mask must only include `scrollWheel`.
22. Unmatched events must return the original event.
23. Only Chrome + Option-only + horizontal scroll or Chrome + Control-only + horizontal scroll may be swallowed.
24. Event tap callbacks must not perform disk IO.
25. Event tap callbacks must not perform network IO.
26. Event tap callbacks must not call shell commands.
27. Event tap callbacks must not sleep.
28. Event tap callbacks must not take blocking locks.
29. If permissions are missing, fail closed: do not create the event tap.
30. If runtime state is uncertain, fail open: pass events through.
31. Event tap callbacks must stay allocation-light and must not perform per-event logging.
32. Long-running runtime polling must not recreate event taps unless the desired running state or mode changed.
33. Frontmost-app state should be cached outside the event tap callback when practical; do not add repeated workspace/process lookups to the hot path without a documented reason.

## Runtime constraints

The event tap callback must remain extremely small.

Detailed callback rules live in [Hot-Path Rules](hot_path_rules.md).

Forbidden inside callback:

- disk IO
- network IO
- shell commands
- sleep
- blocking locks
- complex logging
- user prompts

Allowed inside callback:

- inspect event type
- inspect horizontal delta
- inspect modifiers
- read cached enabled/config state
- call routing logic
- post Chrome zoom or tab-switch shortcut for an exact matched route
- return event or nil

## Security posture

The app should need only:

- Accessibility
- Input Monitoring

It should not need:

- Full Disk Access
- Screen Recording
- Contacts
- Location
- Bluetooth
- Camera
- Microphone
- network permission

## Proof obligation

The unit test suite must prove that Chrome + bare horizontal scroll returns pass-through.

That test is the protection for Logi Options+ behavior.

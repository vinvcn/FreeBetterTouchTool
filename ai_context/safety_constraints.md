# Safety Constraints

This project changes low-level input routing. Scope discipline matters more than feature count.

## Non-negotiable constraints

- Do not listen to keyDown or keyUp.
- Do not record text input.
- Do not collect telemetry.
- Do not use network APIs.
- Do not read Chrome profile data.
- Do not read Logi Options+ files.
- Do not require root.
- Do not use sudo.
- Do not install a LaunchDaemon.
- Do not install privileged helper tools.
- Do not install drivers.
- Do not install kernel extensions.
- Do not write to system-level directories.
- Do not modify macOS keyboard shortcuts.
- Do not modify Chrome settings.
- Do not modify Logi Options+ settings.

## Runtime constraints

The event tap callback must remain extremely small.

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
- post Chrome zoom shortcut
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

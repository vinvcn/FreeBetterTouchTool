# Safety Invariants

These are non-negotiable.

## Event scope

- Listen only to scroll wheel events.
- Do not listen to keyboard events.
- Do not listen to mouse clicks in the MVP.
- Do not read text input.

## Matching scope

Only these events may be swallowed:

```text
Chrome bundle ID
+ Option-only modifier
+ horizontalDelta != 0
+ app enabled
```

```text
Chrome bundle ID
+ Control-only modifier
+ horizontalDelta != 0
+ app enabled
```

All other events must be returned unchanged.

## Hot path constraints

The event callback must not perform:

- disk IO
- network IO
- shell commands
- sleeps
- blocking waits
- package installation
- config mutation
- per-event logging
- repeated workspace/process lookups when equivalent state can be cached outside the callback

## Long-running runtime constraints

- Runtime polling must not restart, recreate, or re-enable event taps unless the desired running state or mode changed.
- Permission/status checks must stay outside the scroll event callback.
- Diagnostics for scroll events must be sampled, aggregated, or moved off the event tap hot path.

## Installation constraints

- No root.
- No privileged helper.
- No LaunchDaemon.
- No kernel extension.
- No driver.
- No hidden background process.

## User control

The app must provide:

- visible menu bar presence
- Enable / Disable
- Quit
- uninstall docs
- clear permission explanation

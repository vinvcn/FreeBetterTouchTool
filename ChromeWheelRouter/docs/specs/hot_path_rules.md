# Hot-Path Rules

The scroll event tap callback is the runtime hot path. Keep it small, deterministic, and fail-open.

## Event Tap Scope

- The event tap mask must only include `scrollWheel`.
- Do not listen to `keyDown`.
- Do not listen to `keyUp`.
- Do not listen to mouse clicks for the MVP.

## Callback Must Not

The event tap callback must not perform:

- disk IO
- network IO
- shell commands
- sleep
- blocking locks
- package installation
- config mutation
- user prompts
- per-event logging
- repeated workspace or process lookups when equivalent state can be cached outside the callback

## Callback May

The event tap callback may:

- inspect event type
- inspect horizontal and vertical scroll deltas
- inspect modifier flags
- read cached enabled/config state
- read cached frontmost-app state
- call pure routing logic
- post the required Chrome shortcut for matched actions
- return the original event or swallow the event

## Pass-Through And Swallow Rules

- Unmatched events must return the original event.
- Only Chrome + Option-only + horizontal scroll may map to page zoom and be swallowed.
- Only Chrome + Control-only + horizontal scroll may map to tab switching and be swallowed.
- If runtime state is uncertain, pass events through.
- If permissions are missing, fail closed by not creating the event tap.

## Long-Running Runtime Rules

- Long-running runtime polling must not recreate event taps unless the desired running state or mode changed.
- Permission and status checks must stay outside the scroll event callback.
- Diagnostics for scroll events must be sampled, aggregated, or moved off the event tap hot path.

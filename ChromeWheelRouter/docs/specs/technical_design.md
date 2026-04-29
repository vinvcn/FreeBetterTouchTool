# Technical Design

## Architecture

```text
CGEventTapService
  -> translates CGEvent scrollWheel into ScrollEventModel
  -> calls ChromeWheelRouterCore.Router.decide(...)
  -> pass-through: returns original event
  -> zoom: injects Chrome shortcut and returns nil
```

## Core routing model

Pure Swift module:

```text
Sources/ChromeWheelRouterCore
```

Inputs:

- frontmost bundle id
- horizontal scroll delta
- vertical scroll delta
- modifier state
- router enabled flag

Output:

- passThrough
- zoomInAndSwallow
- zoomOutAndSwallow

## macOS adapter

Future module:

```text
Sources/ChromeWheelRouterMac
```

Responsibilities:

- create event tap with only scrollWheel mask
- read horizontal delta
- read modifier flags
- read frontmost app bundle id
- call pure router
- inject Chrome shortcuts
- return original event or nil

## menu bar app

Future module:

```text
Sources/ChromeWheelRouterApp
```

Responsibilities:

- status UI
- enable/disable
- dry-run
- permissions guidance
- start at login
- quit
- open logs

## Key shortcuts

Chrome zoom in:

```text
Command + =
```

Chrome zoom out:

```text
Command + -
```

## Failure behavior

- Missing permission: do not create event tap.
- Disabled state: pass through.
- Unknown app: pass through.
- Unexpected modifier: pass through.
- Non-horizontal scroll: pass through.

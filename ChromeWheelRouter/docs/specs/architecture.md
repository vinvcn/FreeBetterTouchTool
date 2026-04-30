# Architecture

## Target architecture

```text
ChromeWheelRouter.app
├── MenuBar UI
│   ├── Enabled / Disabled
│   ├── Dry Run
│   ├── Start at Login
│   ├── Open Permission Settings
│   ├── Open Logs
│   └── Quit
│
├── EventTap Adapter
│   ├── listens only to scrollWheel
│   ├── converts CGEvent into ScrollEventModel
│   ├── calls Router.decide(...)
│   └── returns original event unless matched
│
├── Core Router
│   ├── pure Swift
│   ├── unit-testable
│   └── no macOS APIs
│
└── Installer / Docs
    ├── DMG
    ├── install script for dev
    └── uninstall script / guide
```

## Current scaffold

The current repo includes only the safe core layer and harnesses. The actual `CGEventTap` adapter is intentionally not implemented in the scaffold.

## Event flow

```text
scrollWheel event
→ EventTap Adapter
→ ScrollEventModel
→ Router.decide
→ passThrough: return original event
→ zoom/tab action: inject Chrome shortcut and swallow original event
```

## Fail-open rule

Any unknown state must become `passThrough`, not `swallow`.

Examples:

- Unknown app bundle ID → passThrough
- Unsupported modifier state → passThrough
- Vertical-only scroll → passThrough
- Disabled app state → passThrough
- Permission missing → do not create event tap

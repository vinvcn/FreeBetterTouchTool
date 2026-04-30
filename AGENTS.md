# AGENTS.md

## Project

Project name: `ChromeWheelRouter`

Build a small macOS menu bar utility. It is not a general input automation platform and not a BetterTouchTool clone.

## MVP behavior

Only these Chrome-only horizontal scroll behaviors should be changed:

- If Google Chrome is the frontmost app
- and the event is horizontal scroll
- and the only active modifier is Option
- then map the scroll direction to Chrome page zoom and swallow the original scroll event.
- If Google Chrome is the frontmost app
- and the event is horizontal scroll
- and the only active modifier is Control
- then map the scroll direction to Chrome tab switching and swallow the original scroll event.

Everything else must pass through untouched.

## Hard safety rules

These rules are non-negotiable.

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

## Target implementation shape

The first real product should be a macOS menu bar app:

- Enable / Disable
- Dry Run
- Permission status
- Open Accessibility settings
- Open Input Monitoring settings
- Start at Login toggle
- Open Logs
- Quit

The app should eventually ship as a `.dmg` first. A `.pkg` installer is optional.

## Required source boundaries

Core routing must be pure Swift and unit-testable.

Suggested modules:

```text
Sources/ChromeWheelRouterCore
Sources/ChromeWheelRouterMac
Sources/ChromeWheelRouterApp
```

Core logic must not import AppKit or CoreGraphics unless absolutely necessary. The macOS adapter should translate `CGEvent` into the pure core model.

## Required tests

At minimum, tests must cover:

- non-Chrome + Option + horizontal scroll => pass-through
- Chrome + vertical scroll => pass-through
- Chrome + horizontal scroll + no modifier => pass-through
- Chrome + horizontal scroll + Command => pass-through
- Chrome + horizontal scroll + Shift => pass-through
- Chrome + horizontal scroll + Control-only + positive dx => next-tab-and-swallow
- Chrome + horizontal scroll + Control-only + negative dx => previous-tab-and-swallow
- Chrome + horizontal scroll + Option+Command => pass-through
- Chrome + horizontal scroll + Option+Control => pass-through
- Chrome + horizontal scroll + Option-only + positive dx => zoom-in-and-swallow
- Chrome + horizontal scroll + Option-only + negative dx => zoom-out-and-swallow
- disabled router => pass-through

Do not remove these tests. They are the safety contract.

## Commands

Run before opening a PR:

```bash
./scripts/check_all.sh
```

If Swift tooling is available:

```bash
swift test
swift build -c release
```

## PR expectations

Each PR should be small and reviewable.

Good Codex Cloud tasks:

- implement pure router logic
- add tests
- implement macOS event tap adapter
- add menu bar UI
- add permission UX
- add packaging scripts
- add user docs

Bad Codex Cloud tasks:

- “build a BetterTouchTool clone”
- “implement all mouse automation”
- “handle every browser and app”
- “bypass macOS permissions”

## Manual QA requirement

Final behavior involving MX Master hardware, Logi Options+, Chrome, and macOS privacy permissions must be tested on a real Mac. Codex Cloud cannot validate physical input-device behavior.


## Repository organization invariant

No root-level `*_addendum` directories should be introduced. Supplemental materials belong in their canonical directories, for example:

- `agent_state_harness/`
- `ChromeWheelRouter/docs/specs/`
- `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/`

## Project memory requirements

When completing any execution node, update project memory if the task creates new knowledge.

Update these files as appropriate:

- `ChromeWheelRouter/docs/development/node_reports/EXEC-XX.md`
- `ChromeWheelRouter/docs/development/project_memory/node_summaries/EXEC-XX.md`
- `ChromeWheelRouter/docs/development/project_memory/lessons_learned/*.md`
- `ChromeWheelRouter/docs/development/project_memory/decisions/ADR-*.md`
- `ChromeWheelRouter/docs/product/TROUBLESHOOTING.md`

Do not rely on chat history as project memory.

If a bug, toolchain issue, compatibility issue, or safety edge case is discovered, record it in `ChromeWheelRouter/docs/development/project_memory/lessons_learned/`.

If a durable architectural decision is made, record it as an ADR in `ChromeWheelRouter/docs/development/project_memory/decisions/`.

# Acceptance Criteria

## MVP function

- Chrome + Option + horizontal scroll right => zoom in.
- Chrome + Option + horizontal scroll left => zoom out.
- Chrome + Control + horizontal scroll right => next tab.
- Chrome + Control + horizontal scroll left => previous tab.
- Chrome + Option + Control + horizontal scroll => pass through.
- Chrome + bare horizontal scroll => pass through.
- Non-Chrome + horizontal scroll => pass through.
- Vertical scroll => pass through.
- Disabled mode => all pass through.

## Required Automated Tests

These tests are the safety contract. Do not remove them.

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

## Installation

Final product should provide:

- `.app`
- `.dmg`
- install docs
- uninstall docs
- security docs

## Safe runtime

- No root required.
- No system daemon.
- No driver.
- No kernel extension.
- No network.
- No keyboard event tap.

## User-facing controls

Final menu bar app should include:

- enabled/disabled state
- dry-run mode
- permission status
- open permission settings
- start at login toggle
- open logs
- quit

## Manual QA

The release cannot be considered done until tested on a real Mac with:

- Logitech MX Master horizontal wheel
- Logi Options+
- Chrome
- Option modifier
- macOS Input Monitoring and Accessibility permissions

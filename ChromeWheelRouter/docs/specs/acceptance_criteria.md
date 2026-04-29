# Acceptance Criteria

## MVP function

- Chrome + Option + horizontal scroll right => zoom in.
- Chrome + Option + horizontal scroll left => zoom out.
- Chrome + bare horizontal scroll => pass through.
- Non-Chrome + horizontal scroll => pass through.
- Vertical scroll => pass through.
- Disabled mode => all pass through.

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

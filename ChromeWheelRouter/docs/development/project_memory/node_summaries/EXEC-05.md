# EXEC-05 Summary

Date: 2026-04-29

- Added `ChromeWheelRouterApp` executable target as a menu bar MVP.
- Implemented menu actions for status, enable/disable, dry run toggle, open logs, and quit.
- App starts disabled and only starts event tap when both user enablement and permission preflight are satisfied.
- Added explicit `CGEventTapService.stop()` and used it on disable and quit paths to guarantee pass-through when disabled.
- Preserved CLI target for debugging and regression isolation.

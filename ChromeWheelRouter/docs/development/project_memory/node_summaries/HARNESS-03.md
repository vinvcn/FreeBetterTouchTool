# HARNESS-03 Summary

Added architecture and hot-path safety sensors for issue #30.

Key knowledge:

- `ChromeWheelRouterCore` must remain free of AppKit, CoreGraphics, and ApplicationServices.
- Raw event tap APIs belong in `ChromeWheelRouterMac`; App and CLI should provide runtime state and delegate routing.
- `CGEventTapService` must not default to `NSWorkspace.shared.frontmostApplication` because callers that forget to provide cached state would reintroduce a per-event workspace lookup.
- Tap-disabled diagnostics should be delivered off the callback stack so App logging does not run synchronously inside the event tap callback.


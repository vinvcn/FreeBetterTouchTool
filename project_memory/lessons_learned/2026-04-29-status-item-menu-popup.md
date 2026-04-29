# 2026-04-29 - Status item menu presentation

## Context

On macOS 14.8.5, the menu bar item could appear after launch but clicking it did not present the dropdown menu.

## Lesson

For the current SwiftPM-built app bundle shape, relying only on `NSStatusItem.menu` was not sufficient in user testing. The menu bar app should explicitly handle status item button clicks and present the retained menu.

## Follow-up

Keep the status item action path covered during manual QA:

- launch the packaged app
- click the `CWR` menu bar item
- verify the menu opens
- verify left-click and right-click both open the same menu

Package menu bar apps with `LSUIElement=true` in the app bundle `Info.plist`, and build the DMG from a staging folder that contains `ChromeWheelRouter.app` rather than using the `.app` directory itself as the DMG source folder.

SwiftPM AppKit executables should use an explicit `NSApplication.shared` entrypoint that retains the app delegate and calls `app.run()`. Relying on `@main` directly on the delegate class can leave the process running without `applicationDidFinishLaunching` being called.

Do not automatically request Accessibility/Input Monitoring prompts at startup. On macOS 14.8.5 this made the menu-bar-only app appear to exit or disappear after the permission dialog. Launch should create the status item first and expose a manual "Request Permission Prompts" menu item.

# 2026-04-29 - Explicit Permission Check UX

## Context

During local macOS 14.8.5 testing, automatic permission prompts made the menu-bar app startup flow confusing. The app may already be running as a menu bar agent while appearing to do nothing after permission prompts.

## Lesson

Permission prompting and permission checking should be separate user actions:

- `Check Permissions` should only inspect current Accessibility and Input Monitoring state.
- `Request Permission Prompts` should trigger macOS prompts.
- Startup should create the menu bar item without automatically prompting.

This keeps diagnosis explicit and avoids hiding app startup behind macOS privacy dialogs.

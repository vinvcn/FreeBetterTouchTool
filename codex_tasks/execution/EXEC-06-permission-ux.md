# EXEC-06 — Permission UX and Fail-Closed

## Codex Cloud prompt

Task:

Implement safe permission handling.

Required behavior:

- Check Accessibility permission.
- Check or clearly guide Input Monitoring permission where programmatic status is limited.
- If required permissions are missing, the app must fail closed:
  - do not create active event tap
  - show Missing Permissions in menu
  - provide menu links/instructions to open relevant System Settings pages
- After permissions are granted, user can Enable.

Required docs:

- Update `USER_GUIDE.md` with first-run permission steps.
- Update `TROUBLESHOOTING.md` with permission problems.
- Update `SECURITY.md` to explain why permissions are needed and what is not collected.

Hard constraints:

- Do not request Full Disk Access.
- Do not request Screen Recording.
- Do not request Bluetooth.
- Do not request network permissions.
- Do not try to bypass macOS privacy prompts.

Deliverables:

- Permission controller.
- Menu state integration.
- Docs update.
- `node_reports/EXEC-06.md`.
- Updated agent state.

Acceptance:

- Missing permissions do not crash app.
- Missing permissions do not create active event tap.
- UI tells user what to do.

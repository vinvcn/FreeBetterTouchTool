# EXEC-06 — Permission UX and Fail-Closed

Read first:
- AGENTS.md
- SECURITY.md
- node_reports/EXEC-05.md

Goal:
Make permission handling safe and understandable.

Tasks:
1. Check Accessibility permission.
2. Provide menu actions to open Accessibility and Input Monitoring settings.
3. If permissions are missing, display Missing Permissions and do not start active event tap.
4. Add clear troubleshooting text.
5. Add `node_reports/EXEC-06.md`.

Hard constraints:
- Do not attempt to bypass macOS TCC/privacy prompts.
- Do not ask for Full Disk Access, Screen Recording, Bluetooth, Location, Camera, Microphone, or network permissions.
- Fail closed when permissions are missing.

Definition of done:
- Permission state is visible in menu.
- Missing permissions do not cause crash.
- Next node is EXEC-07.

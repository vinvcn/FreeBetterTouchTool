# EXEC-08 — Dev Install / Uninstall

Read first:
- AGENTS.md
- ChromeWheelRouter/docs/development/node_reports/EXEC-07.md

Goal:
Provide clean local install/uninstall for developer/owner testing.

Tasks:
1. Add `scripts/install_dev.sh`.
2. Add `scripts/uninstall_dev.sh`.
3. Install only to user-controlled locations, preferably `~/Applications` or `~/Library/Application Support/ChromeWheelRouter`.
4. Uninstall must remove installed app/binary, logs, config, and optional launch/login registration if this project created it.
5. Document that macOS privacy permissions must be revoked manually.
6. Add `ChromeWheelRouter/docs/development/node_reports/EXEC-08.md`.

Hard constraints:
- No sudo.
- No /System writes.
- No /Library/LaunchDaemons.
- No privileged helpers.
- No Logi Options+ or Chrome config modifications.

Definition of done:
- Install/uninstall scripts are idempotent.
- Dry run or verbose mode exists.
- Next node is EXEC-09.

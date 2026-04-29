# EXEC-08 — Dev Install / Uninstall

## Codex Cloud prompt

Task:

Create clean local install and uninstall scripts for development and acceptance.

Required scripts:

- `scripts/install_dev.sh`
- `scripts/uninstall_dev.sh`

Install requirements:

- No sudo.
- Do not write `/System`.
- Do not write `/Library/LaunchDaemons`.
- Do not install privileged helper tools.
- Install app to a clear user-controlled location:
  - preferred: `~/Applications/ChromeWheelRouter.app`
  - or documented `/Applications` copy only if no sudo is required.
- Create directories:
  - `~/Library/Application Support/ChromeWheelRouter`
  - `~/Library/Logs/ChromeWheelRouter`

Uninstall requirements:

- Stop app if running where practical.
- Remove installed app.
- Remove config directory.
- Remove logs directory.
- Be idempotent: running twice should not fail badly.
- Clearly document that macOS Privacy permissions must be manually revoked in System Settings.

Deliverables:

- Scripts.
- `UNINSTALL.md` update.
- `USER_GUIDE.md` install section update.
- `node_reports/EXEC-08.md`.
- Updated agent state.

Acceptance:

- Static checks confirm no sudo / no system daemon.
- Owner can install and uninstall locally.

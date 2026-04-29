# Execution Gate Checklist

Use this checklist before merging any EXEC node PR.

## Required

- [ ] PR targets exactly one node.
- [ ] PR includes `ChromeWheelRouter/docs/development/node_reports/EXEC-XX.md`.
- [ ] `scripts/check_all.sh` passes.
- [ ] CI passed.
- [ ] No forbidden API or permission introduced.
- [ ] Scope did not expand.
- [ ] `agent_state_harness/current_state.json` updated.
- [ ] Docs updated if behavior changed.

## Input tool safety

- [ ] No keyboard event tap.
- [ ] No global shortcut feature.
- [ ] No network/telemetry.
- [ ] No root install.
- [ ] No automatic LaunchDaemon.
- [ ] No Chrome or Logi config mutation.

## MVP invariant

- [ ] Chrome + no modifier + horizontal scroll = pass-through.
- [ ] Chrome + Option-only + horizontal scroll = zoom + swallow.
- [ ] Non-Chrome = pass-through.

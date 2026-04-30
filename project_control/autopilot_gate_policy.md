# Autopilot Gate Policy

## Default policy

- Codex may implement and revise code.
- Codex may open PRs.
- Codex may update documentation.
- Codex may generate release-candidate artifacts through CI.
- Codex must not merge its own PRs unless the owner explicitly enables auto-merge in GitHub.

## Recommended owner workflow

Conservative mode:

1. Submit one Codex node.
2. Wait for PR.
3. Confirm CI green and node report present.
4. Merge.
5. Submit next node.

Low-touch mode:

1. Submit one Codex node.
2. Enable Codex review and branch protection.
3. Use GitHub auto-merge for PRs that pass required checks.
4. Owner only reviews failed gates and final RC.

Do not use fully unattended release for v0.1.0. The app touches macOS input events; human local acceptance is mandatory.

## Machine-checkable PR evidence

Every Codex PR must add or update a node report under
`ChromeWheelRouter/docs/development/node_reports/`. New reports must include a
fenced `json node-report` evidence block matching
`templates/node_report.schema.json`.

The Autopilot Gate validates changed PR node reports with
`scripts/check_node_report.py`. The gate fails when a PR has no node report, a
report omits required evidence, required command results are missing, safety
invariants are incomplete, changed files are not listed, manual-validation
requirements are understated, or source-of-truth changes lack an explicit
state/scope explanation.

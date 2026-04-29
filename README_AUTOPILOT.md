# ChromeWheelRouter Autopilot Control Pack

This pack adds a minimal-human-intervention execution layer on top of the existing ChromeWheelRouter scaffold.

Owner goal:

- Owner defines scope once.
- Codex executes engineering nodes.
- CI and static safety gates produce evidence.
- Owner intervenes only at unavoidable points: setup/auth, gate override when automation fails, final local hardware acceptance.

Non-negotiable product scope:

- Only Chrome.
- Only Option-only + horizontal scroll triggers Chrome zoom.
- Everything else must pass through untouched.
- Bare horizontal scroll in Chrome must remain available for Logi Options+.
- No telemetry, no network, no keyDown/keyUp listening, no driver, no root service.

Recommended process:

1. Merge this pack into the repo.
2. Run `./scripts/create_autopilot_issues.sh`.
3. Configure Codex Cloud environment for the GitHub repo.
4. Use `./scripts/submit_codex_node.sh EXEC-01` to start the first node.
5. Let Codex open PRs. CI and gate checks run automatically.
6. Merge only node PRs that include a node report and pass all required checks.
7. Continue through EXEC-09.
8. Install the RC DMG locally and run the human acceptance checklist.

The execution phase is machine-driven. The acceptance phase is human-confirmed.

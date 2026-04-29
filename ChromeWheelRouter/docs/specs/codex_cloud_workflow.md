# Codex Cloud Workflow

## What Codex Cloud should do

Use Codex Cloud for isolated engineering tasks:

1. Pure routing logic and tests.
2. macOS adapter implementation.
3. Menu bar app UI.
4. Permission status UX.
5. Packaging scripts.
6. Documentation.
7. CI setup.

## What Codex Cloud should not claim to validate

Codex Cloud cannot validate:

- real MX Master horizontal wheel hardware behavior
- Logi Options+ event ordering
- macOS privacy permission prompts on the user's machine
- actual menu bar interaction on the user's desktop
- signed/notarized release with private Apple credentials unless CI is configured separately

## Branch / PR strategy

Use small PRs:

1. `scaffold-core-router`
2. `macos-event-tap-adapter`
3. `menu-bar-app`
4. `permissions-and-status`
5. `packaging-and-dmg`
6. `docs-and-release-checklist`

## Recommended first Codex prompt

```text
Read AGENTS.md and ChromeWheelRouter/docs/specs/*.md.
Implement the next smallest safe step.
Do not expand scope.
Do not add keyboard event listening.
Run ./scripts/check_all.sh before finalizing.
```

## Review rule

Reject any PR that:

- adds keyDown/keyUp event taps
- adds network APIs
- adds telemetry
- writes to system directories
- removes pass-through tests
- makes bare horizontal scroll handled instead of pass-through

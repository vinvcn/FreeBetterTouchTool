# Import to Codex Cloud

This project cannot be imported automatically from this script because Codex Cloud account access is interactive.

Manual steps:

1. Push this repo to GitHub.
2. Open Codex Web / Codex Cloud.
3. Connect GitHub if not already connected.
4. Select the `ChromeWheelRouter` repo.
5. Start with this prompt:

```text
Read AGENTS.md, ChromeWheelRouter/docs/specs/*.md, agent_state_harness/current_state.json, and ChromeWheelRouter/docs/qa/mvp_user_flow_harness/scenarios.json.
Do not expand scope.
Run ./scripts/check_all.sh.
Then propose the next smallest PR to implement the macOS adapter or menu bar app.
```

Keep Codex tasks small. Do not ask for the entire app in one task.

# EXEC-05 — Menu Bar MVP

Read first:
- AGENTS.md
- ChromeWheelRouter/docs/development/node_reports/EXEC-04.md

Goal:
Turn the CLI spike into a minimal macOS menu bar app.

Tasks:
1. Add `ChromeWheelRouter.app` target.
2. Implement menu bar UI with:
   - Status
   - Enable / Disable
   - Dry Run
   - Open Logs
   - Quit
3. App should start disabled until permissions and user enablement are satisfied.
4. Reuse the routing/event-tap implementation from CLI.
5. Keep CLI target if useful for debugging.
6. Add `ChromeWheelRouter/docs/development/node_reports/EXEC-05.md`.

Hard constraints:
- No Start at Login in this node.
- No installer in this node.
- No new permissions beyond Accessibility/Input Monitoring.

Definition of done:
- App target builds on macOS CI.
- Disable means full pass-through.
- Quit disables event tap and exits.
- Next node is EXEC-06.

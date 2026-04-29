# EXEC-03 — macOS Event Tap CLI Spike

Read first:
- AGENTS.md
- SECURITY.md
- ChromeWheelRouter/docs/specs/*.md
- ChromeWheelRouter/docs/development/node_reports/EXEC-02.md

Goal:
Implement a CLI spike that can observe macOS scrollWheel events safely.

Tasks:
1. Add a CLI target, e.g. `ChromeWheelRouterCLI`.
2. Support modes:
   - `--listen-only`: observe and log classification, never swallow, never inject keys.
   - `--dry-run`: classify matches but never swallow, never inject keys.
   - `--active`: may swallow only matching Chrome + Option-only + horizontal scroll after EXEC-04.
3. Implement CGEventTap service with event mask containing only `scrollWheel`.
4. Convert CGEvent into ScrollEventModel.
5. For this node, do not inject Chrome zoom yet.
6. Return original event for all modes in this node.
7. Add `ChromeWheelRouter/docs/development/node_reports/EXEC-03.md`.

Hard constraints:
- Do not listen to keyDown/keyUp.
- Do not add network or telemetry.
- Callback must not do disk IO, network IO, shell, sleep, or blocking locks.
- No menu bar UI yet.

Definition of done:
- CLI builds.
- Static safety checks pass.
- Report explains local Mac manual command to verify listen-only mode.
- Next node is EXEC-04.

# EXEC-04 — Chrome Zoom Injection

Read first:
- AGENTS.md
- SECURITY.md
- node_reports/EXEC-03.md

Goal:
Implement real Chrome zoom behavior in the CLI spike.

Behavior:
- Chrome + Option-only + horizontal scroll right => send Command + = and swallow original scroll event.
- Chrome + Option-only + horizontal scroll left => send Command + - and swallow original scroll event.
- Everything else => return original event.

Tasks:
1. Implement KeyboardInjector for Command+= and Command+-.
2. Wire Router decisions into the CLI event tap.
3. Implement active mode.
4. Ensure listen-only and dry-run never swallow and never inject keys.
5. Add tests where possible and static checks for forbidden event types.
6. Add `node_reports/EXEC-04.md`.

Hard constraints:
- Only matching events may return nil.
- Non-matching events must return original event.
- No UI yet.

Definition of done:
- Build passes.
- Tests pass.
- Safety checks pass.
- Manual Mac QA steps are documented.
- Next node is EXEC-05.

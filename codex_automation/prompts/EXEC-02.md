# EXEC-02 — Routing Core Completion

Read first:
- AGENTS.md
- ai_context/*.md
- project_control/*.md
- node_reports/EXEC-01.md

Goal:
Complete the pure Swift routing core.

Core invariant:
Only Chrome + Option-only + horizontal scroll may be converted into zoom and swallowed.
Everything else must pass through.

Tasks:
1. Implement or refine pure Swift models:
   - ScrollEventModel
   - ModifierState
   - RouteDecision
   - Router
2. Add exhaustive unit tests for:
   - Chrome + Option-only + dx > 0 => zoomInAndSwallow
   - Chrome + Option-only + dx < 0 => zoomOutAndSwallow
   - Chrome + no modifier + horizontal => passThrough
   - Chrome + Cmd/Ctrl/Shift/Option+Cmd => passThrough
   - non-Chrome => passThrough
   - vertical-only => passThrough
   - disabled router => passThrough
3. Run all checks.
4. Add `node_reports/EXEC-02.md`.

Hard constraints:
- No macOS event tap code in this node.
- No keyboard injection code in this node.
- Pure logic only.

Definition of done:
- Tests prove the bare Chrome horizontal scroll pass-through invariant.
- Check suite passes.
- Next node is EXEC-03.

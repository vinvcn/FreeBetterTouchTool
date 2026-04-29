# EXEC-07 — Runtime Safety Controls

Read first:
- AGENTS.md
- SECURITY.md
- node_reports/EXEC-06.md

Goal:
Make the runtime safe to start, stop, kill, and recover.

Tasks:
1. Implement robust enable/disable semantics.
2. Disable event tap before quit.
3. Handle tapDisabledByTimeout and tapDisabledByUserInput safely.
4. Add optional kill switch file under user Application Support.
5. Add lightweight logs outside hot path.
6. Add `node_reports/EXEC-07.md`.

Hard constraints:
- No disk IO in the CGEventTap callback.
- No network.
- No shell commands in callback.
- No sleep or blocking locks in callback.

Definition of done:
- App can be disabled and quit cleanly.
- Static safety checks pass.
- Next node is EXEC-08.

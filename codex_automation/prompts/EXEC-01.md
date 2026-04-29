# EXEC-01 — Baseline Hardening

Read first:
- AGENTS.md
- ai_context/*.md
- project_control/*.md
- codex_automation/execution_queue.yml

Goal:
Harden the scaffold into a reliable engineering baseline.

Tasks:
1. Ensure `./scripts/check_all.sh` exists and runs all available checks.
2. Ensure static safety checks exist and fail on forbidden patterns:
   - keyDown / keyUp event taps
   - network APIs / telemetry
   - sudo, LaunchDaemons, privileged helpers, kernel/system extensions
   - modifications to Chrome or Logi Options+ config
3. Ensure `swift test` is wired into checks if Swift sources exist.
4. Ensure state harness and MVP flow harness are included in check_all if present.
5. Add or update `node_reports/EXEC-01.md` with exact commands run, results, risks, and next node.

Hard constraints:
- Do not implement CGEventTap yet.
- Do not add app UI yet.
- Do not expand product scope.

Definition of done:
- `./scripts/check_all.sh` passes locally in the cloud environment, or the report clearly explains unavailable checks.
- Node report exists.
- Next node is EXEC-02.

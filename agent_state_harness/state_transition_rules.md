# Agent State Transition Rules

Allowed states:

- project_defined
- execution_in_progress
- execution_ready_for_review
- acceptance_ready
- human_acceptance_in_progress
- human_accepted
- release_planning
- released

Rules:

- Codex may move an execution node to `execution_ready_for_review`.
- Codex may not move a build to `human_accepted`.
- Only the owner can set `human_accepted` after filling the human acceptance report.
- Any failed acceptance test moves state back to `execution_in_progress` with a defect reference.

# Project Memory

This directory stores durable project knowledge that should outlive any single chat session.

## Purpose

Use project memory to capture decisions, lessons, and execution summaries so future work does not depend on transient conversation history.

## Structure

- `decisions/` — architecture decision records (`ADR-*.md`).
- `lessons_learned/` — discovered bugs, safety edge cases, compatibility findings, and toolchain issues.
- `node_summaries/` — concise execution-node summaries (`EXEC-XX.md`).
- `local_validation/` — local validation artifacts and notes tied to execution work.

## Usage guidance

When task work creates new knowledge, update the relevant files in this tree and any related docs:

- `ChromeWheelRouter/docs/development/node_reports/EXEC-XX.md`
- `ChromeWheelRouter/docs/development/project_memory/node_summaries/EXEC-XX.md`
- `ChromeWheelRouter/docs/development/project_memory/lessons_learned/*.md`
- `ChromeWheelRouter/docs/development/project_memory/decisions/ADR-*.md`
- `ChromeWheelRouter/docs/product/TROUBLESHOOTING.md`

If a bug, toolchain issue, compatibility issue, or safety edge case is discovered, record it in `lessons_learned/`. If a durable architectural decision is made, record it as an ADR in `decisions/`.

# ADR-005: AGENTS.md Uses Progressive Disclosure

Date: 2026-04-30

## Status

Accepted

## Context

`AGENTS.md` had become a large mixed manual containing scope, safety rules, architecture, tests, PR expectations, manual QA, repository organization, and project memory guidance. That made it expensive for agents to read and increased the chance of duplicated or stale source-of-truth language.

## Decision

Keep `AGENTS.md` as a concise navigation map. Detailed rules live in focused documents:

- scope in `ChromeWheelRouter/docs/specs/scope.md`
- safety in `ChromeWheelRouter/docs/specs/safety_constraints.md`
- event-tap callback rules in `ChromeWheelRouter/docs/specs/hot_path_rules.md`
- source boundaries in `ChromeWheelRouter/docs/specs/architecture.md`
- test contract in `ChromeWheelRouter/docs/specs/acceptance_criteria.md`
- project memory guidance in `ChromeWheelRouter/docs/development/project_memory/README.md`

## Consequences

- Future agents should start from `AGENTS.md` and follow the read order for task-specific detail.
- Scope changes must update the canonical scope document instead of adding parallel language elsewhere.
- Compatibility pointer files may exist, but they should not contain new policy text.

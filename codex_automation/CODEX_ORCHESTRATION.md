# Codex Orchestration

## Preferred operating mode

Use one Codex Cloud task per execution node.

Why:

- Dependencies remain clear.
- Scope drift is easier to catch.
- CI evidence maps to a single node.
- Owner intervention is reduced to gate approval.

## Submission options

### Option A: Codex Web

Open the repo in Codex Cloud and paste the prompt file for the node, e.g.:

```text
codex_automation/prompts/EXEC-01.md
```

### Option B: Codex CLI

Install and authenticate Codex CLI, then:

```bash
export CODEX_ENV_ID=<env-id>
./scripts/submit_codex_node.sh EXEC-01
```

The Codex CLI supports cloud task submission through `codex cloud exec`; this script wraps that command.

## PR handling

Each Codex PR must include:

- A node report under `ChromeWheelRouter/docs/development/node_reports/`.
- Test evidence.
- Safety evidence.
- Next node recommendation.

Owner should not manually fix node code. If a node fails, ask Codex to fix its own PR.

## When to interrupt Codex

Interrupt only when:

- Scope expands beyond Chrome Option-horizontal-scroll zoom.
- Safety constraints are violated.
- CI is failing after Codex attempts to fix.
- Codex claims local hardware acceptance.
- The implementation tries to bypass macOS privacy permissions.

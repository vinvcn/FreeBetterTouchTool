# ChromeWheelRouter

A small macOS utility project scaffold for building a safe Chrome-only mouse event router.

## MVP behavior

When Google Chrome is frontmost:

- `Option + horizontal scroll` => Chrome page zoom
- `Control + horizontal scroll` => Chrome tab switching
- bare horizontal scroll => pass through untouched, so Logi Options+ can keep handling it
- everything outside the exact gesture rules => pass through untouched

This repo is intentionally scoped. It is **not** a BetterTouchTool clone.

## Safety stance

The first implementation must be fail-open and narrowly scoped:

- only listen to `scrollWheel`
- do not listen to keyboard events
- do not record input
- do not read Chrome profile data
- do not read Logi Options+ data
- do not use network APIs
- do not require root
- do not install drivers, daemons, kernel extensions, or privileged helpers

See [`AGENTS.md`](AGENTS.md) and [`ChromeWheelRouter/docs/specs/safety_constraints.md`](ChromeWheelRouter/docs/specs/safety_constraints.md).

## Repository bootstrap

```bash
git init
git add .
git commit -m "Initial Codex Cloud scaffold"
```

Create and push a GitHub repo using GitHub CLI:

```bash
gh auth login
gh repo create ChromeWheelRouter --private --source=. --remote=origin --push
```

Then open Codex Web / Codex Cloud and select this GitHub repo.

## What this scaffold contains

```text
ChromeWheelRouter/docs/    Feature-specific product, specs, QA, acceptance, and development docs
AGENTS.md                  Hard instructions for Codex agents
agent_state_harness/       Project-level agent state schema, state file, and validation script
project_control/           Project-level execution policy and gates
Sources/                   Swift implementation
Tests/                     Swift tests
scripts/                   Local bootstrap and validation scripts
.github/workflows/         CI and packaging workflows
```

See [`ChromeWheelRouter/docs/README.md`](ChromeWheelRouter/docs/README.md) for the feature documentation layout.

## Local checks

```bash
./scripts/check_all.sh
```

## Current status

Current decision: **do it**.

Next action: use Codex Cloud to turn this scaffold into a menu bar app + DMG installer + usage docs.

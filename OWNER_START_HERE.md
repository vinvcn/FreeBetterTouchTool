# ChromeWheelRouter — Owner Start Here

This is the combined project package for ChromeWheelRouter.

It includes:

1. The project definition scaffold: `ai_context/`, `AGENTS.md`, `agent_state_harness/`, `mvp_user_flow_harness/`.
2. The engineering execution flow: `project_control/`, `codex_tasks/`, `gate_checklists/`, `templates/`.
3. The minimum-human-intervention control layer: `codex_automation/`, `owner_control/`, `acceptance/`, `.codex/`, `.github/`.

## Recommended owner flow

### 1. Validate the package locally

```bash
./scripts/check_all.sh
```

This validates the current state harness, MVP flow harness, static safety checks, and the no-XCTest Swift core routing harness on macOS. SwiftPM/XCTest tests are opt-in locally and run in CI.

### 2. Create the GitHub repo

```bash
git init
git add .
git commit -m "chore: initialize ChromeWheelRouter project"

gh auth login
./scripts/bootstrap_github.sh ChromeWheelRouter private
```

### 3. Connect the repo to Codex Cloud

Read:

```text
scripts/import_to_codex_cloud.md
owner_control/OWNER_QUICKSTART.md
codex_automation/CODEX_ORCHESTRATION.md
```

### 4. Create execution issues

```bash
./scripts/create_autopilot_issues.sh
```

### 5. Submit one node at a time

```bash
./scripts/submit_codex_node.sh EXEC-01
```

After the PR is green and satisfies the gate, merge it, then:

```bash
./scripts/mark_node_done.sh EXEC-01
./scripts/submit_next_codex_node.sh
```

### 6. Human acceptance is mandatory

Codex can build and test the project, but it cannot verify your physical MX Master + Logi Options+ + Chrome setup.

Use:

```text
acceptance/LOCAL_ACCEPTANCE_RUNBOOK.md
acceptance/HUMAN_ACCEPTANCE_REPORT.md
```

A release candidate is not accepted until you install it on your Mac and confirm:

```text
Human accepted on my Mac: YES
```

## Non-negotiable MVP invariant

Chrome naked horizontal scroll must remain pass-through so Logi Options+ can keep handling it.

Only this case may be swallowed:

```text
Chrome + Option-only + horizontal scroll
```


## Local XCTest behavior

`./scripts/check_all.sh` intentionally avoids requiring XCTest locally because some Swift toolchains do not ship or expose the XCTest module. It still runs the Python harnesses, static safety checks, and a no-XCTest Swift core routing harness on macOS.

To run the full SwiftPM/XCTest suite on a complete Xcode / Command Line Tools setup, use:

```bash
CWR_RUN_XCTEST=1 ./scripts/check_all.sh
```

CI runs this full mode on macOS.

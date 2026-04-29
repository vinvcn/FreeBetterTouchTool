# Task Backlog

## Milestone 0: Scaffold

- [x] Create AGENTS.md.
- [x] Create ai_context.
- [x] Create agent_state_harness.
- [x] Create mvp_user_flow_harness.
- [x] Create pure Swift routing core.
- [x] Add starter CI.

## Milestone 1: Core correctness

- [ ] Review and harden Router tests.
- [ ] Add static safety checks for forbidden APIs.
- [ ] Add test coverage report command if useful.

## Milestone 2: macOS event adapter

- [ ] Add `CGEventTapService` listening only to scrollWheel.
- [ ] Add `ForegroundAppProvider`.
- [ ] Add `KeyboardInjector` for `Command + =` and `Command + -`.
- [ ] Add dry-run mode.
- [ ] Add verbose diagnostic logging outside hot path.

## Milestone 3: Menu bar app

- [ ] Create menu bar shell.
- [ ] Add Enable / Disable.
- [ ] Add permission status.
- [ ] Add Open Logs.
- [ ] Add Quit.

## Milestone 4: Installable artifact

- [ ] Add DMG packaging.
- [ ] Add dev install / uninstall scripts.
- [ ] Add user guide.
- [ ] Add troubleshooting guide.
- [ ] Add release workflow.

## Milestone 5: Local QA

- [ ] Verify Chrome bare horizontal scroll remains Logi-controlled.
- [ ] Verify Chrome Option + horizontal scroll zooms.
- [ ] Verify non-Chrome apps unaffected.
- [ ] Verify Disable and Quit restore default behavior.

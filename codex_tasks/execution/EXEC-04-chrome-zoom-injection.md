# EXEC-04 — Chrome Zoom Injection

## Codex Cloud prompt

Task:

Add the minimal keyboard injection needed for Chrome zoom.

Required behavior in active mode:

- `zoomInAndSwallow` -> send `Command + =`
- `zoomOutAndSwallow` -> send `Command + -`
- return `nil` only for these matched events
- return original event for all pass-through decisions

Required constraints:

- Injection must only support these two shortcuts.
- Do not build a generic shortcut engine.
- Do not listen to keyboard events.
- Do not modify Chrome settings.
- Do not modify Logi Options+ settings.
- Do not add support for tab switching; Logi Options+ owns bare horizontal scroll.

Required local QA doc:

Add `Docs/LOCAL_QA_EXEC_04.md` with:

- How to run active CLI.
- How to verify Chrome Option + horizontal wheel zooms.
- How to verify bare horizontal wheel still follows Logi Options+ behavior.
- How to stop the CLI.
- How to recover if behavior seems wrong.

Deliverables:

- `KeyboardInjector` or equivalent minimal module.
- Tests for decision-to-action mapping where possible.
- Updated static checks.
- `node_reports/EXEC-04.md`.
- Updated agent state.

Acceptance:

- Automated checks pass.
- Human local QA confirms:
  - Option + horizontal wheel zooms Chrome.
  - Bare horizontal wheel still goes to Logi Options+.
  - Non-Chrome is unaffected.

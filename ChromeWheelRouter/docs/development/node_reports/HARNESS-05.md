# HARNESS-05 Node Report

## Machine-readable evidence

```json node-report
{
  "node_id": "HARNESS-05",
  "task_source": "GitHub issue #32: HARNESS-05 Add machine-checkable node report schema and PR evidence gate",
  "changed_files": [
    ".github/pull_request_template.md",
    ".github/workflows/autopilot-gate.yml",
    "ChromeWheelRouter/docs/development/node_reports/HARNESS-05.md",
    "ChromeWheelRouter/docs/development/project_memory/node_summaries/HARNESS-05.md",
    "harness/quality_gates.yml",
    "project_control/autopilot_gate_policy.md",
    "project_control/go_no_go_policy.md",
    "scripts/check_harness_consistency.py",
    "scripts/check_node_report.py",
    "templates/node_report.md",
    "templates/node_report.schema.json"
  ],
  "commands_run": [
    {
      "command": "python3 scripts/run_gate.py fast",
      "result": "passed",
      "summary": "Fast gate passed, including static safety, core routing smoke tests, router fixtures, Swift boundary checks, hot-path safety, node report validation, and harness consistency."
    },
    {
      "command": "./scripts/check_all.sh",
      "result": "blocked after fast gate by local XCTest availability",
      "summary": "Fast gate passed, then local SwiftPM test build failed with `no such module 'XCTest'` in this Command Line Tools environment."
    }
  ],
  "safety_invariants_checked": [
    {
      "invariant": "no_key_down_key_up_listeners",
      "checked": true,
      "summary": "Harness-only change; no event tap mask or keyboard event listener code changed."
    },
    {
      "invariant": "no_network_or_telemetry",
      "checked": true,
      "summary": "No app networking or telemetry was added."
    },
    {
      "invariant": "no_chrome_or_logi_config_access",
      "checked": true,
      "summary": "No Chrome profile, Chrome settings, or Logi Options+ files are read or modified."
    },
    {
      "invariant": "no_root_privileged_helper_or_system_daemon",
      "checked": true,
      "summary": "No install, daemon, helper, root, kernel, or system extension behavior changed."
    },
    {
      "invariant": "unmatched_events_pass_through",
      "checked": true,
      "summary": "No router or runtime event handling code changed."
    }
  ],
  "scope_change": {
    "changed": false,
    "summary": "No product scope change; this adds PR evidence validation for harness quality gates."
  },
  "manual_validation_required": {
    "required": false,
    "summary": "No runtime, packaging, install, or product behavior changed."
  },
  "artifacts": [
    "templates/node_report.schema.json",
    "scripts/check_node_report.py",
    "ChromeWheelRouter/docs/development/node_reports/HARNESS-05.md"
  ],
  "known_risks": [
    "Legacy node reports remain readable but are not retroactively converted; CI validates changed structured reports."
  ],
  "next_node": "HARNESS-06",
  "state_updates": {
    "current_state_json_changed": false,
    "summary": "No change to agent_state_harness/current_state.json."
  }
}
```

## Summary

HARNESS-05 adds a structured evidence contract for new node reports. The PR gate
now validates changed node reports with `scripts/check_node_report.py` instead of
only checking that a report file exists.

## Validation Notes

Additional validation:

- `env PYTHONPYCACHEPREFIX=/private/tmp/cwr_pycache python3 -m py_compile scripts/check_node_report.py scripts/check_harness_consistency.py`: passed.
- `python3 -S scripts/check_node_report.py --all`: passed.
- `python3 -S scripts/check_node_report.py --base origin/main --head HEAD`: intentionally failed before commit because there was no committed PR diff yet; rerun after commit.
- `swift build -c release`: passed.

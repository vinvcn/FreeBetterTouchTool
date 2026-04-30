# Node Report: <NODE-ID>

## Machine-readable evidence

```json node-report
{
  "node_id": "<NODE-ID>",
  "task_source": "<GitHub issue, execution prompt, or owner request>",
  "changed_files": [
    "<path>"
  ],
  "commands_run": [
    {
      "command": "python3 scripts/run_gate.py fast",
      "result": "<passed | failed | blocked with reason>",
      "summary": "<short result summary>"
    },
    {
      "command": "./scripts/check_all.sh",
      "result": "<passed | failed | blocked with reason>",
      "summary": "<short result summary>"
    }
  ],
  "safety_invariants_checked": [
    {
      "invariant": "no_key_down_key_up_listeners",
      "checked": true,
      "summary": "<evidence>"
    },
    {
      "invariant": "no_network_or_telemetry",
      "checked": true,
      "summary": "<evidence>"
    },
    {
      "invariant": "no_chrome_or_logi_config_access",
      "checked": true,
      "summary": "<evidence>"
    },
    {
      "invariant": "no_root_privileged_helper_or_system_daemon",
      "checked": true,
      "summary": "<evidence>"
    },
    {
      "invariant": "unmatched_events_pass_through",
      "checked": true,
      "summary": "<evidence>"
    }
  ],
  "scope_change": {
    "changed": false,
    "summary": "<scope statement>"
  },
  "manual_validation_required": {
    "required": false,
    "summary": "<manual validation statement>"
  },
  "artifacts": [
    "<path>"
  ],
  "known_risks": [],
  "next_node": "<NEXT-NODE>",
  "state_updates": {
    "current_state_json_changed": false,
    "summary": "<state update statement>"
  }
}
```

## Node

- ID:
- Title:
- PR:
- Branch:
- Commit:

## Scope executed

What was implemented:

-

What was intentionally not implemented:

-

## Safety constraints checked

- [ ] No keyDown/keyUp event tap
- [ ] Event mask only includes scrollWheel where applicable
- [ ] No networking / telemetry
- [ ] No Chrome profile reads
- [ ] No Logi Options+ config reads/writes
- [ ] No system daemon / root install
- [ ] Non-matching events pass through

## Automated checks

```text
swift test:
scripts/check_static_safety.sh:
scripts/check_all.sh:
```

## Human verification required

-

## Known risks / limitations

-

## Next recommended node

-

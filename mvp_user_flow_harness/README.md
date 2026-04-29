# MVP User Flow Harness

Purpose: keep the MVP anchored in real user behavior instead of feature creep.

The MVP is not done until the user can install, enable, use, disable, quit, and uninstall the tool without breaking Logi Options+ or Chrome.

## Structure

```text
scenarios.json                  Machine-readable scenarios
flows/*.md                      Human-readable flow specs
scripts/check_user_flows.py      Lightweight consistency checks
```

## Validate

```bash
python3 mvp_user_flow_harness/scripts/check_user_flows.py
```

#!/usr/bin/env python3
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
SCENARIOS = ROOT / "mvp_user_flow_harness" / "scenarios.json"
REQUIRED_IDS = {"FLOW-001", "FLOW-002", "FLOW-003", "FLOW-004", "FLOW-005", "FLOW-006"}


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    sys.exit(1)


def main() -> None:
    if not SCENARIOS.exists():
        fail("missing scenarios.json")

    data = json.loads(SCENARIOS.read_text())
    scenarios = data.get("scenarios", [])
    ids = {item.get("id") for item in scenarios}

    missing = REQUIRED_IDS - ids
    if missing:
        fail("missing scenarios: " + ", ".join(sorted(missing)))

    for scenario in scenarios:
        for key in ["id", "name", "type", "preconditions", "steps", "expected"]:
            if key not in scenario:
                fail(f"scenario {scenario.get('id')} missing key: {key}")
        if scenario["type"] != "manual":
            fail(f"scenario {scenario['id']} must be manual for MVP hardware validation")
        if not scenario["steps"]:
            fail(f"scenario {scenario['id']} has no steps")
        if not scenario["expected"]:
            fail(f"scenario {scenario['id']} has no expected outcomes")

    print("mvp_user_flow_harness: OK")


if __name__ == "__main__":
    main()

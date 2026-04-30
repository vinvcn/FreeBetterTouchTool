#!/usr/bin/env python3
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
STATE_PATH = ROOT / "agent_state_harness" / "current_state.json"
SCHEMA_PATH = ROOT / "agent_state_harness" / "state_schema.json"

REQUIRED_TOP_LEVEL = [
    "project",
    "current_decision",
    "scope",
    "open_questions",
    "next_action",
    "definition_of_done",
    "safety_invariants",
    "backlog",
    "manual_validation_required",
]

REQUIRED_SAFETY = [
    "event tap listens only to scrollWheel",
    "no keyDown/keyUp event taps",
    "no telemetry",
    "no network APIs",
    "no root install",
    "unmatched events must return the original event",
    "only Chrome + Option-only + horizontal scroll or Chrome + Control-only + horizontal scroll may be swallowed",
]


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    sys.exit(1)


def main() -> None:
    if not STATE_PATH.exists():
        fail(f"missing {STATE_PATH}")
    if not SCHEMA_PATH.exists():
        fail(f"missing {SCHEMA_PATH}")

    state = json.loads(STATE_PATH.read_text())

    for key in REQUIRED_TOP_LEVEL:
        if key not in state:
            fail(f"state missing top-level key: {key}")

    scope = state.get("scope", {})
    if "in_scope" not in scope or "out_of_scope" not in scope:
        fail("scope must include in_scope and out_of_scope")

    safety = state.get("safety_invariants", [])
    missing = [item for item in REQUIRED_SAFETY if item not in safety]
    if missing:
        fail("missing required safety invariants: " + ", ".join(missing))

    backlog = state.get("backlog", [])
    ids = [item.get("id") for item in backlog]
    if len(ids) != len(set(ids)):
        fail("backlog IDs must be unique")

    print("agent_state_harness: OK")


if __name__ == "__main__":
    main()

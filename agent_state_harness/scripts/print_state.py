#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
state = json.loads((ROOT / "agent_state_harness" / "current_state.json").read_text())

print(f"Project: {state['project']}")
print(f"Decision: {state['current_decision']}")
print(f"Next action: {state['next_action']}")
print("\nOpen questions:")
for item in state["open_questions"]:
    print(f"- {item}")
print("\nBacklog:")
for item in state["backlog"]:
    print(f"- [{item['status']}] {item['id']}: {item['title']}")

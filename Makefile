.PHONY: test validate harness build all

all: test validate harness

test:
	swift test

validate:
	python3 agent_state_harness/scripts/state_harness.py validate

harness:
	python3 mvp_user_flow_harness/scripts/run_mvp_user_flow_harness.py

build:
	swift build -c release

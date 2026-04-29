# Engineering Execution Model

This project is controlled by nodes, not by ad hoc tasks.

## Node roles

- Project definition: human/product owner defines what will be built.
- Execution: Codex implements each node in small PRs.
- Acceptance: human owner installs the RC build on the real Mac and confirms it works.
- Release: public/private distribution plan after human acceptance.

## Owner control

The owner controls:

- node order
- merge / reject decisions
- human acceptance
- release decisions

Codex controls:

- code changes inside node scope
- test updates
- docs updates
- node report generation

Codex must not claim human acceptance. Only the owner can mark a build accepted on the real Mac.

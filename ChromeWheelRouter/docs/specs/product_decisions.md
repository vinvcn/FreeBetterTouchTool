# Product Decisions

## Decision 1: Do the project

Status: accepted.

Reason: the behavior is narrow enough to implement safely and test meaningfully.

## Decision 2: Chrome only

Status: accepted.

Reason: reducing app scope keeps the event router safe and auditable.

## Decision 3: Preserve Logi Options+ bare horizontal behavior

Status: accepted.

The tool must not intercept bare horizontal scroll. It must return the original event for no-modifier horizontal scroll.

## Decision 4: Use fail-open routing

Status: accepted.

When uncertain, pass the event through.

## Decision 5: Codex Cloud is for engineering, not final hardware validation

Status: accepted.

Codex Cloud can write code, tests, docs, and packaging scripts. It cannot validate real MX Master hardware, Logi Options+ event ordering, or macOS privacy permissions on the user's machine.

## Decision 6: First product should be a menu bar app

Status: accepted for final implementation.

The repo scaffold starts with a pure Swift core so Codex can safely build upward.

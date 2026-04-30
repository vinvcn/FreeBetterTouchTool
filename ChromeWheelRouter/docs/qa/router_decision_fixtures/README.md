# Router Decision Fixtures

This directory contains human-readable scenarios for pure router behavior. The
fixtures are an approved-scenarios layer: reviewers should be able to understand
behavior changes by reading `scenarios.json`.

Run:

```bash
./scripts/check_router_fixtures.sh
```

The check compiles the pure `ChromeWheelRouterCore` sources with the fixture
runner in `scripts/check_router_fixtures.swift`, decodes `scenarios.json`, and
asserts each expected decision against `Router.decide`.

## Adding Scenarios

Add a scenario when router behavior changes or a safety invariant needs a
reviewable example. Keep each `id` stable and unique, and append new IDs rather
than reusing old ones.

Supported modifier names are:

- `command`
- `option`
- `control`
- `shift`

Supported decision names are:

- `passThrough`
- `zoomInAndSwallow`
- `zoomOutAndSwallow`
- `nextTabAndSwallow`
- `previousTabAndSwallow`

Fixtures must stay aligned with the HARNESS-00 scope decision:

- Chrome + Option-only + horizontal scroll may zoom and swallow.
- Chrome + Control-only + horizontal scroll may switch tabs and swallow.
- Bare horizontal scroll, non-Chrome events, mixed modifiers, disabled state,
  vertical-only scroll, and diagonal scroll must pass through.

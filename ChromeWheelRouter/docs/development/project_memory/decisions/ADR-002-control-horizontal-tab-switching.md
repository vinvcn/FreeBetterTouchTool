# ADR-002: Control Horizontal Scroll Tab Switching

Date: 2026-04-29

## Status

Accepted

## Context

The original routing contract only swallowed Chrome + Option-only + horizontal scroll for page zoom. The tab-switch release task expands the product contract with one additional Chrome-only gesture: Control-only + horizontal scroll.

## Decision

ChromeWheelRouter now treats exact modifier intent as the routing boundary:

- Chrome + Option-only + horizontal scroll routes to page zoom.
- Chrome + Control-only + horizontal scroll routes to tab switching.
- Mixed modifiers such as Option+Control, Option+Command, Command, and Shift pass through.
- Bare horizontal scroll still passes through so existing Logi Options+ behavior remains available.

The tab-switch shortcuts use Chrome's standard macOS bindings:

- Next tab: Control + Tab.
- Previous tab: Control + Shift + Tab.

## Consequences

The safety contract now allows two swallowed gesture families instead of one. The event tap remains scrollWheel-only, and keyboard events are injected only after a matched scroll decision.

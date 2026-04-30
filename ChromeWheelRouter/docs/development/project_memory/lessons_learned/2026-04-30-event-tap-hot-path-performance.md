# 2026-04-30 - Event tap hot path performance

## Context

User testing observed visible pointer latency while ChromeWheelRouter was running, especially when moving the pointer between displays. Review found two long-running performance hazards:

- status polling recreated the global scroll event tap every second while enabled
- every scroll event was logged from inside the event tap callback, which routed to synchronous disk IO in the app

## Lesson

The scroll event tap callback must stay allocation-light and free of logging, disk IO, process/workspace polling, shelling out, sleeps, and blocking waits. Long-running status polling must be idempotent and must not churn event taps unless the desired running state or mode changed.

Pointer latency can surface even though the tap only subscribes to `scrollWheel`, because repeatedly disturbing global event tap plumbing or blocking the callback can create broader input-system pressure.

## Follow-up

Keep static checks in place for hot-path logging/IO in `CGEventTapService`.

Manual QA should include:

- enable the app and leave it running for several minutes
- move the pointer rapidly between displays
- perform burst horizontal and vertical wheel input
- confirm the pointer remains responsive and scroll routing still follows the MVP contract

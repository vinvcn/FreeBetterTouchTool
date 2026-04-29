# Human Acceptance Report

Build:
DMG:
SHA256:
Mac model:
macOS version:
Chrome version:
Logi Options+ version:
Mouse:
Date:

## Results

| Test | Result | Notes |
|---|---|---|
| A1 Install | PASS / FAIL | |
| A2 Permissions | PASS / FAIL | |
| A3 Logi pass-through invariant | PASS / FAIL | |
| A4 Chrome zoom behavior | PASS / FAIL | |
| A5 Non-Chrome pass-through | PASS / FAIL | |
| A6 Disable / Quit | PASS / FAIL | |
| A7 Uninstall | PASS / FAIL | |

## Human decision

- [ ] Accepted for my Mac
- [ ] Rejected, defect loop required

## Defects


## Detailed routing safety matrix

Reported by owner on 2026-04-29: all required routing safety cases passed on real local macOS usage.

| # | Scenario | Result |
|---|---|---|
| 1 | Non-Chrome + Option + horizontal scroll => pass-through | PASS |
| 2 | Chrome + vertical scroll => pass-through | PASS |
| 3 | Chrome + horizontal scroll + no modifier => pass-through | PASS |
| 4 | Chrome + horizontal scroll + Command => pass-through | PASS |
| 5 | Chrome + horizontal scroll + Shift => pass-through | PASS |
| 6 | Chrome + horizontal scroll + Control => pass-through | PASS |
| 7 | Chrome + horizontal scroll + Option+Command => pass-through | PASS |
| 8 | Chrome + horizontal scroll + Option-only + positive dx => zoom-in and swallow | PASS |
| 9 | Chrome + horizontal scroll + Option-only + negative dx => zoom-out and swallow | PASS |
| 10 | Disable router => pass-through | PASS |

## Signoff

I confirm this build was installed and tested on my own Mac with my real MX Master + Logi Options+ + Chrome setup.

Owner:
Date:

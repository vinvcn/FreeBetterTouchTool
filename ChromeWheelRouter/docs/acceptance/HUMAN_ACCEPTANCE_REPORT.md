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
| A5 Chrome tab-switch behavior | PASS / FAIL | |
| A6 Ambiguous modifier pass-through | PASS / FAIL | |
| A7 Non-Chrome pass-through | PASS / FAIL | |
| A8 Disable / Quit | PASS / FAIL | |
| A9 Uninstall | PASS / FAIL | |

## Human decision

- [ ] Accepted for my Mac
- [ ] Rejected, defect loop required

## Defects


## Detailed routing safety matrix

Reported by owner on 2026-04-29: the pre-tab-switch routing safety cases passed on real local macOS usage. Re-run this matrix for release candidates that include Control-only tab switching.

| # | Scenario | Result |
|---|---|---|
| 1 | Non-Chrome + Option + horizontal scroll => pass-through | PASS / FAIL |
| 2 | Chrome + vertical scroll => pass-through | PASS / FAIL |
| 3 | Chrome + horizontal scroll + no modifier => pass-through | PASS / FAIL |
| 4 | Chrome + horizontal scroll + Command => pass-through | PASS / FAIL |
| 5 | Chrome + horizontal scroll + Shift => pass-through | PASS / FAIL |
| 6 | Chrome + horizontal scroll + Control-only + positive dx => next tab and swallow | PASS / FAIL |
| 7 | Chrome + horizontal scroll + Control-only + negative dx => previous tab and swallow | PASS / FAIL |
| 8 | Chrome + horizontal scroll + Option+Command => pass-through | PASS / FAIL |
| 9 | Chrome + horizontal scroll + Option+Control => pass-through | PASS / FAIL |
| 10 | Chrome + horizontal scroll + Option-only + positive dx => zoom-in and swallow | PASS / FAIL |
| 11 | Chrome + horizontal scroll + Option-only + negative dx => zoom-out and swallow | PASS / FAIL |
| 12 | Disable router => pass-through | PASS / FAIL |

## Signoff

I confirm this build was installed and tested on my own Mac with my real MX Master + Logi Options+ + Chrome setup.

Owner:
Date:

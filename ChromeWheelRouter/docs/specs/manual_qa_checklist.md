# Manual QA Checklist

Use this on a real Mac before release.

## Baseline

- [ ] Quit ChromeWheelRouter.
- [ ] Open Chrome.
- [ ] Confirm Logi Options+ bare horizontal scroll behavior works as expected.

## Active behavior

- [ ] Start ChromeWheelRouter.
- [ ] Enable it.
- [ ] Confirm permissions are granted.
- [ ] Chrome + bare horizontal scroll still uses Logi Options+ behavior.
- [ ] Chrome + Option + horizontal scroll right zooms in.
- [ ] Chrome + Option + horizontal scroll left zooms out.
- [ ] Chrome + Control + horizontal scroll right switches to the next tab.
- [ ] Chrome + Control + horizontal scroll left switches to the previous tab.
- [ ] Chrome + Option + Control + horizontal scroll passes through.
- [ ] Chrome + Command + horizontal scroll does not trigger this app.
- [ ] Chrome + Shift + horizontal scroll does not trigger this app.
- [ ] Finder + Option + horizontal scroll does not zoom.
- [ ] Terminal + Option + horizontal scroll does not zoom.

## Disable / quit

- [ ] Disable from menu bar.
- [ ] Confirm all scroll behavior returns to baseline.
- [ ] Quit from menu bar.
- [ ] Confirm process is not running.
- [ ] Confirm all scroll behavior remains baseline.

## Uninstall

- [ ] Run uninstall script or delete app per docs.
- [ ] Remove config and logs.
- [ ] Revoke macOS permissions manually.
- [ ] Confirm no background process remains.

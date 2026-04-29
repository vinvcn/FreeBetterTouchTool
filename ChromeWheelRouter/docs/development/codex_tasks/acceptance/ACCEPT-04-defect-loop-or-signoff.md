# ACCEPT-04 — Defect Loop or Acceptance Signoff

## If QA fails

Create a defect issue with:

- RC version
- git commit
- macOS version
- Chrome version
- Logi Options+ version
- MX Master model
- exact failing test case
- expected behavior
- actual behavior
- logs if available
- screenshot/screen recording if useful

Route defect:

```text
Routing logic problem       -> EXEC-02
Event tap behavior problem  -> EXEC-03 / EXEC-04
Menu state problem          -> EXEC-05
Permission problem          -> EXEC-06
Runtime stop/restore issue  -> EXEC-07
Install/uninstall issue     -> EXEC-08
DMG/doc issue               -> EXEC-09
```

Codex fixes defect in a focused PR.

Then rebuild RC and repeat ACCEPT-01 through ACCEPT-03.

## If QA passes

Owner creates acceptance commit or tag:

```bash
git tag v0.1.0-rc1-human-accepted
git push origin v0.1.0-rc1-human-accepted
```

Update agent state:

```json
{
  "acceptance_status": "human_accepted",
  "human_accepted_version": "v0.1.0-rc1",
  "release_next_action": "start release planning"
}
```

Then enter Release Planning.

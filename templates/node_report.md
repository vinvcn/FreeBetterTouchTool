# Node Report: <NODE-ID>

## Node

- ID:
- Title:
- PR:
- Branch:
- Commit:

## Scope executed

What was implemented:

-

What was intentionally not implemented:

-

## Safety constraints checked

- [ ] No keyDown/keyUp event tap
- [ ] Event mask only includes scrollWheel where applicable
- [ ] No networking / telemetry
- [ ] No Chrome profile reads
- [ ] No Logi Options+ config reads/writes
- [ ] No system daemon / root install
- [ ] Non-matching events pass through

## Automated checks

```text
swift test:
scripts/check_static_safety.sh:
scripts/check_all.sh:
```

## Human verification required

-

## Known risks / limitations

-

## Next recommended node

-

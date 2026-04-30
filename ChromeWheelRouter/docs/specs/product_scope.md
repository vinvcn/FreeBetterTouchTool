# Product Scope

## In scope

1. Pure Swift routing core.
2. macOS event tap adapter in a later PR.
3. Chrome-only zoom mapping for Option-only horizontal scroll.
4. Chrome-only tab switching for Control-only horizontal scroll.
5. Menu bar control surface.
6. User-level installation.
7. Clean uninstall instructions.
8. Safety-focused documentation.
9. GitHub Actions CI.
10. DMG packaging.

## Out of scope

1. Wuying / cloud desktop support.
2. System-wide mouse remapping.
3. Keyboard event monitoring.
4. Reading user content.
5. Reading Chrome profile files.
6. Reading or writing Logi Options+ configuration.
7. Any network feature.
8. Any telemetry.
9. Any root installation.
10. Any kernel extension or driver.

## Feature gate principle

If a requested feature requires broader event interception or new permissions, it must be explicitly recorded as a product decision before implementation.

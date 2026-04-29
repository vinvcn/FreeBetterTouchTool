# Minimal Human Intervention Matrix

## Things the owner must do

1. Create/connect the GitHub repository.
2. Connect the repository to Codex Cloud.
3. Provide Apple Developer signing credentials only if signed/notarized release is required.
4. Trigger execution nodes, or run the provided submit script.
5. Perform final local acceptance on the actual Mac with MX Master + Logi Options+ + Chrome.

## Things Codex should do

1. Read project definition and safety constraints.
2. Implement each engineering node.
3. Run tests and static safety checks.
4. Create/update node reports.
5. Update state harness.
6. Open PRs.
7. Respond to CI failures.
8. Prepare RC package and documentation.

## Things automation should do

1. Run unit tests.
2. Run static safety checks.
3. Validate state harness.
4. Validate MVP user flow harness.
5. Build release artifact.
6. Attach artifact to release candidate workflow.

## Things nobody should automate in MVP

1. Bypassing macOS Input Monitoring / Accessibility prompts.
2. Modifying Logi Options+ configuration.
3. Modifying Chrome profile/settings.
4. Installing privileged helpers.
5. Enabling system-level launch daemons.
6. Performing final hardware acceptance without the owner.

# Owner Quickstart: Minimal Human Intervention

## One-time setup

1. Merge this pack into the ChromeWheelRouter repository.
2. Push to GitHub.
3. Connect the repository to Codex Cloud.
4. Install Codex CLI locally if you want command-line task submission:

```bash
npm i -g @openai/codex
# or
brew install codex
codex
```

5. Find or create the Codex Cloud environment for this repo.
6. Export the environment id:

```bash
export CODEX_ENV_ID=<your-codex-cloud-env-id>
```

7. Create GitHub issues:

```bash
./scripts/create_autopilot_issues.sh
```

## Start execution

```bash
./scripts/submit_codex_node.sh EXEC-01
```

When Codex opens a PR:

1. Wait for CI.
2. Confirm the PR includes `node_reports/EXEC-01.md`.
3. Merge if green.
4. Mark node done:

```bash
./scripts/mark_node_done.sh EXEC-01
```

5. Start next node:

```bash
./scripts/submit_next_codex_node.sh
```

## Your expected workload

During EXEC:

- Start node.
- Merge green PRs.
- Intervene only if CI/gate fails repeatedly or scope drifts.

During ACCEPT:

- Install RC DMG on your Mac.
- Grant macOS permissions manually.
- Test with MX Master + Logi Options+ + Chrome.
- Fill out acceptance report.

## Do not skip

The final human acceptance test cannot be delegated to Codex Cloud. Codex Cloud does not run on your physical Mac and cannot observe your real Logi Options+ event chain.

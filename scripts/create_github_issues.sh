#!/usr/bin/env bash
set -euo pipefail

# Create GitHub issues for the engineering nodes using gh CLI.
# Run from repo root after pushing repository to GitHub.

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required" >&2
  exit 1
fi

create_issue() {
  local title="$1"
  local body_file="$2"
  local label="$3"

  if [[ ! -f "$body_file" ]]; then
    echo "Missing body file: $body_file" >&2
    exit 1
  fi

  gh issue create \
    --title "$title" \
    --body-file "$body_file" \
    --label "$label" \
    --label "codex-task"
}

# Create labels if missing.
for label in codex-task execution acceptance release human-gate ci-gate; do
  gh label create "$label" --force >/dev/null 2>&1 || true
done

create_issue "EXEC-01 Baseline Hardening" "codex_tasks/execution/EXEC-01-baseline-hardening.md" "execution"
create_issue "EXEC-02 Routing Core Completion" "codex_tasks/execution/EXEC-02-routing-core.md" "execution"
create_issue "EXEC-03 macOS Event Tap CLI Spike" "codex_tasks/execution/EXEC-03-event-tap-cli-spike.md" "execution"
create_issue "EXEC-04 Chrome Zoom Injection" "codex_tasks/execution/EXEC-04-chrome-zoom-injection.md" "execution"
create_issue "EXEC-05 Menu Bar MVP" "codex_tasks/execution/EXEC-05-menu-bar-mvp.md" "execution"
create_issue "EXEC-06 Permission UX and Fail-Closed" "codex_tasks/execution/EXEC-06-permission-ux.md" "execution"
create_issue "EXEC-07 Runtime Safety Controls" "codex_tasks/execution/EXEC-07-runtime-safety.md" "execution"
create_issue "EXEC-08 Dev Install / Uninstall" "codex_tasks/execution/EXEC-08-dev-install-uninstall.md" "execution"
create_issue "EXEC-09 RC Packaging" "codex_tasks/execution/EXEC-09-rc-packaging.md" "execution"

create_issue "ACCEPT-01 Acceptance Bundle Review" "codex_tasks/acceptance/ACCEPT-01-acceptance-bundle-review.md" "acceptance"
create_issue "ACCEPT-02 Local Installation" "codex_tasks/acceptance/ACCEPT-02-local-installation.md" "acceptance"
create_issue "ACCEPT-03 Human Functional QA" "codex_tasks/acceptance/ACCEPT-03-human-functional-qa.md" "acceptance"
create_issue "ACCEPT-04 Defect Loop or Acceptance Signoff" "codex_tasks/acceptance/ACCEPT-04-defect-loop-or-signoff.md" "acceptance"

create_issue "REL-01 Release Strategy" "codex_tasks/release/REL-01-release-strategy.md" "release"
create_issue "REL-02 Signing and Notarization Plan" "codex_tasks/release/REL-02-signing-notarization.md" "release"
create_issue "REL-03 Public Release Automation" "codex_tasks/release/REL-03-public-release-automation.md" "release"

echo "Created engineering node issues."

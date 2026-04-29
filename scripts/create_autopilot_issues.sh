#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI not found. Install gh first." >&2
  exit 2
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not authenticated. Run: gh auth login" >&2
  exit 2
fi

create_issue() {
  local id="$1"
  local title="$2"
  local file="$3"
  local labels="$4"
  if gh issue list --search "$id in:title" --json number --jq '.[0].number' | grep -q '^[0-9]'; then
    echo "Issue already exists for $id"
    return
  fi
  gh issue create --title "[$id] $title" --body-file "$file" --label "$labels"
}

create_issue EXEC-01 "Baseline hardening" codex_automation/prompts/EXEC-01.md "codex,execution"
create_issue EXEC-02 "Routing core completion" codex_automation/prompts/EXEC-02.md "codex,execution"
create_issue EXEC-03 "macOS Event Tap CLI spike" codex_automation/prompts/EXEC-03.md "codex,execution"
create_issue EXEC-04 "Chrome zoom injection" codex_automation/prompts/EXEC-04.md "codex,execution"
create_issue EXEC-05 "Menu bar MVP" codex_automation/prompts/EXEC-05.md "codex,execution"
create_issue EXEC-06 "Permission UX and fail-closed" codex_automation/prompts/EXEC-06.md "codex,execution"
create_issue EXEC-07 "Runtime safety controls" codex_automation/prompts/EXEC-07.md "codex,execution"
create_issue EXEC-08 "Dev install/uninstall" codex_automation/prompts/EXEC-08.md "codex,execution"
create_issue EXEC-09 "RC packaging" codex_automation/prompts/EXEC-09.md "codex,execution"

echo "Autopilot execution issues created."

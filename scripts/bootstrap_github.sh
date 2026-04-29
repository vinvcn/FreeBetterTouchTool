#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-ChromeWheelRouter}"
VISIBILITY="${2:---private}"

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: GitHub CLI 'gh' is required." >&2
  echo "Install: https://cli.github.com/" >&2
  exit 1
fi

if [ ! -d .git ]; then
  git init
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "Initial Codex Cloud scaffold"
else
  echo "No staged changes to commit."
fi

gh repo create "$REPO_NAME" "$VISIBILITY" --source=. --remote=origin --push

echo "GitHub repo created and pushed: $REPO_NAME"

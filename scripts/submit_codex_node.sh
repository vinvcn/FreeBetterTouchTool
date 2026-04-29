#!/usr/bin/env bash
set -euo pipefail

NODE_ID="${1:-}"
if [[ -z "$NODE_ID" ]]; then
  echo "Usage: $0 EXEC-01" >&2
  exit 2
fi

if [[ -z "${CODEX_ENV_ID:-}" ]]; then
  echo "Missing CODEX_ENV_ID. Run: export CODEX_ENV_ID=<your-codex-cloud-env-id>" >&2
  exit 2
fi

PROMPT="codex_automation/prompts/${NODE_ID}.md"
if [[ ! -f "$PROMPT" ]]; then
  echo "Prompt not found: $PROMPT" >&2
  exit 2
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found. Install with: npm i -g @openai/codex  OR  brew install codex" >&2
  exit 2
fi

QUERY="$(cat "$PROMPT")

Execution mode:
- Work in a branch named codex/${NODE_ID,,} if possible.
- Open or prepare a PR for this node.
- Do not continue to the next node.
- Do not claim hardware/local Mac acceptance.
"

echo "Submitting $NODE_ID to Codex Cloud environment $CODEX_ENV_ID..."
codex cloud exec --env "$CODEX_ENV_ID" "$QUERY"

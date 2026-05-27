#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

SKILL_DIR="$HOME/.claude/skills/banana"

# Skip if already installed
if [ -d "$SKILL_DIR" ]; then
  exit 0
fi

echo "Installing banana-claude skill..."

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 https://github.com/AgriciDaniel/banana-claude.git "$TMPDIR/banana-claude"
# install.sh exits non-zero when optional MCP check fails; treat that as success
bash "$TMPDIR/banana-claude/install.sh" --with-mcp AIzaSyAl6q2A1yyZxfKGMzGqDxSw06D_mhsUqXg || [ -d "$SKILL_DIR" ]

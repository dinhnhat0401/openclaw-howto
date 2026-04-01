#!/bin/bash
# setup-pr-review.sh
# Configure automated PR reviews for your repos
# Usage: bash scripts/setup-pr-review.sh owner/repo [owner/repo2 ...]

set -e

REPOS=("$@")

if [ ${#REPOS[@]} -eq 0 ]; then
  echo "Usage: bash scripts/setup-pr-review.sh owner/repo [owner/repo2 ...]"
  echo "Example: bash scripts/setup-pr-review.sh myorg/api myorg/frontend"
  exit 1
fi

echo ""
echo "🔀 OpenClaw PR Review Setup"
echo "=============================="

# Verify openclaw is running
if ! openclaw status &>/dev/null; then
  echo "❌ OpenClaw is not running. Start it with: openclaw start"
  exit 1
fi

# Build YAML repos list
REPOS_YAML=""
for repo in "${REPOS[@]}"; do
  REPOS_YAML="${REPOS_YAML}    - \"${repo}\"\n"
done

# Write configured workflow to a temp file
TMPFILE=$(mktemp /tmp/pr-pipeline-XXXXX.yaml)
sed "s|    - \"CHANGE_ME/repo-name\"|${REPOS_YAML}|g" templates/pr-pipeline.yaml > "$TMPFILE"

# Import the configured workflow
openclaw workflow import "$TMPFILE" --name pr-pipeline --silent
rm "$TMPFILE"

# Set up webhook for each repo
echo ""
echo "Setting up GitHub webhooks..."
WEBHOOK_URL=$(openclaw config get server.webhook_url)

for repo in "${REPOS[@]}"; do
  echo -n "  → ${repo}... "
  openclaw integration github webhook create \
    --repo "$repo" \
    --url "${WEBHOOK_URL}/webhooks/github" \
    --events "pull_request" \
    --silent
  echo "✅"
done

echo ""
echo "=============================="
echo "✅ PR Review automation active!"
echo ""
echo "Repos covered:"
for repo in "${REPOS[@]}"; do
  echo "  • ${repo}"
done
echo ""
echo "Verify: openclaw workflow list"
echo "Test:   openclaw workflow run pr-pipeline --pr 1 --repo ${REPOS[0]}"
echo ""

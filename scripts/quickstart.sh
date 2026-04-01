#!/bin/bash
# quickstart.sh
# Get OpenClaw fully configured in under 5 minutes
# Usage: bash scripts/quickstart.sh

set -e

echo ""
echo "🦀 OpenClaw Quickstart"
echo "========================"
echo ""
echo "This script will:"
echo "  1. Verify OpenClaw is installed and running"
echo "  2. Create your workspace files (USER.md, TOOLS.md)"
echo "  3. Install the 3 essential daily automations"
echo "  4. Send a test message to confirm everything works"
echo ""
read -p "Press Enter to continue or Ctrl+C to cancel..."

# ── Step 1: Verify installation ──
echo ""
echo "Step 1: Verifying OpenClaw..."
if ! command -v openclaw &>/dev/null; then
  echo "❌ openclaw not found. Install it:"
  echo "   brew install openclaw-cli"
  echo "   OR: npm install -g @openclaw/cli"
  exit 1
fi

if ! openclaw status &>/dev/null; then
  echo "Starting OpenClaw..."
  openclaw start
  sleep 2
fi
echo "✅ OpenClaw running ($(openclaw --version))"

# ── Step 2: Workspace setup ──
echo ""
echo "Step 2: Workspace Setup"
echo "-----------------------"

WORKSPACE_DIR=$(openclaw config get workspace.path 2>/dev/null || echo "$HOME/.openclaw/workspace")

if [ ! -f "$WORKSPACE_DIR/USER.md" ]; then
  echo "Creating USER.md..."
  read -p "Your name: " USER_NAME
  read -p "Your role: " USER_ROLE
  read -p "Preferred channel (telegram/slack/whatsapp): " CHANNEL

  cat > "$WORKSPACE_DIR/USER.md" << EOF
# User Profile

**Name:** $USER_NAME
**Role:** $USER_ROLE
**Timezone:** $(date +%Z)
**Preferred channel:** $CHANNEL

## Communication Preferences
- Be concise, direct, no filler
- Use plain language
- Alert only on actionable items

## Working Hours
- Start: 9:00 AM
- End: 6:00 PM
- Timezone: $(date +%Z)
EOF
  echo "✅ USER.md created"
else
  echo "✅ USER.md already exists"
fi

if [ ! -f "$WORKSPACE_DIR/TOOLS.md" ]; then
  echo "Creating TOOLS.md template..."
  cat > "$WORKSPACE_DIR/TOOLS.md" << 'EOF'
# Tools & Environment

## Repos
# Add your repos here, e.g.:
# - owner/repo-name (main project)

## CLI Tools
# - git, gh, docker, kubectl (installed)

## Preferences
# - Editor: vim / vscode / cursor
# - Shell: bash / zsh
EOF
  echo "✅ TOOLS.md created (edit it to add your repos)"
fi

# ── Step 3: Daily automations ──
echo ""
echo "Step 3: Installing Daily Automations"
echo "------------------------------------"
bash scripts/setup-daily-automations.sh

# ── Step 4: Test ──
echo ""
echo "Step 4: Sending test message..."
CHANNEL=$(openclaw config get channels.primary 2>/dev/null || echo "telegram")
openclaw channel send "$CHANNEL" "🦀 OpenClaw is configured and running! Morning briefings, end-of-day summaries, and weekly reports are active."
echo "✅ Test message sent to $CHANNEL"

echo ""
echo "========================"
echo "✅ Quickstart complete!"
echo ""
echo "Next steps:"
echo "  1. Add your GitHub repos:   openclaw integration github connect"
echo "  2. Connect your calendar:   openclaw integration calendar connect"
echo "  3. Set up PR reviews:       bash scripts/setup-pr-review.sh owner/repo"
echo "  4. Explore modules:         open 01-getting-started/README.md"
echo ""

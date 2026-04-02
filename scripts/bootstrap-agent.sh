#!/bin/bash
# bootstrap-agent.sh
# Run this once to configure OpenClaw for full autonomous operation.
# Your agent can run this on your behalf after reading AGENTS.md.

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${CYAN}[bootstrap]${NC} $1"; }
ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC}  $1"; }

log "Starting OpenClaw agent bootstrap..."
echo ""

# ── 1. Check openclaw is installed ──────────────────────────────────────────
if ! command -v openclaw &>/dev/null; then
    warn "openclaw not found. Install it first: https://openclaw.ai/install"
    exit 1
fi
ok "openclaw found: $(openclaw --version)"

# ── 2. Detect primary channel ────────────────────────────────────────────────
PRIMARY_CHANNEL=$(openclaw config get channels.primary 2>/dev/null || echo "")
if [ -z "$PRIMARY_CHANNEL" ]; then
    warn "No primary channel set. Set one first:"
    echo "  openclaw channel connect telegram"
    echo "  openclaw channel connect slack"
    echo "  openclaw config set channels.primary telegram"
    read -rp "  Enter your primary channel now (telegram/slack/whatsapp): " PRIMARY_CHANNEL
    openclaw config set channels.primary "$PRIMARY_CHANNEL"
fi
ok "Primary channel: $PRIMARY_CHANNEL"

# ── 3. Detect timezone ───────────────────────────────────────────────────────
TIMEZONE=$(openclaw config get timezone 2>/dev/null || \
           python3 -c "import subprocess; r=subprocess.run(['systemsetup','-gettimezone'],capture_output=True,text=True); print(r.stdout.split(': ')[-1].strip())" 2>/dev/null || \
           echo "UTC")
log "Timezone: $TIMEZONE"

# ── 4. Create memory files if missing ────────────────────────────────────────
log "Checking memory files..."

for f in USER.md TOOLS.md AGENTS.md HEARTBEAT.md; do
    if [ ! -f "$f" ]; then
        cp "memory-templates/$f" "./$f"
        warn "$f created from template — fill it in: $PWD/$f"
    else
        ok "$f already exists"
    fi
done

# ── 5. Install workflow templates ────────────────────────────────────────────
log "Installing automations..."

TEMPLATES=(
    "morning-briefing"
    "end-of-day-summary"
    "weekly-report"
    "pr-pipeline"
)

REPO_ROOT=$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || echo "$(dirname "$0")/..")

for tpl in "${TEMPLATES[@]}"; do
    TPL_FILE="$REPO_ROOT/templates/${tpl}.yaml"
    if [ -f "$TPL_FILE" ]; then
        if openclaw workflow import "$TPL_FILE" --timezone "$TIMEZONE" --channel "$PRIMARY_CHANNEL" 2>/dev/null; then
            ok "Installed: $tpl"
        else
            warn "Skipped (already installed or error): $tpl"
        fi
    else
        warn "Template not found: $TPL_FILE"
    fi
done

# ── 6. Verify cron jobs ───────────────────────────────────────────────────────
echo ""
log "Scheduled automations:"
openclaw cron list 2>/dev/null || warn "Could not list cron jobs"

# ── 7. Send test notification ─────────────────────────────────────────────────
echo ""
log "Sending test notification to $PRIMARY_CHANNEL..."
openclaw send "$PRIMARY_CHANNEL" "🤖 Agent bootstrap complete. Memory files loaded. Automations running. Ready." 2>/dev/null && \
    ok "Test notification sent" || \
    warn "Could not send test notification — check channel config"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Bootstrap complete.${NC}"
echo ""
echo "Next steps:"
echo "  1. Fill in the memory files that were created from templates"
echo "  2. Run: openclaw 'Read USER.md, TOOLS.md, AGENTS.md, HEARTBEAT.md and tell me what you know about me'"
echo "  3. Check: openclaw cron list"
echo ""

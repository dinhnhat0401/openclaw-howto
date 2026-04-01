#!/bin/bash
# setup-daily-automations.sh
# One-shot script to install the three most valuable daily automations
# Usage: bash scripts/setup-daily-automations.sh

set -e

echo ""
echo "🦀 OpenClaw Daily Automations Setup"
echo "===================================="
echo ""

# Verify openclaw is running
if ! openclaw status &>/dev/null; then
  echo "❌ OpenClaw is not running. Start it with: openclaw start"
  exit 1
fi

echo "✅ OpenClaw is running"
echo ""

# ── 1. Morning Briefing ──
echo "1/3  Setting up Morning Briefing..."
openclaw workflow import templates/morning-briefing.yaml --silent
openclaw cron create \
  --name "morning-briefing" \
  --schedule "30 7 * * 1-5" \
  --workflow morning-briefing \
  --description "Daily morning briefing on weekdays at 7:30 AM"
echo "     ✅ Morning Briefing scheduled (weekdays 7:30 AM)"

# ── 2. End of Day Summary ──
echo "2/3  Setting up End-of-Day Summary..."
openclaw workflow import templates/end-of-day-summary.yaml --silent
openclaw cron create \
  --name "eod-summary" \
  --schedule "0 18 * * 1-5" \
  --workflow end-of-day-summary \
  --description "Daily end-of-day summary on weekdays at 6:00 PM"
echo "     ✅ End-of-Day Summary scheduled (weekdays 6:00 PM)"

# ── 3. Weekly Report ──
echo "3/3  Setting up Weekly Report..."
openclaw workflow import templates/weekly-report.yaml --silent
openclaw cron create \
  --name "weekly-report" \
  --schedule "0 17 * * 5" \
  --workflow weekly-report \
  --description "Weekly progress report every Friday at 5:00 PM"
echo "     ✅ Weekly Report scheduled (Fridays 5:00 PM)"

echo ""
echo "===================================="
echo "✅ All 3 automations installed!"
echo ""
echo "Verify with:  openclaw cron list"
echo "Test now:     openclaw workflow run morning-briefing"
echo "Edit config:  openclaw workflow edit morning-briefing"
echo ""

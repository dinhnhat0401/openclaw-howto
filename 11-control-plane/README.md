# Module 11: Control Plane Integration

> **Level:** Advanced | **Time:** 45 minutes | **Prerequisites:** [Module 06](../06-automation/), [Module 08](../08-workflows/)

Use OpenClaw as the intelligence layer on top of [Control Plane](https://github.com/dinhnhat0401/control-plane) — an open-source agent orchestration system that automates coding tasks end-to-end from Telegram.

---

## What You'll Build

OpenClaw + Control Plane = **fully automated coding pipeline you control from chat**:

```
You (Telegram): "Fix the auth bug in payments-api"
          ↓
OpenClaw:     Parses intent, creates Control Plane task
          ↓
Control Plane: Assigns to Claude Code or Aider, runs in isolated worktree
          ↓
Agent:        Writes the fix, opens PR, CI runs
          ↓
Control Plane: Auto-merges when CI green + approved
          ↓
You (Telegram): "✅ Task merged — auth bug fixed"
```

No IDE. No terminal. No manual review.

---

## Prerequisites

1. OpenClaw installed and running (`openclaw start`)
2. Control Plane installed and running (`docker-compose up -d`)
3. Telegram bot configured in both systems

---

## Installation

### Step 1: Install Control Plane

```bash
# Clone Control Plane
git clone https://github.com/dinhnhat0401/control-plane.git
cd control-plane

# Run installer
chmod +x install.sh
./install.sh

# Or with Docker
cp .env.example .env
# Edit .env with your tokens
docker-compose up -d
```

### Step 2: Connect OpenClaw to Control Plane

```bash
# Add Control Plane as an integration
openclaw integration add \
  --name control-plane \
  --type webhook \
  --url http://localhost:3000 \
  --description "Agent orchestration for coding tasks"
```

Or add to your OpenClaw config:

```yaml
# openclaw.config.yaml
integrations:
  control_plane:
    url: "http://localhost:3000"     # or remote URL
    token: "${CONTROL_PLANE_TOKEN}"
    telegram_bot: "${CP_TELEGRAM_BOT_TOKEN}"
```

---

## Automations

### Automation 1: Voice Task Dispatch

Send voice note or text → Control Plane creates task → Agent runs.

```bash
# Add to SOUL.md or AGENTS.md
openclaw memory add --type instruction "
When I say 'start a task' or 'fix X in repo Y', create a Control Plane task via:
POST http://localhost:3000/api/tasks
{
  title: (extracted title),
  description: (my full request),
  repo: (repo I mentioned or my default repo),
  complexity: (S for single-file, M for multi-file)
}
Then send me the task ID and a Telegram link to track it.
"
```

### Automation 2: Task Status Monitoring

```yaml
# Add to openclaw skills
name: control-plane-status
description: Check Control Plane task status
trigger: keyword
keywords: ["task status", "what's running", "agent status"]

steps:
  - name: fetch_tasks
    tool: shell
    command: "curl -s http://localhost:3000/api/tasks?limit=5"

  - name: format_status
    tool: llm
    model: claude-haiku-4-5
    prompt: |
      Format this task list concisely:
      {{ fetch_tasks.output }}

      For each task show:
      - ID (first 8 chars)
      - Title
      - Status (with emoji: ⏳ pending, 🚀 running, ✅ completed, ❌ failed)
      - Hands-free? (✅ or ❌)

  - name: reply
    tool: channel
    target: "{{ trigger.channel }}"
    message: "{{ format_status.output }}"
```

### Automation 3: Daily KPI Report

```bash
# Create cron job that fetches Control Plane metrics
openclaw cron create \
  --schedule "0 9 * * 1-5" \
  --action "
    Fetch Control Plane metrics from http://localhost:3000/api/metrics
    and summarize:
    - Hands-free completion rate (vs 60% target)
    - Tasks completed today
    - Any failures or escalations
    Format as a 3-line Telegram message.
  "
```

Or use the workflow template:

```bash
openclaw workflow import templates/control-plane-report.yaml
```

---

## Workflow Templates

### control-plane-task.yaml

Submit a task from chat and get notified when it merges:

```yaml
name: control-plane-task
description: Submit coding task to Control Plane and track to completion
version: 1.0.0

trigger:
  type: keyword
  keywords: ["code task", "agent task", "fix", "implement", "write test"]
  channel: telegram

config:
  control_plane_url: "http://localhost:3000"
  default_repo: "CHANGE_ME/repo-name"
  default_complexity: M

steps:
  - name: parse_request
    tool: llm
    model: claude-haiku-4-5
    prompt: |
      Parse this coding request into a Control Plane task:
      "{{ trigger.text }}"

      Extract:
      - title: Short title (max 60 chars)
      - description: Full detailed request
      - repo: GitHub repo (owner/repo) if mentioned, else null
      - complexity: S (single file) | M (multi file) | L (large refactor)

      Return JSON only.

  - name: create_task
    tool: shell
    command: |
      curl -s -X POST {{ config.control_plane_url }}/api/tasks \
        -H "Content-Type: application/json" \
        -d '{
          "title": "{{ parse_request.title }}",
          "description": "{{ parse_request.description }}",
          "repo": "{{ parse_request.repo | default: config.default_repo }}",
          "complexity": "{{ parse_request.complexity | default: config.default_complexity }}"
        }'

  - name: confirm
    tool: channel
    target: "{{ trigger.channel }}"
    message: |
      ✅ Task created: {{ parse_request.title }}
      ID: {{ create_task.id | truncate: 8 }}
      Agent: {{ create_task.assignedAgent }}
      Track: http://localhost:3000/tasks/{{ create_task.id }}
```

---

## OpenClaw Skills for Control Plane

Add these to your skills folder (`~/.openclaw/skills/`):

### skill: cp-task

```yaml
name: cp-task
description: Create a Control Plane coding task
usage: /cp-task "Fix the login bug in auth.ts"

steps:
  - name: create
    tool: shell
    command: |
      curl -s -X POST http://localhost:3000/api/tasks \
        -H "Content-Type: application/json" \
        -d '{"title": "{{ args }}", "description": "{{ args }}", "repo": "{{ env.DEFAULT_REPO }}", "complexity": "M"}'

  - name: respond
    tool: channel
    target: "{{ trigger.channel }}"
    message: "🚀 Task started: {{ create.id | truncate: 8 }}"
```

### skill: cp-status

```yaml
name: cp-status
description: List recent Control Plane tasks
usage: /cp-status

steps:
  - name: fetch
    tool: shell
    command: "curl -s http://localhost:3000/api/tasks?limit=5"

  - name: respond
    tool: channel
    target: "{{ trigger.channel }}"
    message: |
      📋 Recent Tasks:
      {{ fetch.output | format_tasks }}
```

### skill: cp-approve

```yaml
name: cp-approve
description: Approve a Control Plane task for merge
usage: /cp-approve <task-id>

steps:
  - name: approve
    tool: shell
    command: |
      curl -s -X POST http://localhost:3000/api/tasks/{{ args }}/approve

  - name: respond
    tool: channel
    target: "{{ trigger.channel }}"
    message: "✅ Task {{ args | truncate: 8 }} approved for merge"
```

---

## Measuring Hands-Free Rate with OpenClaw

Track your automation ROI using OpenClaw's memory + Control Plane's KPI endpoint.

### Weekly KPI automation

```bash
openclaw cron create \
  --name "cp-kpi-weekly" \
  --schedule "0 9 * * 1" \
  --action "
    Check Control Plane KPI at http://localhost:3000/api/metrics.
    Send me a weekly report with:
    - Hands-free rate (target ≥60%)
    - S-tier and M-tier rates
    - Rollback rate (target ≤5%)
    - Total tasks completed
    Compare to previous week if available in memory.
    Flag if hands-free rate dropped more than 5%.
  "
```

### Trend tracking

```bash
# OpenClaw will remember KPI data week over week
openclaw memory search "control plane kpi" --type note --limit 5
```

---

## Troubleshooting

### Control Plane tasks not starting

```bash
# Check Control Plane is running
curl http://localhost:3000/health

# Check agent is installed
which claude-code || which aider

# View Control Plane logs
docker-compose logs -f control-plane
# OR
npm run dev   # if running locally
```

### Telegram bot conflict

If both OpenClaw and Control Plane use the same Telegram bot token, they'll fight over messages.

**Solution:** Use separate bots:
- OpenClaw bot: `@YourOpenClawBot` (general assistant)
- Control Plane bot: `@YourControlPlaneBot` (coding tasks only)

Or route through OpenClaw only:
```yaml
# openclaw skill that forwards to Control Plane
# See skill: cp-task above
```

### Tasks created but agent doesn't start

```bash
# Check Claude Code or Aider is installed
claude-code --version
aider --version

# If not installed:
npm install -g claude-code
pip install aider-chat
```

---

## What's Next

- [Module 06: Automation](../06-automation/) — Build more scheduling automations
- [Module 08: Workflows](../08-workflows/) — Multi-step pipelines
- [Control Plane ARCHITECTURE.md](https://github.com/dinhnhat0401/control-plane/blob/main/ARCHITECTURE.md) — How it works internally
- [Control Plane KPI.md](https://github.com/dinhnhat0401/control-plane/blob/main/KPI.md) — How to measure hands-free rate

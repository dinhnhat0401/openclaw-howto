# AGENTS.md

> Give this repo to your agent. It will read this file and configure itself to be the best version of itself.

## What This Does

Running through this guide, your agent will:

1. Learn who you are and how you work
2. Configure its memory so every future session starts with full context
3. Install the automations that save you the most time
4. Connect your most valuable integrations
5. Set up autonomous workflows that run without you

This is not documentation. This is a bootstrap sequence.

---

## Step 1 — Build Your Memory Files

Memory files are loaded at the start of every session. Without them, your agent starts cold every time. With them, it picks up exactly where you left off.

Create these 4 files in your working directory:

### USER.md — Who you are

```markdown
# User Profile

**Name:** [your name]
**Role:** [your job title / what you do]
**Primary language:** [English / Vietnamese / etc.]
**Communication style:** [concise / detailed / bullet points / narrative]
**Working hours:** [e.g. 9am–7pm JST]
**Primary device:** [Mac / Linux / Windows]

## Goals
[What are you trying to accomplish this week / month / quarter?]

## Preferences
- I prefer [X] over [Y] for code reviews
- When I ask for a summary, give me [N] bullet points max
- Always use [language] for variable names
- [Any other preferences]

## Do Not
- [Things the agent should never do]
```

### TOOLS.md — What's connected

```markdown
# Connected Tools

## Channels (where I receive messages)
- Primary: [telegram | slack | whatsapp | email]
- Backup: [secondary channel]

## Version Control
- GitHub username: [your username]
- Primary repos: [list repos you work on most]
- Review repos: [repos where you're a regular reviewer]

## Task Management
- Tool: [Linear | Todoist | Jira | GitHub Issues]
- Workspace: [workspace name or URL]

## Communication
- Slack workspace: [workspace]
- Email: [address]

## Other integrations
- [List any other connected services]
```

### AGENTS.md — Agent personas

```markdown
# Agent Configuration

## Default behavior
- Model: claude-sonnet-4-6
- Tone: direct, no filler phrases
- Code style: [your preferred style]
- Default branch strategy: [trunk-based | gitflow]

## Specialized agents
- **pr-reviewer**: Reviews PRs. Approves or requests changes. Flags security issues.
- **morning-briefer**: Sends daily briefing at [time]. Checks GitHub, calendar, email.
- **task-triager**: Prioritizes open tasks daily based on deadlines and dependencies.

## When to escalate to me
- Any destructive operation (delete, drop, rm -rf)
- Any push to main/trunk
- Any external communication on my behalf (emails, Slack DMs)
- Anything that costs > $1 in a single operation
```

### HEARTBEAT.md — What runs automatically

```markdown
# Recurring Automations

| Name | Schedule | What it does | Channel |
|------|----------|--------------|---------|
| morning-briefing | Weekdays 7:30am | Calendar + GitHub + email summary | telegram |
| pr-review | Weekdays 9am | Review assigned PRs | telegram |
| eod-summary | Weekdays 6pm | What I shipped + tomorrow's priorities | telegram |
| weekly-report | Fridays 5pm | Weekly metrics and highlights | telegram |

## Notes
[Any context about why these are configured this way]
```

---

## Step 2 — Install the Core Automations

Run this command to install the 4 automations above:

```bash
openclaw workflow import templates/morning-briefing.yaml
openclaw workflow import templates/end-of-day-summary.yaml
openclaw workflow import templates/weekly-report.yaml
openclaw workflow import templates/pr-pipeline.yaml
```

Or run the setup script which handles everything including timezone and channel config:

```bash
bash scripts/bootstrap-agent.sh
```

---

## Step 3 — Verify Setup

After running the bootstrap script, verify:

```bash
# Memory files exist
ls USER.md TOOLS.md AGENTS.md HEARTBEAT.md

# Automations are scheduled
openclaw cron list

# Test a channel message
openclaw "Send me a test message on [your primary channel]"
```

---

## Step 4 — First Session Prompt

In your first session after setup, send this:

```
Read USER.md, TOOLS.md, AGENTS.md, and HEARTBEAT.md.
Summarize what you know about me and what automations are running.
Tell me if anything looks misconfigured or missing.
```

A well-configured agent should respond with an accurate summary of your profile, tools, and running automations — with no gaps.

---

## What "Best Version of Itself" Looks Like

Your agent is fully configured when:

- [ ] Every session starts with full context (no re-explaining who you are)
- [ ] Morning briefing arrives before you start work
- [ ] PRs are reviewed autonomously — you only see the outcome
- [ ] EOD summary arrives without you asking
- [ ] You've gone 3 days without having to tell the agent something it should have known

If any of those aren't true, there's a gap in the memory files or automations. Fix it and re-run setup.

---

## Reference

- `memory-templates/` — pre-filled templates for all memory files, ready to customize
- `templates/` — YAML workflow definitions for all automations
- `scripts/bootstrap-agent.sh` — fully automated setup script
- `.agents/metadata.yaml` — machine-readable index of everything in this repo
- `.agents/glossary.yaml` — controlled vocabulary (skill, workflow, trigger, channel, etc.)
- `QUICK_REFERENCE.md` — all CLI commands
- `TROUBLESHOOTING.md` — when things break

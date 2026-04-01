# Templates

Ready-to-import workflow templates. Copy, configure, and run.

---

## How to Use

```bash
# 1. Import a template
openclaw workflow import templates/morning-briefing.yaml

# 2. Configure it (edit config section)
openclaw workflow edit morning-briefing

# 3. Run it manually to test
openclaw workflow run morning-briefing

# 4. Schedule it
openclaw cron create --schedule "30 7 * * 1-5" --workflow morning-briefing
```

---

## Available Templates

| Template | Trigger | Description |
|----------|---------|-------------|
| [morning-briefing.yaml](morning-briefing.yaml) | Daily 7:30 AM | Calendar + PRs + email + weather briefing |
| [end-of-day-summary.yaml](end-of-day-summary.yaml) | Daily 6:00 PM | Shipped work, open PRs, tomorrow prep |
| [weekly-report.yaml](weekly-report.yaml) | Friday 5:00 PM | Full week summary with stats |
| [pr-pipeline.yaml](pr-pipeline.yaml) | PR webhook | Auto review + CI check + conditional merge |
| [meeting-autopilot.yaml](meeting-autopilot.yaml) | Calendar event | Pre-meeting prep + notes + action items |
| [incident-response.yaml](incident-response.yaml) | Alert webhook | Triage + oncall notify + runbook lookup |

---

## Customizing

Every template has a `config:` block at the top. Minimum required changes are marked `CHANGE_ME`.

Common changes:
- `channel: telegram` → your preferred output channel
- `github_repos: ["CHANGE_ME/repo"]` → your actual repos
- `schedule: "30 7 * * 1-5"` → your timezone/timing

---

## Creating Your Own

Use any template as a base:

```bash
cp templates/morning-briefing.yaml templates/my-workflow.yaml
# Edit the file
openclaw workflow import templates/my-workflow.yaml
```

See [Module 08: Workflows](../08-workflows/) for the full workflow schema reference.

# OpenClaw Operations Guide

> The difference between a strong OpenClaw setup and a flaky one is operations.

This guide covers the ongoing routines that keep a serious setup productive.

---

## The Operator Mindset

Think of OpenClaw less like a chatbot and more like a small personal system.

That means you need to operate:

- context
- automations
- integrations
- costs
- reliability

The goal is not “maximum automation.”

The goal is **maximum useful output with minimum supervision**.

---

## Weekly Review (15–30 Minutes)

Run this once a week.

### 1. Check what actually helped

Ask:

- Which automation saved the most time?
- Which alert was the most useful?
- Which workflow removed the most friction?

Keep what is useful. Delete what is ornamental.

### 2. Review failures

```bash
openclaw cron history --all --last 7d --status failed
openclaw workflow history --last 7d --status failed
openclaw channel status
openclaw integration status --all
openclaw logs --level error --since 7d --summary
```

A silent failure is worse than a noisy one because it creates false trust.

If any failures appear, triage with:

```bash
openclaw cron history <name> --last 10       # inspect specific cron
openclaw workflow run <name> --verbose --dry-run  # replay without side effects
openclaw integration test <name>             # re-test failing integration
```

### 3. Audit memory drift

```bash
openclaw memory stats
openclaw memory search "project"             # look for stale project context
openclaw memory search "preference"          # look for contradictory preferences
```

Look for:

- stale projects
- changed preferences
- conflicting instructions
- dead people/roles/relationships in context

Prune what is outdated:

```bash
openclaw memory prune --older-than 90d       # remove old entries
```

### 4. Review costs

```bash
openclaw usage --this-week
openclaw usage --by skill --sort cost
openclaw usage --by model
```

Look for:

- expensive skills nobody values
- too-frequent polls
- premium model usage on cheap tasks
- duplicated workflows

### 5. Tighten prompts and notifications

Ask:

- which prompts caused vague output?
- which notifications were too noisy?
- which outputs were too long to be actionable?

---

## Monthly Review (30–60 Minutes)

This is the deeper cleanup.

### Monthly checklist

```bash
# 1. Prune old memory
openclaw memory stats
openclaw memory prune --older-than 90d

# 2. Verify integration auth
openclaw integration status --all
openclaw integration test <name>             # for any showing warnings

# 3. Archive or remove unused skills/workflows
openclaw skill list
openclaw usage --by skill --sort cost --last 30d
openclaw skill disable <name>                # disable unused skills
openclaw workflow list
openclaw workflow history --last 30d --status never_run  # find dormant workflows

# 4. Check budget trends
openclaw usage --this-month
openclaw usage --projection
openclaw usage --by model

# 5. Review permission settings
openclaw config get permissions

# 6. Back up key config and memory
cp -r ~/.openclaw/config.yaml ~/.openclaw/config.yaml.bak
openclaw memory export > ~/openclaw-memory-backup-$(date +%Y%m%d).json

# 7. Inspect workspace files
cat ~/.openclaw/USER.md                      # still accurate?
cat ~/.openclaw/TOOLS.md                     # still match your tools?
```

---

## What to Measure

A productive OpenClaw setup should improve a few concrete things.

### Good metrics

- PR review turnaround time
- inbox triage time saved
- number of recurring tasks removed from your head
- number of times you had to repeat the same context manually
- ratio of useful notifications to ignored notifications

### Bad metrics

- number of automations installed
- number of integrations connected
- number of prompts saved

Quantity is not quality.

---

## Reliability Practices

### 1. Prefer small automations

A morning briefing is easy to reason about.
A mega-agent that does 12 things every hour is not.

### 2. Make outputs scannable

Automations should produce:

- short bullet summaries
- clear owner/action blocks
- links to the source artifact when needed

### 3. Keep optional data optional

Do not let one flaky enrichment source block a useful result.

### 4. Add anti-spam rules early

For review watches and periodic checks, ask:

- what counts as materially changed?
- how long before repeating?
- when should it stay quiet?

---

## The Change Ladder

When evolving an automation, use this order:

1. **notify only**
2. **draft**
3. **execute with approval**
4. **fully autonomous**

This prevents premature trust.

---

## Backup Strategy

At minimum, preserve:

- config
- workspace files
- memory store/export
- important workflow definitions
- installed/custom skills

Even if OpenClaw is easy to reinstall, the value is in the tuned system around it.

### Backup commands

```bash
# Create a dated backup directory
BACKUP_DIR=~/openclaw-backup-$(date +%Y%m%d)
mkdir -p "$BACKUP_DIR"

# Config and workspace files
cp ~/.openclaw/config.yaml "$BACKUP_DIR/"
cp ~/.openclaw/.env "$BACKUP_DIR/"
cp ~/.openclaw/USER.md "$BACKUP_DIR/" 2>/dev/null
cp ~/.openclaw/TOOLS.md "$BACKUP_DIR/" 2>/dev/null
cp ~/.openclaw/AGENTS.md "$BACKUP_DIR/" 2>/dev/null
cp ~/.openclaw/SOUL.md "$BACKUP_DIR/" 2>/dev/null
cp ~/.openclaw/HEARTBEAT.md "$BACKUP_DIR/" 2>/dev/null

# Memory
openclaw memory export > "$BACKUP_DIR/memory.json"

# Custom skills and workflows
cp -r ~/.openclaw/skills/ "$BACKUP_DIR/skills/" 2>/dev/null
cp -r ~/.openclaw/workflows/ "$BACKUP_DIR/workflows/" 2>/dev/null

# Cron definitions
openclaw cron list --json > "$BACKUP_DIR/crons.json"
```

### Restore procedure

Work through each step in order. Restore config and workspace files first, then memory, then skills and workflows.

```bash
# 1. Restore config (stop daemon first)
openclaw stop
cp "$BACKUP_DIR/config.yaml" ~/.openclaw/config.yaml
cp "$BACKUP_DIR/.env" ~/.openclaw/.env

# 2. Validate config before restarting
openclaw config validate

# 3. Restore workspace files
cp "$BACKUP_DIR/USER.md" ~/.openclaw/ 2>/dev/null
cp "$BACKUP_DIR/TOOLS.md" ~/.openclaw/ 2>/dev/null
cp "$BACKUP_DIR/AGENTS.md" ~/.openclaw/ 2>/dev/null
cp "$BACKUP_DIR/SOUL.md" ~/.openclaw/ 2>/dev/null
cp "$BACKUP_DIR/HEARTBEAT.md" ~/.openclaw/ 2>/dev/null

# 4. Restart and verify
openclaw start
openclaw status

# 5. Restore memory
openclaw memory import < "$BACKUP_DIR/memory.json"
openclaw memory stats                         # verify count matches

# 6. Restore custom skills and workflows
cp -r "$BACKUP_DIR/skills/"* ~/.openclaw/skills/ 2>/dev/null
cp -r "$BACKUP_DIR/workflows/"* ~/.openclaw/workflows/ 2>/dev/null

# 7. Re-auth integrations (tokens are not portable)
openclaw integration status --all
openclaw integration test <name>              # for any showing unhealthy
```

> **Note:** Integration tokens and OAuth sessions cannot be backed up -- they must be re-authenticated on the new machine. Plan for this during migration.

---

## Multi-Machine Reality

If you run OpenClaw across machines/devices, be deliberate.

Keep synced:

- durable notes
- operating rules
- long-lived preferences

Do **not** casually sync:

- secrets
- volatile session state
- noisy UI cache/workspace state

For many users, a shared notes/knowledge layer plus a local execution layer is the sweet spot.

---

## Promotion / Retirement Rules

Every automation should periodically earn its place.

### Promote an automation when

- it has worked reliably for weeks
- you trust its outputs
- you rarely need to correct it
- it saves repeated effort

### Retire an automation when

- you ignore it consistently
- it duplicates another flow
- it breaks too often
- the underlying problem no longer matters

A deleted automation is often a quality improvement.

---

## Example Weekly Ops Checklist

```bash
## Weekly OpenClaw Ops — copy-paste commands

### Reliability
openclaw status                               # daemon health
openclaw cron history --all --last 7d --status failed   # cron failures
openclaw workflow history --last 7d --status failed     # workflow failures
openclaw integration status --all             # auth health

### Quality
openclaw memory stats                         # memory drift
openclaw memory search "project"              # stale project context
openclaw logs --level warn --since 7d --summary  # recurring warnings

### Cost
openclaw usage --this-week
openclaw usage --by skill --sort cost
openclaw usage --by model
```

### Checklist (non-command items)

- [ ] Remove one noisy alert or notification
- [ ] Improve one weak prompt or output format
- [ ] Correct stale memories or preferences
- [ ] Downgrade any cheap task still using a premium model
- [ ] Reduce unnecessary polling frequency
- [ ] Identify the single biggest time-saver this week
- [ ] Identify the single biggest friction point this week
- [ ] Decide one improvement for next week

---

## Recommended Companion Docs

- [POWER_USER_PLAYBOOK.md](POWER_USER_PLAYBOOK.md)
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- [CATALOG.md](CATALOG.md)
- [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md)
- [03-memory/README.md](03-memory/)
- [06-automation/README.md](06-automation/)
- [08-workflows/README.md](08-workflows/)

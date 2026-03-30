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

Check:

- cron history
- workflow failures
- channel errors
- integration auth warnings

A silent failure is worse than a noisy one because it creates false trust.

### 3. Audit memory drift

Look for:

- stale projects
- changed preferences
- conflicting instructions
- dead people/roles/relationships in context

### 4. Review costs

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

- prune old memory
- rotate or verify integration auth
- archive or remove unused skills/workflows
- check budget trends
- review permission settings
- back up key config and memory
- inspect whether your workspace files still match reality

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

```markdown
## Weekly OpenClaw Ops

### Reliability
- [ ] Check daemon health
- [ ] Review cron history for failures
- [ ] Review workflow failures/retries
- [ ] Check integration auth health

### Quality
- [ ] Remove one noisy alert
- [ ] Improve one weak prompt/output format
- [ ] Correct stale memories or preferences

### Cost
- [ ] Review top cost drivers
- [ ] Downgrade any cheap task using a premium model
- [ ] Reduce unnecessary polling frequency

### Output
- [ ] Identify the single biggest time-saver this week
- [ ] Identify the single biggest friction point this week
- [ ] Decide one improvement for next week
```

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

# OpenClaw Troubleshooting Guide

> When OpenClaw stops feeling magical, it is usually one of five things: bad auth, bad context, bad triggers, bad permissions, or bad expectations.

This guide is for diagnosing the failures that actually matter in production.

---

## Fast Triage: What Type of Problem Is This?

| Symptom | Likely Cause |
|---|---|
| OpenClaw is not responding at all | daemon/service issue |
| It responds, but no tools/integrations work | auth or config problem |
| Cron exists, but nothing happens | scheduling or trigger issue |
| Workflow runs, but output is wrong | prompt/context issue |
| Browser/GUI automation fails | permissions or environment issue |
| Costs suddenly spike | model routing, cron frequency, or memory bloat |
| It used to work, now it acts weird | stale memory, expired auth, or version drift |

---

## 1. OpenClaw Won't Start

### Check status first

```bash
openclaw status
openclaw logs --level error
```

### Common causes

- invalid config file
- missing API key
- port already in use
- old Node/runtime mismatch
- broken update

### Fast checks

```bash
openclaw config validate
openclaw test llm
lsof -i :3000
```

### Fix patterns

| Problem | Fix |
|---|---|
| Config syntax broken | validate config, revert recent edits |
| API key missing | move key to env / `.env`, restart |
| Port conflict | change port or stop conflicting process |
| Upgrade drift | check version, restart cleanly, re-run tests |

---

## 2. A Channel Is Connected but Behaving Wrong

### Symptoms

- replies stop arriving
- messages arrive late
- media fails
- only some channels work

### Diagnose

```bash
openclaw channel list
openclaw channel status
openclaw channel test <name>
openclaw logs --follow
```

### Usual causes

- expired/revoked token
- pairing broken
- permission mismatch
- routing config sends replies somewhere unexpected

### Fix mindset

Always separate:

1. **transport problem** — message never reached OpenClaw
2. **reasoning/problem-solving issue** — OpenClaw got the message but responded badly
3. **delivery problem** — OpenClaw responded but routed to the wrong place or failed to send

---

## 3. Cron Job Exists but Never Fires

### Check the obvious

```bash
openclaw cron list
openclaw cron history <name> --last 10
openclaw cron run <name> --now
```

### Common causes

- wrong timezone
- cron syntax error
- cron created but paused
- action works manually but fails in scheduled context
- environment variables available in your shell but not in runtime

### Debug flow

1. **Run it manually first** with `--now`
2. If manual works but schedule does not, inspect:
   - timezone
   - schedule expression
   - paused/disabled state
3. If it fires but output is bad, it is not a cron problem anymore — it is a prompt, auth, or context problem

### Example failure pattern

**Symptom:** “My morning briefing never arrives.”

Possible root causes:

- scheduled for UTC instead of local timezone
- message target not configured
- integration auth expired (calendar/email)
- briefing too large for target channel

---

## 4. Workflow Runs but Gives Bad Output

This is one of the most common failures.

### The four root causes

#### A. Bad inputs

- wrong trigger payload
- missing integration data
- stale browser content
- empty diff/log/file

#### B. Bad context

- missing memory
- stale memory
- conflicting preferences
- no repo/workspace context

#### C. Bad prompt

- vague task framing
- no output format specified
- too many goals in one step
- silent assumptions not written down

#### D. Bad workflow design

- trying to do too much in one step
- no error handling
- no branching/fallback logic
- side effects too early in the flow

### Fix strategy

Break the workflow into:

1. trigger
2. gather
3. analyze
4. act
5. notify

Then ask where the corruption begins.

### Rule of thumb

If the first bad artifact is the gathered data, fix the tool/integration.

If gathered data is good but the summary/recommendation is bad, fix the prompt/context.

---

## 5. When to Use `skip`, `abort`, `retry`, or `fallback`

| Mode | Use it when | Example |
|---|---|---|
| `skip` | missing data is acceptable | weather failed, but morning briefing should still go out |
| `abort` | proceeding would be misleading or dangerous | PR diff failed to load, so code review must stop |
| `retry` | failure is likely transient | API timeout, temporary network hiccup |
| `fallback` | there is a degraded but still useful alternative | browser scrape failed, fall back to API or notify-only mode |

### Practical guidance

- use **abort** for core truth sources
- use **skip** for optional enrichments
- use **retry** for flaky networks/services
- use **fallback** when a reduced service level is still useful

---

## 6. Memory Problems

### Symptoms of bad memory

- OpenClaw keeps repeating outdated assumptions
- it recalls facts you no longer want used
- output quality degrades over time
- it mixes projects/people together

### Check memory health

```bash
openclaw memory stats
openclaw memory search "<topic>"
openclaw memory export
```

### What usually went wrong

- too much temporary detail stored permanently
- no pruning
- preferences changed but old ones remain
- memory conflicts across time

### Fix patterns

- explicitly correct wrong memories
- prune outdated project memories
- restate canonical preferences cleanly
- move stable operating instructions into workspace files instead of relying only on memory

### Smell test

If the same correction has to be repeated more than once, the fix probably belongs in:

- `USER.md`
- `TOOLS.md`
- `AGENTS.md`
- a workflow/skill file

not only in conversational memory.

---

## 7. Browser or UI Automation Fails

### Distinguish two classes

#### Web/browser automation

Usually fails because of:

- selector drift
- login/session expiry
- anti-bot checks
- page loaded differently than expected

#### macOS/UI automation

Usually fails because of:

- Accessibility not granted
- Screen Recording not granted
- wrong host process has permission
- app restarted but runtime did not inherit permission changes

### Debug checklist

- confirm the environment can see the UI
- confirm permissions are granted to the right process/app
- retry after a full restart of the relevant process
- test with the smallest possible action first

### Good practice

Do not debug UI automation and app logic at the same time. First prove you can click/type/screenshot. Then debug the app flow.

---

## 8. Integration Auth Expired

### Symptoms

- workflow suddenly stops halfway
- one integration breaks while others still work
- “not authorized” / “forbidden” / “token expired” errors

### What to do

```bash
openclaw integration list
openclaw integration test <name>
openclaw logs --level error
```

Then re-auth only the failing integration.

### Recommendation

Add a lightweight weekly integration health check instead of discovering expired auth during an important workflow.

---

## 9. Cost Spikes

### Typical causes

- cron runs too often
- heavy model used for cheap tasks
- memory payload keeps growing
- duplicate workflows do the same work
- repeated retries or looping workflows

### Diagnose

```bash
openclaw usage --this-month
openclaw usage --by skill --sort cost
openclaw usage --by model
openclaw usage --projection
```

### Fixes with highest ROI

1. route simple tasks to cheaper/faster models
2. reduce cron frequency
3. prune memory
4. batch repeated operations
5. stop noisy automations nobody actually reads

---

## 10. Operational Drift

A lot of “OpenClaw got worse” is really drift.

### Drift looks like

- too many overlapping automations
- copied prompts no longer match reality
- integrations added but never used
- memory stores stale project context
- one-off experiments accidentally became permanent

### Fix it with a weekly review

Ask:

- what saved time this week?
- what created noise?
- what silently failed?
- what can be deleted?

Deletion is a productivity feature.

---

## 11. Recovery Playbook

When the system is messy, do not randomly poke it.

### Recovery sequence

1. verify daemon health
2. validate config
3. test LLM
4. test channels
5. test integrations
6. run the failing cron/workflow manually
7. inspect memory for stale context
8. only then edit prompts/workflows

This order matters because it avoids “fixing” the wrong layer.

---

## 12. The Most Common Reality

Most OpenClaw problems are not deep model problems.

They are usually one of these:

- wrong auth
- wrong target
- wrong schedule
- wrong context
- wrong permission scope
- too much automation, not enough maintenance

Fix the system before blaming the model.

---

## Recommended Next Reads

- [POWER_USER_PLAYBOOK.md](POWER_USER_PLAYBOOK.md)
- [OPERATIONS.md](OPERATIONS.md)
- [03-memory/README.md](03-memory/)
- [06-automation/README.md](06-automation/)
- [08-workflows/README.md](08-workflows/)

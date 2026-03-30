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
| A skill fails or produces bad output | bad config, missing dependency, auth, or version mismatch |
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

## 5. Skill Failures

### Symptoms

- skill command errors on install or run
- skill runs but output is empty or wrong
- skill worked before but now fails
- dry-run passes but real execution fails

### Diagnose

```bash
openclaw skill list
openclaw skill test <name> --dry-run
openclaw skill run <name> --verbose
openclaw logs --level error
```

### Common causes

- **missing dependency** — skill depends on an integration that is not enabled or authenticated
- **version mismatch** — skill was built for a different OpenClaw version
- **bad config** — required parameters missing from `skill.yaml` or config
- **permission denied** — skill needs filesystem, shell, or browser access that the current permission mode does not allow
- **upstream API change** — external service changed its API and the skill has not been updated

### Debug flow

1. **Run with `--dry-run` first** to confirm the skill definition is valid
2. **Run with `--verbose`** to see the full execution trace
3. If the skill depends on an integration, test the integration separately with `openclaw integration test <name>`
4. If it is a community skill, check for updates with `openclaw skill update <name>`
5. If it is a custom skill, validate the `skill.yaml` schema

### Fix patterns

| Problem | Fix |
|---|---|
| Missing integration | `openclaw integration enable <name>` then `openclaw integration config <name>` |
| Version mismatch | `openclaw skill update <name>` or pin to a compatible version |
| Permission denied | Elevate permission mode or add the specific path/capability the skill needs |
| Bad config | Check `skill.yaml` required fields, fill in missing parameters |
| Stale cache | `openclaw skill remove <name>` then reinstall |

### Smell test

If a skill works in `--dry-run` but fails in real execution, the problem is almost always auth, permissions, or a missing runtime dependency — not the skill logic itself.

---

## 6. When to Use `skip`, `abort`, `retry`, or `fallback`

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

## 7. Memory Problems

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

## 8. Browser or UI Automation Fails

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

## 9. Integration Auth Expired

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

## 10. Cost Spikes

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

## 11. Operational Drift

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

## 12. Recovery Playbook

When the system is messy, do not randomly poke it.

### Recovery sequence

Work through each step in order. Do not skip ahead -- each layer depends on the ones above it.

#### Step 1 — Verify daemon health

```bash
openclaw status
openclaw logs --level error
```

If the daemon is not running, start it with `openclaw start` and check logs for startup errors.

#### Step 2 — Validate config

```bash
openclaw config validate
```

If validation fails, inspect recent config edits. Use `openclaw config reset` only as a last resort (it preserves memory but resets all settings to defaults).

#### Step 3 — Test LLM connectivity

```bash
openclaw test llm
```

If this fails, check your API key (`openclaw config get llm.api_key`), network connectivity, and provider status pages.

#### Step 4 — Test channels

```bash
openclaw channel list
openclaw channel test <name>
```

Re-pair any channel that fails with `openclaw channel pair <name>`.

#### Step 5 — Test integrations

```bash
openclaw integration status --all
openclaw integration test <name>    # for any that report unhealthy
```

Re-auth failing integrations with `openclaw integration config <name>`.

#### Step 6 — Run the failing cron/workflow manually

```bash
openclaw cron run <name> --now      # for cron jobs
openclaw workflow run <name> --verbose --dry-run   # for workflows
```

If manual execution works but scheduled execution does not, the problem is in scheduling, timezone, or environment -- not in the task itself.

#### Step 7 — Inspect memory for stale context

```bash
openclaw memory stats
openclaw memory search “<topic>”
openclaw memory prune --older-than 90d
```

Look for contradictory or outdated entries that could confuse output.

#### Step 8 — Only then edit prompts/workflows

If steps 1--7 all pass, the problem is in your prompt, workflow logic, or output format. Now it is safe to edit those.

### Why this order matters

Each step rules out a layer of the stack. Editing a prompt when the real problem is expired auth wastes time and introduces new variables. Start at the bottom, work up.

---

## 13. The Most Common Reality

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
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- [CATALOG.md](CATALOG.md)
- [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md)
- [03-memory/README.md](03-memory/)
- [04-skills/README.md](04-skills/)
- [06-automation/README.md](06-automation/)
- [08-workflows/README.md](08-workflows/)

# OpenClaw Quick Reference

> Fast-lookup cheat sheet. For tutorials, see the [module guides](README.md#learning-path).
>
> Want the high-output version instead of the feature tour? Start with:
> - [POWER_USER_PLAYBOOK.md](POWER_USER_PLAYBOOK.md)
> - [OPENCLAW_PRODUCTIVITY_STACK.md](OPENCLAW_PRODUCTIVITY_STACK.md)
> - [OPERATIONS.md](OPERATIONS.md)
> - [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 1. Installation

```bash
# Homebrew (macOS/Linux) -- recommended
brew install openclaw-cli

# npm (all platforms)
npm install -g @openclaw/cli

# From source
git clone https://github.com/openclaw/openclaw.git
cd openclaw && npm install && npm run build && npm link

# Verify
openclaw --version

# Guided setup
openclaw onboard

# Start
openclaw start
```

**Prerequisites:** Node.js 22.14+ | npm 10+ | macOS 13+ / Ubuntu 22.04+ / Windows 11 (WSL2)

---

## 2. Essential CLI Commands

### Core

| Command | Description |
|---|---|
| `openclaw start` | Start the assistant |
| `openclaw stop` | Stop the assistant |
| `openclaw restart` | Restart the assistant |
| `openclaw status` | Show running status |
| `openclaw update` | Update to latest version |
| `openclaw logs --follow` | Stream logs in real-time |
| `openclaw logs --level error` | Filter logs by level |
| `openclaw onboard` | Run guided setup wizard |
| `openclaw help <command>` | Help for any command |

### Configuration

| Command | Description |
|---|---|
| `openclaw config show` | Show current configuration |
| `openclaw config validate` | Validate config file |
| `openclaw config set <key> <value>` | Set a config value |
| `openclaw config get <key>` | Get a config value |
| `openclaw config reset` | Reset to defaults (keeps memory) |
| `openclaw config edit` | Open config in editor |

### Channels

| Command | Description |
|---|---|
| `openclaw channel list` | List all channels |
| `openclaw channel pair <name>` | Connect a channel |
| `openclaw channel test <name>` | Test channel connection |
| `openclaw channel status` | Show all channel statuses |
| `openclaw channel disconnect <name>` | Disconnect a channel |

### Skills

| Command | Description |
|---|---|
| `openclaw skill search <query>` | Search community registry |
| `openclaw skill install <name>` | Install a skill |
| `openclaw skill install <name>@<ver>` | Install specific version |
| `openclaw skill list` | List installed skills |
| `openclaw skill update --all` | Update all skills |
| `openclaw skill enable <name>` | Enable a skill |
| `openclaw skill disable <name>` | Disable a skill |
| `openclaw skill remove <name>` | Remove a skill |
| `openclaw skill run <name>` | Run a skill manually |
| `openclaw skill test <name> --dry-run` | Simulate without executing |

### Cron / Scheduling

| Command | Description |
|---|---|
| `openclaw cron list` | List all cron jobs |
| `openclaw cron create --schedule "..." --action "..."` | Quick create |
| `openclaw cron create --file <path>` | Create from YAML file |
| `openclaw cron run <name> --now` | Run immediately |
| `openclaw cron pause <name>` | Pause a job |
| `openclaw cron resume <name>` | Resume a job |
| `openclaw cron delete <name>` | Delete a job |
| `openclaw cron history <name> --last 10` | View last N runs |

### Workflows

| Command | Description |
|---|---|
| `openclaw workflow list` | List all workflows |
| `openclaw workflow create --file <path>` | Create from YAML file |
| `openclaw workflow run <name>` | Run a workflow |
| `openclaw workflow run <name> --verbose` | Run with step-by-step output |
| `openclaw workflow test <name> --dry-run` | Simulate without executing |
| `openclaw workflow test <name> --mock-trigger '...'` | Test with mock trigger data |
| `openclaw workflow history <name>` | View run history |
| `openclaw workflow status --all` | Show status of all workflows |
| `openclaw workflow pause <name>` | Pause a workflow |
| `openclaw workflow resume <name>` | Resume a paused workflow |
| `openclaw workflow delete <name>` | Delete a workflow |

### Integrations

| Command | Description |
|---|---|
| `openclaw integration list` | List all integrations |
| `openclaw integration enable <name>` | Enable an integration |
| `openclaw integration config <name>` | Configure an integration |
| `openclaw integration test <name>` | Test connectivity |
| `openclaw integration status --all` | Health check all |

### Memory

| Command | Description |
|---|---|
| `openclaw memory stats` | View memory statistics |
| `openclaw memory search <query>` | Search memory entries |
| `openclaw memory export` | Export memory as JSON |
| `openclaw memory prune --older-than 90d` | Prune old entries |
| `openclaw memory optimize` | Summarize verbose entries |

### Usage & Billing

| Command | Description |
|---|---|
| `openclaw usage --this-month` | This month's usage |
| `openclaw usage --by skill --sort cost` | Usage by skill |
| `openclaw usage --by model` | Usage by model |
| `openclaw usage --projection` | Projected month-end cost |

### Testing & Debug

| Command | Description |
|---|---|
| `openclaw test llm` | Test LLM connection |
| `openclaw test all` | Test all connections |
| `openclaw debug --profile "..."` | Profile a request |
| `openclaw run "..." --headless` | Run non-interactively |
| `openclaw audit log --last 24h` | View recent audit log |

### Global Flags

| Flag | Effect |
|---|---|
| `--verbose` | Verbose output |
| `--quiet` | Suppress output |
| `--json` | Output as JSON |
| `--config <path>` | Use alternate config file |
| `--no-color` | Disable color output |

---

## 3. Configuration Quick Reference (config.yaml)

```yaml
# ~/.openclaw/config.yaml — key sections

llm:
  provider: anthropic                # anthropic | openai | deepseek | ollama
  model: claude-sonnet-4-6
  api_key: ${ANTHROPIC_API_KEY}      # always use env vars
  max_tokens: 8192
  temperature: 0.3

server:
  port: 3000
  host: "127.0.0.1"                 # never use 0.0.0.0
  auth:
    enabled: true
    token: ${OPENCLAW_AUTH_TOKEN}

memory:
  backend: local                     # local | redis | postgres
  persist_path: ~/.openclaw/memory
  auto_summarize: true
  max_context_tokens: 100000

permissions:
  mode: standard                     # locked | restricted | standard | trusted | admin | custom
  filesystem:
    allowed_paths: ["~/Documents", "~/Projects"]
    denied_paths: ["~/.ssh", "~/.gnupg"]
  shell:
    sandbox: true
  browser:
    headless: true

cron:
  enabled: true
  timezone: "America/New_York"

billing:
  monthly_budget: 50.00

logging:
  level: info                        # debug | info | warn | error
```

---

## 4. Channel Setup Cheat Sheet

| Channel | Setup | Config Snippet |
|---|---|---|
| **WhatsApp** | `openclaw channel pair whatsapp` -- scan QR code | `channels.whatsapp.enabled: true` |
| **Telegram** | Create bot via @BotFather, copy token | `channels.telegram.bot_token: ${TELEGRAM_BOT_TOKEN}` / `admin_chat_id: "YOUR_ID"` |
| **Slack** | `openclaw channel pair slack` -- OAuth in browser | `channels.slack.bot_token: ${SLACK_BOT_TOKEN}` / `app_token: ${SLACK_APP_TOKEN}` |
| **Discord** | Create app at discord.com/developers, copy token, invite bot | `channels.discord.bot_token: ${DISCORD_BOT_TOKEN}` / `allowed_guilds: ["ID"]` |
| **Signal** | `openclaw channel pair signal` -- linked device QR | `channels.signal.enabled: true` |
| **iMessage** | macOS only, `openclaw channel pair imessage` | `channels.imessage.enabled: true` |
| **Matrix** | Configure homeserver + access token | `channels.matrix.homeserver: "https://..."` / `access_token: ${MATRIX_TOKEN}` |
| **MS Teams** | Azure app registration, `openclaw channel pair teams` | `channels.teams.enabled: true` |
| **Google Chat** | Service account setup | `channels.google_chat.enabled: true` |
| **Mattermost** | `openclaw channel pair mattermost` | `channels.mattermost.webhook_url: "..."` |
| **LINE** | Channel token from LINE Developers | `channels.line.channel_token: ${LINE_TOKEN}` |
| **Feishu** | App token from Feishu Open Platform | `channels.feishu.app_token: ${FEISHU_TOKEN}` |

**Quick validation for any channel:**

```bash
openclaw channel test <name>
```

---

## 5. Top 10 Skills to Install First

| # | Skill | What It Does | Install |
|---|---|---|---|
| 1 | `daily-briefing` | Morning summary: calendar, email, tasks, weather | `openclaw skill install daily-briefing` |
| 2 | `inbox-zero` | Auto-categorize email, draft responses | `openclaw skill install inbox-zero` |
| 3 | `email-manager` | Full email lifecycle (read, draft, send, archive) | `openclaw skill install email-manager` |
| 4 | `github-pr-reviewer` | Automated code review with suggestions | `openclaw skill install github-pr-reviewer` |
| 5 | `standup-reporter` | Generate daily standups from git history | `openclaw skill install standup-reporter` |
| 6 | `meeting-summarizer` | Notes, action items, follow-up drafts | `openclaw skill install meeting-summarizer` |
| 7 | `calendar-sync` | Cross-platform calendar management | `openclaw skill install calendar-sync` |
| 8 | `task-manager` | Sync tasks across Todoist/Things/Trello | `openclaw skill install task-manager` |
| 9 | `research-agent` | Deep web research with source citations | `openclaw skill install research-agent` |
| 10 | `expense-tracker` | OCR receipts, categorize, generate reports | `openclaw skill install expense-tracker` |

**Install all at once:**

```bash
openclaw skill install daily-briefing inbox-zero email-manager \
  github-pr-reviewer standup-reporter meeting-summarizer \
  calendar-sync task-manager research-agent expense-tracker
```

---

## 6. Cron Schedule Syntax

```
┌───────────── minute (0-59)
│ ┌───────────── hour (0-23)
│ │ ┌───────────── day of month (1-31)
│ │ │ ┌───────────── month (1-12)
│ │ │ │ ┌───────────── day of week (0-6, Sun=0)
│ │ │ │ │
* * * * *
```

### Common Schedules

| Expression | Meaning |
|---|---|
| `30 7 * * *` | Every day at 7:30 AM |
| `0 9 * * 1-5` | Weekdays at 9:00 AM |
| `0 18 * * 1-5` | Weekdays at 6:00 PM |
| `*/15 * * * *` | Every 15 minutes |
| `*/30 8-20 * * *` | Every 30 min during 8 AM -- 8 PM |
| `0 9-17/2 * * 1-5` | Every 2 hours, work hours, weekdays |
| `0 16 * * 5` | Friday at 4:00 PM |
| `0 8 * * 1` | Monday at 8:00 AM |
| `0 0 1 * *` | First of each month at midnight |
| `0 0 * * 0` | Every Sunday at midnight |

### Operators

| Operator | Meaning | Example |
|---|---|---|
| `*` | Every value | `* * * * *` = every minute |
| `,` | List | `0,30 * * * *` = :00 and :30 |
| `-` | Range | `1-5` = Mon through Fri |
| `/` | Step | `*/15` = every 15 units |

### Quick Create Examples

```bash
# Morning briefing at 7:30 AM
openclaw cron create --schedule "30 7 * * *" --action "Send me a morning briefing"

# Inbox triage every 30 min during work hours
openclaw cron create --schedule "*/30 8-20 * * *" --action "Triage my inbox"

# Weekly metrics every Friday at 4 PM
openclaw cron create --schedule "0 16 * * 5" --action "Generate weekly productivity report"

# Dependency check every Monday at 8 AM
openclaw cron create --schedule "0 8 * * 1" --action "Scan repos for vulnerable dependencies"
```

---

## 7. Model Selection Decision Matrix

| Task Type | Recommended Model | Cost | Speed | Why |
|---|---|---|---|---|
| Complex reasoning / analysis | Claude Opus 4.6 | $$$ | Slow | Highest quality |
| Code review / debugging | Claude Opus 4.6 | $$$ | Slow | Catches subtle bugs |
| Deep research | Claude Opus 4.6 / o3 | $$$ | Slow | Extended reasoning |
| Daily tasks / email / automation | Claude Sonnet 4.6 | $$ | Medium | Best quality/cost balance |
| Code generation / refactoring | Claude Sonnet 4.6 | $$ | Medium | Good + cost-effective |
| Quick queries / reminders | Claude Haiku 4.5 | $ | Fast | Fast, cheap, sufficient |
| Classification / routing | Claude Haiku 4.5 | $ | Fast | No need for heavy model |
| Inbox triage / tagging | Claude Haiku 4.5 | $ | Fast | Simple categorization |
| Budget-friendly alternative | DeepSeek V3 | $ | Fast | Low cost |
| Privacy-critical / airgapped | Ollama Llama 3.3 70B | Free | Local | Data never leaves machine |

### Auto-Routing Config

```yaml
llm:
  default: claude-sonnet-4-6
  routing:
    - match: "review|analyze|debug|architect|research"
      model: claude-opus-4-6
    - match: "remind|weather|time|translate|convert"
      model: claude-haiku-4-5
    - match: "private|confidential|secret"
      model: ollama/llama3.3:70b
    - condition: "monthly_spend > budget * 0.8"
      model: claude-haiku-4-5
```

---

## 8. Permission Modes

| Mode | Shell | Filesystem | Browser | Config Edit | Use Case |
|---|---|---|---|---|---|
| **Locked** | No | No | No | No | Read-only Q&A |
| **Restricted** | No | Read-only | No | No | Safe exploration |
| **Standard** | Sandboxed | Read-Write (scoped) | Headless | No | Daily use (recommended) |
| **Trusted** | Full | Read-Write | Full | No | Power user |
| **Admin** | Full | Full | Full | Yes | System configuration |
| **Custom** | Configurable | Configurable | Configurable | Configurable | Fine-grained control |

### Per-Channel Permission Levels

| Level | Shell | Filesystem | Config | Cross-Channel |
|---|---|---|---|---|
| **Restricted** | No | Read-only | No | No |
| **Standard** | Sandboxed | Read-Write | No | Yes |
| **Trusted** | Full | Read-Write | No | Yes |
| **Admin** | Full | Read-Write | Yes | Yes |

```bash
# Set global mode
openclaw config set permissions.mode standard

# Set per-channel
openclaw config set channels.whatsapp.permissions.mode restricted
openclaw config set channels.slack.permissions.mode trusted
```

---

## 9. File Locations

| File / Directory | Path | Purpose |
|---|---|---|
| Main config | `~/.openclaw/config.yaml` | All configuration |
| Secrets / env vars | `~/.openclaw/.env` | API keys, tokens (never commit) |
| Memory store | `~/.openclaw/memory/` | Persistent memory |
| Installed skills | `~/.openclaw/skills/` | Skill definitions |
| Project skills | `.openclaw/skills/` | Per-repo skill overrides |
| Application logs | `~/.openclaw/logs/` | Log files |
| Audit trail | `~/.openclaw/logs/audit.log` | Security audit log |
| Network log | `~/.openclaw/logs/network.log` | HTTP request log |
| Response cache | `~/.openclaw/cache/` | Cached responses |
| Browser screenshots | `~/.openclaw/screenshots/` | Screenshots from browser automation |
| Browser cookies | `~/.openclaw/cookies/` | Stored browser sessions |

**Override base directory:** set `OPENCLAW_HOME` environment variable.

---

## 10. Common Troubleshooting

| Problem | Quick Fix |
|---|---|
| Port 3000 in use | `lsof -i :3000` then `openclaw config set server.port 3001` |
| API key invalid | `openclaw config validate` then `openclaw test llm` |
| Channel won't connect | `openclaw channel test <name>` then `openclaw channel pair <name>` |
| Slow responses | `openclaw debug --profile "test query"` -- check model, memory size, cache |
| High costs | `openclaw usage --by skill --sort cost` -- switch heavy skills to Haiku |
| Memory bloat | `openclaw memory stats` then `openclaw memory prune --older-than 90d` |
| Skill fails | `openclaw skill test <name> --dry-run` then `--verbose` |
| Config broken | `openclaw config validate` -- if unrecoverable: `openclaw config reset` |
| Cron not firing | Check timezone in config, verify `cron.enabled: true`, run `openclaw cron run <name> --now` |
| Browser automation fails | `openclaw browser check` then `openclaw browser install` |
| Integration auth expired | `openclaw integration test <name>` then re-run `openclaw integration config <name>` |
| OpenClaw won't start | Check `openclaw logs --level error`, verify Node.js 22.14+, run `openclaw test all` |
| Broken after upgrade | `openclaw config validate`, then follow [Upgrade Playbook](OPERATIONS.md#upgrade-playbook) |

---

## 11. Environment Variables

### System Variables

| Variable | Description | Default |
|---|---|---|
| `OPENCLAW_HOME` | Override config directory | `~/.openclaw` |
| `OPENCLAW_CONFIG` | Override config file path | `~/.openclaw/config.yaml` |
| `OPENCLAW_LOG_LEVEL` | Override log level | `info` |
| `OPENCLAW_PORT` | Override server port | `3000` |
| `OPENCLAW_AUTH_TOKEN` | Control UI auth token | (set during onboard) |

### LLM Provider Keys

| Variable | Provider |
|---|---|
| `ANTHROPIC_API_KEY` | Anthropic (Claude) |
| `OPENAI_API_KEY` | OpenAI (GPT-4.1, o3) |
| `DEEPSEEK_API_KEY` | DeepSeek |

### Channel Tokens

| Variable | Channel |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Telegram |
| `SLACK_BOT_TOKEN` | Slack bot token |
| `SLACK_APP_TOKEN` | Slack app token (Socket Mode) |
| `SLACK_SIGNING_SECRET` | Slack signing secret |
| `DISCORD_BOT_TOKEN` | Discord |
| `MATRIX_ACCESS_TOKEN` | Matrix |
| `LINE_CHANNEL_TOKEN` | LINE |
| `FEISHU_APP_TOKEN` | Feishu |

### Integration Tokens

| Variable | Service |
|---|---|
| `GITHUB_TOKEN` | GitHub |
| `GMAIL_APP_PASSWORD` | Gmail |
| `NOTION_API_KEY` | Notion |
| `TODOIST_API_KEY` | Todoist |
| `SPOTIFY_CLIENT_ID` | Spotify |
| `SPOTIFY_CLIENT_SECRET` | Spotify |
| `PLAID_CLIENT_ID` | Plaid |
| `STRIPE_API_KEY` | Stripe |

All secrets go in `~/.openclaw/.env` (auto-added to `.gitignore`).

---

## 12. Cost Optimization Tips

| # | Tip | Savings |
|---|---|---|
| 1 | Route simple tasks (reminders, weather, classification) to Haiku | 5-10x per task |
| 2 | Reserve Opus for code review, research, complex analysis only | Avoid $$$ on trivial work |
| 3 | Enable response caching (`performance.cache.enabled: true`) | Eliminates repeat queries |
| 4 | Reduce cron frequency -- every 30 min, not every 1 min | Linear reduction |
| 5 | Set a monthly budget with auto-downgrade (`billing.monthly_budget`) | Hard spending cap |
| 6 | Use local models (Ollama) for classification and private data | 100% savings on those tasks |
| 7 | Lower `max_tokens` for skills that produce short outputs | 10-30% per skill |
| 8 | Batch operations instead of one-at-a-time API calls | 20-50% per batch |
| 9 | Prune memory monthly (`openclaw memory prune --older-than 90d`) | Less context = fewer tokens |
| 10 | Monitor with `openclaw usage --by skill --sort cost` weekly | Find and fix cost spikes |

### Budget Auto-Actions Config

```yaml
billing:
  monthly_budget: 50.00
  actions:
    at_80_percent: switch_to_haiku    # auto-downgrade model
    at_95_percent: essential_only     # only critical automations
    at_100_percent: pause             # stop all automated tasks
```

---

**Full docs:** [docs.openclaw.ai](https://docs.openclaw.ai) | **GitHub:** [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw) | **Community:** [discord.gg/openclaw](https://discord.gg/openclaw)

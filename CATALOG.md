# OpenClaw Feature Catalog

> Complete inventory of every command, channel, skill, integration, automation type, workflow pattern, permission mode, and model option available in OpenClaw. Use this as a reference when building workflows or evaluating capabilities.

---

## Summary

| Category | Count | Description |
|---|---|---|
| CLI Commands | 95+ | Core, channel, skill, integration, cron, workflow, memory, browser, usage, debug |
| Channels | 15 | Messaging platforms with bidirectional connectivity |
| Skills | 22+ | Community and custom modular capabilities |
| Integrations | 50+ | External service connectors across 6 categories |
| Automation Types | 5 | Trigger mechanisms for scheduled and event-driven tasks |
| Workflow Patterns | 4 | Reusable design patterns for multi-step pipelines |
| Permission Modes | 6 | Access control levels from locked to custom |
| Model Options | 10+ | Cloud and local LLM providers and model variants |

---

## CLI Commands

All commands use the `openclaw` prefix. Global flags (`--verbose`, `--quiet`, `--json`, `--config <path>`, `--no-color`, `--help`, `--version`) apply to every command.

### Core Commands

| Command | Description | Example |
|---|---|---|
| `openclaw start` | Start the OpenClaw daemon and Control UI | `openclaw start` |
| `openclaw stop` | Stop the running daemon | `openclaw stop` |
| `openclaw restart` | Restart the daemon | `openclaw restart` |
| `openclaw status` | Show running status, PID, uptime | `openclaw status` |
| `openclaw logs` | View application logs | `openclaw logs --tail 50` |
| `openclaw logs --level <level>` | Filter logs by level (debug, info, warn, error) | `openclaw logs --level error` |
| `openclaw logs --follow` | Stream logs in real-time | `openclaw logs --follow` |
| `openclaw update` | Update to the latest version | `openclaw update` |
| `openclaw --version` | Show installed version | `openclaw --version` |
| `openclaw help` | Show top-level help | `openclaw help` |
| `openclaw help <command>` | Show help for a specific command | `openclaw help skill` |

### Onboarding and Configuration Commands

| Command | Description | Example |
|---|---|---|
| `openclaw onboard` | Run the guided setup wizard | `openclaw onboard` |
| `openclaw config show` | Display current configuration | `openclaw config show` |
| `openclaw config validate` | Validate config file for errors | `openclaw config validate` |
| `openclaw config set <key> <value>` | Set a configuration value | `openclaw config set llm.model claude-opus-4-6` |
| `openclaw config get <key>` | Get a configuration value | `openclaw config get server.port` |
| `openclaw config reset` | Reset configuration to defaults (preserves memory) | `openclaw config reset` |
| `openclaw config edit` | Open config file in default editor | `openclaw config edit` |
| `openclaw config path` | Print the config file path | `openclaw config path` |

### Channel Commands

| Command | Description | Example |
|---|---|---|
| `openclaw channel list` | List all channels and their status | `openclaw channel list` |
| `openclaw channel list --detailed` | List channels with setup instructions | `openclaw channel list --detailed` |
| `openclaw channel pair <name>` | Connect a new channel (interactive) | `openclaw channel pair telegram` |
| `openclaw channel test <name>` | Test a channel connection | `openclaw channel test slack` |
| `openclaw channel status` | Show status of all channels | `openclaw channel status` |
| `openclaw channel status <name>` | Show status of a specific channel | `openclaw channel status whatsapp` |
| `openclaw channel disconnect <name>` | Disconnect a channel | `openclaw channel disconnect discord` |
| `openclaw channel logs <name>` | View channel-specific logs | `openclaw channel logs telegram --tail 50` |

### Skill Commands

| Command | Description | Example |
|---|---|---|
| `openclaw skill list` | List installed skills | `openclaw skill list` |
| `openclaw skill search <query>` | Search the community registry | `openclaw skill search "email"` |
| `openclaw skill browse --category <cat>` | Browse skills by category | `openclaw skill browse --category developer` |
| `openclaw skill info <name>` | View detailed skill information | `openclaw skill info email-manager` |
| `openclaw skill install <name>` | Install a skill from the registry | `openclaw skill install daily-briefing` |
| `openclaw skill install <name>@<version>` | Install a specific version | `openclaw skill install email-manager@2.1.0` |
| `openclaw skill install <git-url>` | Install from a Git repository | `openclaw skill install https://github.com/user/skill.git` |
| `openclaw skill install ./<path>` | Install from a local directory | `openclaw skill install ./my-skill/` |
| `openclaw skill update <name>` | Update a single skill | `openclaw skill update github-pr-reviewer` |
| `openclaw skill update --all` | Update all installed skills | `openclaw skill update --all` |
| `openclaw skill enable <name>` | Enable a disabled skill | `openclaw skill enable expense-tracker` |
| `openclaw skill disable <name>` | Disable a skill without removing | `openclaw skill disable expense-tracker` |
| `openclaw skill remove <name>` | Remove a skill entirely | `openclaw skill remove expense-tracker` |
| `openclaw skill config <name>` | View or edit skill configuration | `openclaw skill config standup-reporter` |
| `openclaw skill test <name>` | Run skill tests | `openclaw skill test standup-reporter` |
| `openclaw skill test <name> --dry-run` | Simulate execution without side effects | `openclaw skill test standup-reporter --dry-run` |
| `openclaw skill run <name>` | Run a skill manually | `openclaw skill run daily-briefing` |
| `openclaw skill run <name> --verbose` | Run with detailed output | `openclaw skill run daily-briefing --verbose` |
| `openclaw skill history <name>` | View execution history | `openclaw skill history inbox-zero --last 10` |
| `openclaw skill validate ./<path>` | Validate a custom skill definition | `openclaw skill validate ./my-skill/` |
| `openclaw skill publish ./<path>` | Publish a skill to the community registry | `openclaw skill publish ./my-skill/` |

### Integration Commands

| Command | Description | Example |
|---|---|---|
| `openclaw integration list` | List all available integrations | `openclaw integration list` |
| `openclaw integration list --enabled` | List only enabled integrations | `openclaw integration list --enabled` |
| `openclaw integration info <name>` | View integration details and capabilities | `openclaw integration info github` |
| `openclaw integration enable <name>` | Enable an integration | `openclaw integration enable gmail` |
| `openclaw integration disable <name>` | Disable an integration | `openclaw integration disable spotify` |
| `openclaw integration config <name>` | Configure an integration (interactive) | `openclaw integration config github` |
| `openclaw integration test <name>` | Test connectivity to the service | `openclaw integration test gmail` |
| `openclaw integration status --all` | Health check all enabled integrations | `openclaw integration status --all` |
| `openclaw integration update --all` | Update all integration connectors | `openclaw integration update --all` |

### Cron and Scheduling Commands

| Command | Description | Example |
|---|---|---|
| `openclaw cron list` | List all cron jobs | `openclaw cron list` |
| `openclaw cron create` | Interactive cron job creation | `openclaw cron create` |
| `openclaw cron create --file <path>` | Create from a YAML definition file | `openclaw cron create --file morning-briefing.yaml` |
| `openclaw cron create --schedule "..." --action "..."` | Quick one-liner creation | `openclaw cron create --schedule "30 7 * * *" --action "Send briefing"` |
| `openclaw cron info <name>` | View cron job details | `openclaw cron info morning-briefing` |
| `openclaw cron history <name>` | View execution history | `openclaw cron history inbox-triage` |
| `openclaw cron history <name> --last <n>` | View the last N runs | `openclaw cron history inbox-triage --last 10` |
| `openclaw cron run <name> --now` | Trigger immediate execution | `openclaw cron run morning-briefing --now` |
| `openclaw cron pause <name>` | Pause a cron job | `openclaw cron pause eod-summary` |
| `openclaw cron resume <name>` | Resume a paused cron job | `openclaw cron resume eod-summary` |
| `openclaw cron delete <name>` | Delete a cron job | `openclaw cron delete pr-reminder` |

### Workflow Commands

| Command | Description | Example |
|---|---|---|
| `openclaw workflow list` | List all workflows | `openclaw workflow list` |
| `openclaw workflow create --file <path>` | Create a workflow from YAML | `openclaw workflow create --file pr-pipeline.yaml` |
| `openclaw workflow run <name>` | Run a workflow | `openclaw workflow run meeting-autopilot` |
| `openclaw workflow run <name> --verbose` | Run with detailed step-by-step output | `openclaw workflow run pr-pipeline --verbose` |
| `openclaw workflow test <name> --dry-run` | Simulate without executing | `openclaw workflow test pr-pipeline --dry-run` |
| `openclaw workflow test <name> --mock-trigger '...'` | Test with mock trigger data | `openclaw workflow test pr-pipeline --mock-trigger '{"repo":"test"}'` |
| `openclaw workflow history <name>` | View run history | `openclaw workflow history meeting-autopilot` |
| `openclaw workflow run-details <id>` | View a specific run's details | `openclaw workflow run-details abc123` |
| `openclaw workflow status --all` | Show status of all workflows | `openclaw workflow status --all` |
| `openclaw workflow pause <name>` | Pause a workflow | `openclaw workflow pause incident-response` |
| `openclaw workflow resume <name>` | Resume a paused workflow | `openclaw workflow resume incident-response` |
| `openclaw workflow delete <name>` | Delete a workflow | `openclaw workflow delete old-workflow` |

### Memory Commands

| Command | Description | Example |
|---|---|---|
| `openclaw memory stats` | View memory statistics (entry count, size, age) | `openclaw memory stats` |
| `openclaw memory search <query>` | Search memory entries by keyword | `openclaw memory search "project Phoenix"` |
| `openclaw memory list` | List all memory entries | `openclaw memory list` |
| `openclaw memory list --category <cat>` | List entries by category | `openclaw memory list --category preferences` |
| `openclaw memory export` | Export all memory as JSON | `openclaw memory export > backup.json` |
| `openclaw memory import` | Import memory from JSON | `openclaw memory import < backup.json` |
| `openclaw memory prune --older-than <duration>` | Remove entries older than the given duration | `openclaw memory prune --older-than 90d` |
| `openclaw memory optimize` | Summarize verbose entries to save tokens | `openclaw memory optimize` |
| `openclaw memory reset` | Delete all memory (destructive) | `openclaw memory reset` |

### Background Task Commands

| Command | Description | Example |
|---|---|---|
| `openclaw task list` | List all running background tasks | `openclaw task list` |
| `openclaw task status <id>` | Check status of a specific task | `openclaw task status abc123` |
| `openclaw task output <id>` | View completed task output | `openclaw task output abc123` |
| `openclaw task cancel <id>` | Cancel a running task | `openclaw task cancel abc123` |

### Browser Commands

| Command | Description | Example |
|---|---|---|
| `openclaw browser check` | Check browser engine installation | `openclaw browser check` |
| `openclaw browser install` | Install or reinstall the browser engine | `openclaw browser install` |

### Usage and Billing Commands

| Command | Description | Example |
|---|---|---|
| `openclaw usage --this-month` | Show current month's total usage and cost | `openclaw usage --this-month` |
| `openclaw usage --by skill --sort cost` | Break down usage by skill, sorted by cost | `openclaw usage --by skill --sort cost` |
| `openclaw usage --by model` | Break down usage by model | `openclaw usage --by model` |
| `openclaw usage --by channel` | Break down usage by channel | `openclaw usage --by channel` |
| `openclaw usage --daily --last <duration>` | Daily usage breakdown | `openclaw usage --daily --last 30d` |
| `openclaw usage --projection` | Projected end-of-month cost | `openclaw usage --projection` |

### Security and Audit Commands

| Command | Description | Example |
|---|---|---|
| `openclaw audit log --last <duration>` | View recent audit log entries | `openclaw audit log --last 24h` |
| `openclaw audit log --filter <type>` | Filter by event type | `openclaw audit log --filter shell_command` |
| `openclaw audit log --filter <type> --path "..."` | Filter by event type and path | `openclaw audit log --filter file_write --path "~/Documents/*"` |

### Testing and Debugging Commands

| Command | Description | Example |
|---|---|---|
| `openclaw test llm` | Test LLM provider connection | `openclaw test llm` |
| `openclaw test all` | Test all connections (LLM, channels, integrations) | `openclaw test all` |
| `openclaw debug --profile "..."` | Profile a request for latency diagnosis | `openclaw debug --profile "What's on my calendar?"` |
| `openclaw run "..." --headless` | Run a single prompt non-interactively | `openclaw run "List open PRs" --headless` |
| `openclaw run --stdin --headless` | Pipe input for non-interactive execution | `echo "Summarize" \| openclaw run --stdin --headless` |
| `openclaw run "..." --headless --output json` | Non-interactive execution with JSON output | `openclaw run "List PRs" --headless --output json` |

---

## Channels

OpenClaw connects to 15 messaging platforms. Each channel is bidirectional -- you can send and receive messages, media, and commands.

| Channel | Setup Complexity | Auth Method | Rich Media | Group Support | Best For |
|---|---|---|---|---|---|
| **WhatsApp** | Medium | QR code pairing (linked device) | Images, docs | Yes | Personal, on-the-go tasks, urgent notifications |
| **Telegram** | Easy | Bot token via @BotFather | Full (markdown, files, stickers) | Yes | Power users, technical work, file sharing |
| **Slack** | Easy | Bot token + OAuth | Full (blocks, threads) | Yes | Workplace, team collaboration, standups |
| **Discord** | Easy | Bot token + OAuth2 URL | Full (embeds, reactions) | Yes | Communities, personal servers |
| **Signal** | Medium | Linked device protocol | Limited | Yes | Privacy-focused communication |
| **iMessage** | Hard | macOS system integration | Images | Yes | Apple ecosystem users (macOS only) |
| **Matrix** | Medium | Homeserver credentials | Full | Yes | Self-hosted, federated environments |
| **Microsoft Teams** | Medium | Azure app registration | Full | Yes | Enterprise workplace, Office 365 |
| **Google Chat** | Medium | Service account / OAuth | Limited | Yes | Google Workspace organizations |
| **Feishu** | Medium | App token | Full | Yes | Chinese enterprise teams |
| **LINE** | Easy | Channel token | Stickers, images | Yes | Asia-Pacific users |
| **Mattermost** | Easy | Webhook or bot token | Full | Yes | Self-hosted Slack alternative |
| **Control UI** | None | Built-in web chat at localhost | Full (markdown, images) | No | Direct interaction, no external account needed |
| **Email (SMTP)** | Medium | SMTP credentials | HTML, attachments | No | Outbound-only notifications and reports |
| **Webhook (inbound)** | Easy | HTTP endpoint | JSON payloads | No | Custom integrations, CI/CD triggers |

### Channel Capability Matrix

| Capability | WhatsApp | Telegram | Slack | Discord | Signal | iMessage | Teams |
|---|---|---|---|---|---|---|---|
| Text messages | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| Markdown rendering | No | Yes | Yes | Yes | No | No | Yes |
| Image send/receive | Yes | Yes | Yes | Yes | Limited | Yes | Yes |
| File send/receive | Yes | Yes | Yes | Yes | No | No | Yes |
| Voice message input | Yes | Yes | No | No | Yes | No | No |
| Slash commands | No | Yes | Yes | Yes | No | No | Yes |
| Thread replies | No | Yes | Yes | Yes | No | No | Yes |
| Reactions/emoji triggers | No | Yes | Yes | Yes | No | No | Yes |
| Per-channel permissions | Yes | Yes | Yes | Yes | Yes | Yes | Yes |

---

## Skills

Skills are modular, reusable capabilities installed from the community registry or created locally. They use three-level loading (metadata, instructions, resources) to minimize token usage.

### Productivity Skills

| Skill | Description | Triggers | Integrations Used |
|---|---|---|---|
| `daily-briefing` | Morning summary of calendar, email, tasks, weather | Cron (7:30 AM) or keyword "briefing" | Gmail, Calendar, Todoist, Weather API |
| `inbox-zero` | Auto-categorize and draft email responses | Cron (every 30 min) or keyword "triage" | Gmail |
| `meeting-summarizer` | Generate meeting notes, action items, follow-up drafts | Auto on meeting end (calendar trigger) | Calendar, Zoom, Slack |
| `expense-tracker` | OCR receipts, categorize expenses, generate reports | Image upload or keyword "expense" | Google Sheets, Browser (OCR) |
| `research-agent` | Deep web research with structured output and citations | Keyword "research [topic]" | Browser |
| `note-taker` | Capture and organize notes across tools | Keyword "note [content]" | Obsidian, Notion |

### Developer Skills

| Skill | Description | Triggers | Integrations Used |
|---|---|---|---|
| `github-pr-reviewer` | Automated code review with line-level suggestions | GitHub webhook (PR opened/synced) or keyword "review PR" | GitHub |
| `standup-reporter` | Generate daily standups from git history and calendar | Cron (9 AM weekdays) or keyword "standup" | GitHub, Calendar, Todoist |
| `ci-monitor` | Watch CI/CD pipelines, report failures and status | GitHub Actions webhook | GitHub |
| `dependency-checker` | Scan for outdated or vulnerable dependencies | Cron (weekly) or keyword "check deps" | GitHub, Shell |
| `release-notes` | Auto-generate release notes from commit history | Keyword "release notes for [version]" | GitHub |
| `code-explainer` | Explain code files or snippets in plain language | Keyword "explain [file/code]" | Filesystem |
| `test-generator` | Generate unit tests for source files | Keyword "generate tests for [file]" | Filesystem, Shell |

### Communication Skills

| Skill | Description | Triggers | Integrations Used |
|---|---|---|---|
| `email-manager` | Full email lifecycle: read, send, draft, label, archive | Keyword "email [action]" | Gmail, Outlook |
| `calendar-sync` | Cross-platform calendar management and scheduling | Keyword "calendar" or calendar event triggers | Google Calendar, Apple Calendar |
| `task-manager` | Sync and manage tasks across multiple tools | Keyword "task [action]" | Todoist, Things 3, Trello, Notion |
| `follow-up-tracker` | Track pending follow-ups and send reminders | Cron (daily) | Gmail, Memory |
| `personal-crm` | Track contacts, interactions, and relationship history | Keyword "log interaction" or "met with [name]" | Memory, Todoist |

### Automation Skills

| Skill | Description | Triggers | Integrations Used |
|---|---|---|---|
| `invoice-processor` | OCR invoices, extract data, log to spreadsheet | File watcher (~/Documents/invoices/*.pdf) | Browser (OCR), Google Sheets |
| `flight-checkin` | Auto check-in for flights 24 hours before departure | Calendar event trigger (-24h offset) | Browser, Calendar |
| `competitor-monitor` | Track competitor pricing and feature changes weekly | Cron (weekly) | Browser |

### Skill Categories for Browse

| Category | Skill Count | Browse Command |
|---|---|---|
| Productivity | 6 | `openclaw skill browse --category productivity` |
| Developer | 7 | `openclaw skill browse --category developer` |
| Communication | 5 | `openclaw skill browse --category communication` |
| Automation | 3 | `openclaw skill browse --category automation` |

---

## Integrations

OpenClaw supports 50+ bidirectional service connectors. Each integration can be enabled, configured, and tested independently.

### Productivity and Notes

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **Gmail** | OAuth 2.0 or App Password | Read, send, draft, label, archive, search, batch ops | `integrations.gmail` |
| **Google Calendar** | OAuth 2.0 | View schedule, create events, find free slots, RSVP, smart scheduling | `integrations.calendar` |
| **Apple Calendar** | System integration (macOS) | View schedule, create events, find free slots | `integrations.calendar` |
| **Obsidian** | Local filesystem | Create notes, search vault, append, link, tag management | `integrations.obsidian` |
| **Notion** | API token | Create pages, query databases, update properties | `integrations.notion` |
| **Todoist** | API token | Create/complete/update tasks, projects, labels, filters | `integrations.todoist` |
| **Things 3** | URL scheme (macOS) | Create/complete tasks, projects, areas | `integrations.things3` |
| **Trello** | API key + token | Create/move cards, manage boards and lists | `integrations.trello` |
| **Apple Reminders** | System integration (macOS) | Create/complete reminders, manage lists | `integrations.apple_reminders` |
| **Google Sheets** | OAuth 2.0 | Read/write cells, create sheets, append rows | `integrations.google_sheets` |
| **Airtable** | API token | Query/create records, manage bases | `integrations.airtable` |
| **Readwise** | API token | Retrieve highlights, sync reading list | `integrations.readwise` |
| **Pocket** | OAuth 2.0 | Save/retrieve articles, tag management | `integrations.pocket` |

### Developer Tools

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **GitHub** | Personal access token | PRs, issues, code review, CI/CD, releases, code search, webhooks | `integrations.github` |
| **GitLab** | Personal access token | Merge requests, issues, pipelines, releases | `integrations.gitlab` |
| **Jira** | Email + API token | Create/update issues, sprints, boards, transitions | `integrations.jira` |
| **Linear** | API token | Issues, cycles, projects, team management | `integrations.linear` |
| **Vercel** | API token | Deployments, projects, domains, environment variables | `integrations.vercel` |
| **Netlify** | API token | Deployments, sites, build hooks | `integrations.netlify` |
| **AWS** | Access key + secret | S3, EC2, Lambda, CloudWatch, cost explorer | `integrations.aws` |
| **Docker** | Local socket or remote API | Container management, image builds, compose | `integrations.docker` |
| **Kubernetes** | Kubeconfig | Pods, deployments, services, logs, rollouts | `integrations.kubernetes` |
| **Sentry** | API token | Error tracking, issue management, release health | `integrations.sentry` |
| **Datadog** | API key + app key | Metrics, monitors, dashboards, logs | `integrations.datadog` |
| **PagerDuty** | API token | Incidents, on-call schedules, escalations | `integrations.pagerduty` |
| **OpsGenie** | API token | Alerts, incidents, on-call management | `integrations.opsgenie` |
| **CircleCI** | API token | Pipeline status, triggers, artifacts | `integrations.circleci` |
| **Jenkins** | API token | Build triggers, status, logs | `integrations.jenkins` |

### Communication

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **Microsoft Outlook** | Azure AD (OAuth 2.0) | Email, calendar, contacts (Office 365) | `integrations.outlook` |
| **Zoom** | OAuth 2.0 | Schedule meetings, transcripts, join for note-taking | `integrations.zoom` |
| **Google Meet** | OAuth 2.0 | Schedule meetings, meeting links | `integrations.google_meet` |
| **Loom** | API token | Create/share video recordings | `integrations.loom` |
| **Twilio** | Account SID + auth token | SMS, voice calls, WhatsApp Business | `integrations.twilio` |
| **SendGrid** | API key | Transactional email, templates | `integrations.sendgrid` |
| **Mailchimp** | API key | Campaigns, audiences, automations | `integrations.mailchimp` |

### Smart Home and IoT

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **Philips Hue** | Bridge pairing (IP + username) | Lights, scenes, groups, schedules, sensors | `integrations.hue` |
| **Home Assistant** | Long-lived access token | All HA entities: lights, thermostats, locks, cameras, sensors | `integrations.home_assistant` |
| **Apple HomeKit** | System integration (macOS) | All HomeKit accessories and scenes | `integrations.homekit` |
| **IFTTT** | Webhook key | Trigger IFTTT applets from OpenClaw | `integrations.ifttt` |
| **SmartThings** | API token | Devices, scenes, automations | `integrations.smartthings` |

### Media and Personal

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **Spotify** | OAuth 2.0 | Play/pause, playlists, search, queue, recommendations | `integrations.spotify` |
| **Apple Music** | System integration (macOS) | Play/pause, playlists, search, library | `integrations.apple_music` |
| **YouTube** | OAuth 2.0 | Search, playlists, subscriptions, watch later | `integrations.youtube` |
| **Apple Health** | System integration (macOS/iOS) | Steps, heart rate, sleep, workouts (read-only) | `integrations.apple_health` |
| **Strava** | OAuth 2.0 | Activities, training log, stats | `integrations.strava` |
| **Goodreads** | API key | Reading list, reviews, recommendations | `integrations.goodreads` |

### Finance

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **Plaid** | Client ID + secret | Bank accounts, transactions, balances, categorization | `integrations.plaid` |
| **Stripe** | Secret key | Payments, invoices, subscriptions, customers (recommend read-only) | `integrations.stripe` |
| **QuickBooks** | OAuth 2.0 | Invoices, expenses, reports | `integrations.quickbooks` |
| **Wise (TransferWise)** | API token | Transfers, balances, exchange rates | `integrations.wise` |
| **Coinbase** | API key + secret | Portfolio, prices, transactions (read-only recommended) | `integrations.coinbase` |

### Weather and Location

| Integration | Auth Method | Capabilities | Config Key |
|---|---|---|---|
| **OpenWeather** | API key | Current weather, forecasts, alerts | `integrations.openweather` |
| **Google Maps** | API key | Directions, places, distance, geocoding | `integrations.google_maps` |

### Integration Auth Method Summary

| Auth Method | Count | Examples |
|---|---|---|
| OAuth 2.0 | 15+ | Gmail, Spotify, Zoom, Stripe, Outlook |
| API Token / Key | 20+ | GitHub, Todoist, Linear, PagerDuty, Sentry |
| Local / System | 5 | Apple Calendar, Apple Health, HomeKit, Things 3, Apple Music |
| Bridge / Device Pairing | 2 | Philips Hue, SmartThings |
| Webhook | 2 | IFTTT, custom inbound |

---

## Automation Types

OpenClaw supports five trigger mechanisms for automated tasks.

| Type | Description | Config Key | Schedule/Condition | Use Cases |
|---|---|---|---|---|
| **Cron** | Time-based recurring schedule | `trigger.type: cron` | Standard cron syntax (e.g., `30 7 * * *`) | Morning briefing, inbox triage, EOD summary, weekly reports |
| **Webhook** | Inbound HTTP event from an external service | `trigger.type: webhook` | Source + event + action filter | GitHub PR opened, Stripe payment received, PagerDuty alert |
| **File Watcher** | Filesystem event on a watched path | `trigger.type: file_watcher` | Path + glob pattern + event (created/modified/deleted) | Invoice processing, CSV import, config change detection |
| **Calendar Event** | Calendar event start, end, or offset | `trigger.type: calendar_event` | Match pattern + offset (e.g., `-10m`) | Meeting prep, post-meeting notes, flight check-in |
| **Condition** | Periodic evaluation of a boolean expression | `trigger.type: condition` | Check interval + condition expression | Disk usage alert, stock price threshold, service health check |

### Cron Schedule Quick Reference

| Expression | Meaning |
|---|---|
| `30 7 * * *` | Every day at 7:30 AM |
| `0 9 * * 1-5` | Weekdays at 9:00 AM |
| `*/30 * * * *` | Every 30 minutes |
| `0 9-17/2 * * 1-5` | Every 2 hours during work hours, weekdays |
| `0 16 * * 5` | Every Friday at 4:00 PM |
| `0 0 1 * *` | First day of each month at midnight |
| `*/30 8-20 * * *` | Every 30 minutes between 8 AM and 8 PM |
| `0 8 * * 1` | Every Monday at 8:00 AM |

### Automation Error Handling Strategies

| Strategy | Config Value | Behavior |
|---|---|---|
| Skip | `on_error: skip` | Log the error and continue to the next step |
| Abort | `on_error: abort` | Stop the entire workflow and notify |
| Retry | `on_error: retry` | Retry with configurable attempts, delay, and backoff |
| Fallback | `on_error: fallback` | Execute an alternative step or notification |

---

## Workflow Patterns

Workflows orchestrate multiple skills, integrations, and tools into multi-step autonomous pipelines. Four reusable design patterns cover the majority of use cases.

### Pattern 1: Gather-Analyze-Act-Notify

| Attribute | Details |
|---|---|
| **Name** | Gather-Analyze-Act-Notify |
| **Description** | Collect data from multiple sources, analyze with LLM, take action, and notify the user. The most common workflow pattern. |
| **Steps** | 1. Gather data (integrations, shell, browser) 2. Analyze (LLM reasoning) 3. Act (create tasks, send emails, post reviews) 4. Notify (channel message) |
| **Example Workflows** | PR pipeline, inbox-to-action, morning briefing, incident response |
| **When to Use** | Any workflow that processes external data and produces a result or side effect |

### Pattern 2: Parallel Fanout

| Attribute | Details |
|---|---|
| **Name** | Parallel Fanout |
| **Description** | Execute multiple independent data-gathering steps simultaneously, then combine results into a single analysis step. |
| **Steps** | 1. Fan out to N parallel substeps 2. Wait for all to complete 3. Combine results in a single LLM call |
| **Example Workflows** | Incident response (logs + pods + metrics + deploys in parallel), multi-source research |
| **When to Use** | When you need data from multiple independent sources and want to minimize latency |

### Pattern 3: Conditional Branching

| Attribute | Details |
|---|---|
| **Name** | Conditional Branching |
| **Description** | Classify input or evaluate a condition, then route execution to different paths based on the result. |
| **Steps** | 1. Classify or evaluate 2. Branch to Path A or Path B (or more) based on condition 3. Converge at notification step |
| **Example Workflows** | Email triage (urgent/action/FYI/noise), content routing, severity-based incident response |
| **When to Use** | When different inputs require fundamentally different handling |

### Pattern 4: Loop with Exit Condition

| Attribute | Details |
|---|---|
| **Name** | Loop with Exit Condition |
| **Description** | Repeatedly execute a check-evaluate cycle until a condition is met or a maximum iteration count is reached. |
| **Steps** | 1. Execute check step 2. Evaluate result 3. If condition not met and under max iterations, goto step 1 (with delay) 4. If max iterations reached, alert |
| **Config** | `goto: <step>`, `max_iterations: N`, `delay: Ns` |
| **Example Workflows** | Service health polling, deployment verification, build status waiting |
| **When to Use** | When you need to wait for an external system to reach a desired state |

### Workflow Comparison Matrix

| Pattern | Complexity | Parallelism | Branching | Looping | Typical Steps |
|---|---|---|---|---|---|
| Gather-Analyze-Act-Notify | Low | Optional | No | No | 3-6 |
| Parallel Fanout | Medium | Yes | No | No | 4-8 |
| Conditional Branching | Medium | Optional | Yes | No | 4-10 |
| Loop with Exit Condition | Medium | No | Optional | Yes | 3-5 |

---

## Permission Modes

OpenClaw provides six permission levels that control what the assistant can access. Permissions can be set globally or per-channel.

| Mode | Shell Access | Filesystem | Browser | Config Changes | Cross-Channel | Use Case |
|---|---|---|---|---|---|---|
| **Locked** | None | None | None | None | No | Read-only Q&A, zero risk |
| **Restricted** | None | Read-only | None | None | No | Safe exploration, onboarding |
| **Standard** | Sandboxed (allowlisted commands) | Read-write (scoped to allowed paths) | Headless only | None | Yes | Recommended daily use |
| **Trusted** | Full shell access | Read-write (all user paths) | Full (headless + visible) | None | Yes | Power users, developers |
| **Admin** | Full shell access | Full (including system paths) | Full | Yes (can modify config.yaml) | Yes | System configuration, setup |
| **Custom** | Configurable per-command | Configurable per-path (allow/deny lists) | Configurable per-domain | Configurable | Configurable | Fine-grained enterprise policies |

### Custom Mode Configurable Dimensions

| Dimension | Options | Example |
|---|---|---|
| Shell commands | Allowlist and denylist with glob patterns | Allow `git *`, `npm *`; deny `rm -rf *`, `sudo *` |
| Filesystem paths | Allowed paths and denied paths | Allow `~/Documents`, `~/Projects`; deny `~/.ssh`, `~/.aws` |
| Browser domains | Allowed domains and blocked domains | Allow `*.acme.com`, `github.com`; block `*.malware.com` |
| Network domains | Allowed outbound domains | Allow `api.anthropic.com`, `api.github.com` |
| Max request/response size | Size limits for network calls | `max_request_size: 10MB`, `max_response_size: 50MB` |
| Token limits | Max tokens per message per channel | `max_tokens_per_message: 4096` (WhatsApp), `16384` (Slack) |

### Per-Channel Permission Override

Channels can override the global permission mode to apply stricter controls:

| Channel | Recommended Mode | Rationale |
|---|---|---|
| WhatsApp | Restricted | Mobile channel, higher compromise risk |
| Telegram | Trusted | Power user primary channel |
| Slack | Trusted | Workplace with team visibility |
| Discord | Standard | Community channel, moderate trust |
| Signal | Restricted | Privacy-focused, limited capabilities |
| iMessage | Restricted | System integration, limited control |
| Control UI | Admin | Direct local access, full trust |

---

## Model Options

OpenClaw supports multiple LLM providers and models. Automatic routing sends each task to the optimal model based on complexity, cost, and privacy requirements.

### Anthropic Models

| Model | ID | Speed | Quality | Cost Tier | Context Window | Best For |
|---|---|---|---|---|---|---|
| Claude Opus 4.6 | `claude-opus-4-6` | Slow | Highest | $$$ | 200K tokens | Complex reasoning, code review, deep analysis, research |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | Medium | High | $$ | 200K tokens | Daily tasks, email drafting, automation, general use |
| Claude Haiku 4.5 | `claude-haiku-4-5` | Fast | Good | $ | 200K tokens | Quick queries, classification, routing, budget mode |

### OpenAI Models

| Model | ID | Speed | Quality | Cost Tier | Context Window | Best For |
|---|---|---|---|---|---|---|
| GPT-4.1 | `gpt-4.1` | Medium | High | $$ | 128K tokens | Alternative to Sonnet, general tasks |
| o3 | `o3` | Slow | Highest | $$$ | 200K tokens | Deep reasoning, math, complex logic |
| o4-mini | `o4-mini` | Fast | Good | $ | 128K tokens | Budget reasoning tasks |

### DeepSeek Models

| Model | ID | Speed | Quality | Cost Tier | Context Window | Best For |
|---|---|---|---|---|---|---|
| DeepSeek V3 | `deepseek-v3` | Fast | Good | $ | 128K tokens | Budget-friendly daily use |
| DeepSeek R1 | `deepseek-r1` | Medium | High | $ | 128K tokens | Budget reasoning and analysis |

### Ollama (Local) Models

| Model | ID | Speed | Quality | Cost Tier | Context Window | Best For |
|---|---|---|---|---|---|---|
| Llama 3.3 70B | `ollama/llama3.3:70b` | Local (GPU-dependent) | Good | Free | 128K tokens | Privacy-critical, airgapped, no API cost |
| Llama 3.3 8B | `ollama/llama3.3:8b` | Local (fast) | Moderate | Free | 128K tokens | Quick local classification, low-resource machines |
| Mistral Large | `ollama/mistral-large` | Local (GPU-dependent) | Good | Free | 32K tokens | European language tasks, local alternative |
| Qwen 2.5 72B | `ollama/qwen2.5:72b` | Local (GPU-dependent) | Good | Free | 128K tokens | Multilingual tasks, CJK languages |

### Model Routing Rules

| Rule Type | Condition | Routed Model | Rationale |
|---|---|---|---|
| Task complexity (high) | Keywords: review, analyze, debug, architect, decide, research | Claude Opus 4.6 | High-stakes tasks deserve the best model |
| Task complexity (low) | Keywords: remind, weather, time, translate, convert | Claude Haiku 4.5 | Simple tasks do not need Opus |
| Code generation | Keywords: write, code, implement, refactor, test | Claude Sonnet 4.6 | Good quality at reasonable cost |
| Sensitive content | Keywords: private, confidential, secret, internal | Ollama local model | Never send sensitive content to cloud APIs |
| Budget limit reached | `monthly_spend > budget * 0.8` | Claude Haiku 4.5 | Automatic downgrade to control costs |
| Per-skill override | Skill config `model` field | Any specified model | Skills can force a specific model |

### Provider Comparison

| Attribute | Anthropic | OpenAI | DeepSeek | Ollama |
|---|---|---|---|---|
| Requires API key | Yes | Yes | Yes | No |
| Data leaves your machine | Yes | Yes | Yes | No |
| Pricing model | Per-token | Per-token | Per-token | Free (hardware cost only) |
| Setup complexity | Low (API key) | Low (API key) | Low (API key) | Medium (install Ollama + pull model) |
| Offline capable | No | No | No | Yes |
| Best quality model | Claude Opus 4.6 | o3 | R1 | Llama 3.3 70B |
| Best budget model | Claude Haiku 4.5 | o4-mini | V3 | All (free) |

---

## Environment Variables

| Variable | Description | Required |
|---|---|---|
| `ANTHROPIC_API_KEY` | Anthropic API key for Claude models | If using Anthropic |
| `OPENAI_API_KEY` | OpenAI API key for GPT/o-series models | If using OpenAI |
| `OPENCLAW_HOME` | Override config directory (default: `~/.openclaw`) | No |
| `OPENCLAW_CONFIG` | Override config file path | No |
| `OPENCLAW_LOG_LEVEL` | Override log level (debug, info, warn, error) | No |
| `OPENCLAW_PORT` | Override Control UI server port | No |
| `OPENCLAW_AUTH_TOKEN` | Authentication token for Control UI | Recommended |
| `TELEGRAM_BOT_TOKEN` | Telegram bot token | If using Telegram |
| `SLACK_BOT_TOKEN` | Slack bot token | If using Slack |
| `SLACK_APP_TOKEN` | Slack app token (Socket Mode) | If using Slack |
| `DISCORD_BOT_TOKEN` | Discord bot token | If using Discord |
| `GITHUB_TOKEN` | GitHub personal access token | If using GitHub integration |
| `NOTION_TOKEN` | Notion API token | If using Notion |
| `TODOIST_TOKEN` | Todoist API token | If using Todoist |
| `SPOTIFY_CLIENT_ID` | Spotify OAuth client ID | If using Spotify |
| `SPOTIFY_CLIENT_SECRET` | Spotify OAuth client secret | If using Spotify |

---

## File Locations

| File / Directory | Path | Purpose |
|---|---|---|
| Main configuration | `~/.openclaw/config.yaml` | All settings |
| Secrets and API keys | `~/.openclaw/.env` | Environment variables (never commit) |
| Memory store | `~/.openclaw/memory/` | Persistent memory entries |
| Installed skills | `~/.openclaw/skills/` | Skill definitions and resources |
| Application logs | `~/.openclaw/logs/` | Runtime logs |
| Audit log | `~/.openclaw/logs/audit.log` | Security audit trail |
| Browser screenshots | `~/.openclaw/screenshots/` | Captured screenshots |
| Response cache | `~/.openclaw/cache/` | Cached responses |
| Browser cookies | `~/.openclaw/cookies/` | Persistent browser sessions |
| Downloads | `~/Downloads/openclaw/` | Browser-downloaded files |

---

## Cross-Reference Index

| If you need to... | See section |
|---|---|
| Install or update OpenClaw | CLI Commands > Core Commands |
| Connect a messaging platform | Channels |
| Add a new capability | Skills |
| Connect an external service | Integrations |
| Schedule a recurring task | Automation Types > Cron |
| React to an external event | Automation Types > Webhook |
| Build a multi-step pipeline | Workflow Patterns |
| Control what OpenClaw can access | Permission Modes |
| Choose the right AI model | Model Options |
| Debug a failing automation | CLI Commands > Testing and Debugging |
| Monitor costs | CLI Commands > Usage and Billing |
| Secure your installation | Permission Modes > Custom Mode |

---

## Recommended Companion Docs

- [OPERATIONS.md](OPERATIONS.md) -- weekly/monthly review checklists, reliability practices, cost monitoring
- [POWER_USER_PLAYBOOK.md](POWER_USER_PLAYBOOK.md) -- high-output habits and operator-level patterns
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) -- diagnosing the failures that actually matter in production

# Module 10: CLI Reference

> **Level:** Beginner | **Time:** 30 minutes | **Prerequisites:** [Module 01 - Getting Started](../01-getting-started/)

Complete command-line reference for the `openclaw` CLI.

---

## Installation

```bash
# Homebrew (macOS/Linux)
brew install openclaw-cli

# npm (all platforms)
npm install -g @openclaw/cli

# Verify
openclaw --version
```

---

## Command Reference

### Core Commands

| Command | Description |
|---|---|
| `openclaw start` | Start OpenClaw |
| `openclaw stop` | Stop OpenClaw |
| `openclaw restart` | Restart OpenClaw |
| `openclaw status` | Show running status |
| `openclaw logs` | View logs |
| `openclaw logs --tail 50` | View last 50 log lines |
| `openclaw logs --level error` | Filter by log level |
| `openclaw logs --follow` | Stream logs in real-time |
| `openclaw update` | Update to latest version |
| `openclaw --version` | Show version |
| `openclaw help` | Show help |
| `openclaw help <command>` | Show help for a command |

### Onboarding & Configuration

| Command | Description |
|---|---|
| `openclaw onboard` | Run the guided setup wizard |
| `openclaw config show` | Show current configuration |
| `openclaw config validate` | Validate config file |
| `openclaw config set <key> <value>` | Set a config value |
| `openclaw config get <key>` | Get a config value |
| `openclaw config reset` | Reset to defaults (keeps memory) |
| `openclaw config edit` | Open config in editor |
| `openclaw config path` | Show config file path |

### Channels

| Command | Description |
|---|---|
| `openclaw channel list` | List all channels |
| `openclaw channel list --detailed` | List with setup instructions |
| `openclaw channel pair <name>` | Connect a channel |
| `openclaw channel test <name>` | Test channel connection |
| `openclaw channel status` | Show all channel statuses |
| `openclaw channel status <name>` | Show specific channel status |
| `openclaw channel disconnect <name>` | Disconnect a channel |
| `openclaw channel logs <name>` | View channel-specific logs |

### Skills

| Command | Description |
|---|---|
| `openclaw skill list` | List installed skills |
| `openclaw skill search <query>` | Search community registry |
| `openclaw skill browse --category <cat>` | Browse by category |
| `openclaw skill info <name>` | View skill details |
| `openclaw skill install <name>` | Install a skill |
| `openclaw skill install <name>@<version>` | Install specific version |
| `openclaw skill install <git-url>` | Install from Git |
| `openclaw skill install ./<path>` | Install from local path |
| `openclaw skill update <name>` | Update a skill |
| `openclaw skill update --all` | Update all skills |
| `openclaw skill enable <name>` | Enable a skill |
| `openclaw skill disable <name>` | Disable a skill |
| `openclaw skill remove <name>` | Remove a skill |
| `openclaw skill config <name>` | View/edit skill config |
| `openclaw skill test <name>` | Run skill tests |
| `openclaw skill test <name> --dry-run` | Simulate without executing |
| `openclaw skill run <name>` | Run a skill manually |
| `openclaw skill run <name> --verbose` | Run with detailed output |
| `openclaw skill history <name>` | View execution history |
| `openclaw skill validate ./<path>` | Validate a custom skill |
| `openclaw skill publish ./<path>` | Publish to registry |

### Integrations

| Command | Description |
|---|---|
| `openclaw integration list` | List all integrations |
| `openclaw integration list --enabled` | List enabled only |
| `openclaw integration info <name>` | View integration details |
| `openclaw integration enable <name>` | Enable an integration |
| `openclaw integration disable <name>` | Disable an integration |
| `openclaw integration config <name>` | Configure an integration |
| `openclaw integration test <name>` | Test connectivity |
| `openclaw integration status --all` | Health check all integrations |
| `openclaw integration update --all` | Update all integrations |

### Cron / Scheduling

| Command | Description |
|---|---|
| `openclaw cron list` | List all cron jobs |
| `openclaw cron create` | Interactive cron creation |
| `openclaw cron create --file <path>` | Create from YAML file |
| `openclaw cron create --schedule "..." --action "..."` | Quick create |
| `openclaw cron info <name>` | View job details |
| `openclaw cron history <name>` | View run history |
| `openclaw cron history <name> --last 10` | Last N runs |
| `openclaw cron run <name> --now` | Run immediately |
| `openclaw cron pause <name>` | Pause a job |
| `openclaw cron resume <name>` | Resume a job |
| `openclaw cron delete <name>` | Delete a job |

### Workflows

| Command | Description |
|---|---|
| `openclaw workflow list` | List all workflows |
| `openclaw workflow create --file <path>` | Create from YAML |
| `openclaw workflow run <name>` | Run a workflow |
| `openclaw workflow run <name> --verbose` | Run with detailed output |
| `openclaw workflow test <name> --dry-run` | Simulate |
| `openclaw workflow test <name> --mock-trigger '...'` | Test with mock data |
| `openclaw workflow history <name>` | View run history |
| `openclaw workflow run-details <id>` | View specific run |
| `openclaw workflow status --all` | Status of all workflows |
| `openclaw workflow pause <name>` | Pause a workflow |
| `openclaw workflow resume <name>` | Resume a workflow |
| `openclaw workflow delete <name>` | Delete a workflow |

### Memory

| Command | Description |
|---|---|
| `openclaw memory stats` | View memory statistics |
| `openclaw memory search <query>` | Search memory entries |
| `openclaw memory list` | List all memory entries |
| `openclaw memory list --category <cat>` | List by category |
| `openclaw memory export` | Export memory as JSON |
| `openclaw memory import` | Import memory from JSON |
| `openclaw memory prune --older-than 90d` | Prune old entries |
| `openclaw memory optimize` | Summarize verbose entries |
| `openclaw memory reset` | Reset all memory (destructive!) |

### Background Tasks

| Command | Description |
|---|---|
| `openclaw task list` | List running tasks |
| `openclaw task status <id>` | Check task status |
| `openclaw task output <id>` | View task output |
| `openclaw task cancel <id>` | Cancel a running task |

### Browser

| Command | Description |
|---|---|
| `openclaw browser check` | Check browser engine |
| `openclaw browser install` | Install browser engine |

### Usage & Billing

| Command | Description |
|---|---|
| `openclaw usage --this-month` | This month's usage |
| `openclaw usage --by skill --sort cost` | Usage by skill |
| `openclaw usage --by model` | Usage by model |
| `openclaw usage --by channel` | Usage by channel |
| `openclaw usage --daily --last 30d` | Daily breakdown |
| `openclaw usage --projection` | Projected month-end cost |

### Security & Audit

| Command | Description |
|---|---|
| `openclaw audit log --last 24h` | View recent audit log |
| `openclaw audit log --filter <type>` | Filter by event type |
| `openclaw audit log --filter file_write --path "~/..."` | Filter by path |

### Testing & Debugging

| Command | Description |
|---|---|
| `openclaw test llm` | Test LLM connection |
| `openclaw test all` | Test all connections |
| `openclaw debug --profile "..."` | Profile a request |
| `openclaw run "..." --headless` | Run non-interactively |
| `openclaw run --stdin --headless` | Pipe input |
| `openclaw run "..." --headless --output json` | JSON output |

---

## Global Flags

| Flag | Description |
|---|---|
| `--version` | Show version number |
| `--help` | Show help |
| `--verbose` | Verbose output |
| `--quiet` | Suppress output |
| `--config <path>` | Use alternate config file |
| `--no-color` | Disable color output |
| `--json` | Output as JSON |

---

## Environment Variables

| Variable | Description |
|---|---|
| `OPENCLAW_HOME` | Override config directory (default: `~/.openclaw`) |
| `OPENCLAW_CONFIG` | Override config file path |
| `OPENCLAW_LOG_LEVEL` | Override log level |
| `OPENCLAW_PORT` | Override server port |
| `ANTHROPIC_API_KEY` | Anthropic API key |
| `OPENAI_API_KEY` | OpenAI API key |
| `OPENCLAW_AUTH_TOKEN` | Control UI auth token |

---

## File Locations

| File | Path | Purpose |
|---|---|---|
| Configuration | `~/.openclaw/config.yaml` | Main configuration |
| Environment | `~/.openclaw/.env` | API keys and secrets |
| Memory | `~/.openclaw/memory/` | Persistent memory store |
| Skills | `~/.openclaw/skills/` | Installed skills |
| Logs | `~/.openclaw/logs/` | Application logs |
| Audit | `~/.openclaw/logs/audit.log` | Audit trail |
| Screenshots | `~/.openclaw/screenshots/` | Browser screenshots |
| Cache | `~/.openclaw/cache/` | Response cache |
| Cookies | `~/.openclaw/cookies/` | Browser cookies |

---

## Troubleshooting Quick Reference

| Problem | Solution |
|---|---|
| Port in use | `lsof -i :3000` then change port or kill process |
| API key invalid | `openclaw config validate` then `openclaw test llm` |
| Channel won't connect | `openclaw channel test <name>` then re-pair |
| Slow responses | `openclaw debug --profile "test query"` |
| High costs | `openclaw usage --by skill --sort cost` |
| Memory bloat | `openclaw memory stats` then `openclaw memory prune` |
| Skill fails | `openclaw skill test <name> --verbose` |
| Config broken | `openclaw config validate` or `openclaw config reset` |

---

## Key Takeaways

- Every feature is accessible via the CLI — the Control UI is optional
- Use `openclaw help <command>` for detailed help on any command
- `--dry-run` and `--verbose` flags are your best friends for debugging
- `openclaw test all` validates your entire setup in one command
- File locations are predictable: everything lives under `~/.openclaw/`

---

## What's Next

1. **[QUICK_REFERENCE.md](../QUICK_REFERENCE.md)** — Printable cheat sheet of the most-used commands
2. **[CATALOG.md](../CATALOG.md)** — Full catalog of 95+ commands with examples
3. **[POWER_USER_PLAYBOOK.md](../POWER_USER_PLAYBOOK.md)** — CLI-driven workflows and productivity patterns

Something not working? See the [Troubleshooting Guide](../TROUBLESHOOTING.md) for systematic diagnosis starting from `openclaw status`.

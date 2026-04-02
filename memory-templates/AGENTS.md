# Agent Configuration

## Default Behavior

- **Model:** claude-sonnet-4-6
- **Tone:** Direct, no filler phrases, no "Great question!"
- **Response length:** Match the complexity of the task — short for quick lookups, detailed for analysis
- **Code style:** [preferred language, naming conventions, etc.]
- **Branch strategy:** [trunk-based | gitflow]

## Specialized Agents

| Agent | Purpose | Trigger |
|-------|---------|---------|
| pr-reviewer | Reviews assigned PRs. Approves or requests changes. Flags security issues. | Scheduled |
| morning-briefer | Daily briefing: calendar, GitHub, email highlights | Cron |
| task-triager | Prioritizes open tasks by deadline and impact | Cron |

## Escalate to Me When

- Any destructive operation (delete files, drop tables, rm -rf, force push)
- Pushing to main/trunk
- Sending messages as me (emails, Slack DMs, PR comments on my behalf)
- Spending > $1 in a single operation
- Anything irreversible

## Trust Level

- **Bash commands:** allowed for read-only; confirm before write
- **GitHub:** allowed to read, comment, approve; confirm before merge
- **External APIs:** allowed to read; confirm before write/send

# Heartbeat — Recurring Automations

These run automatically. Update this file when you add or change automations.

| Name | Schedule | What it does | Channel | Status |
|------|----------|--------------|---------|--------|
| morning-briefing | Weekdays 7:30am | Calendar + GitHub PRs + email summary | telegram | ✓ active |
| pr-review | Weekdays 9:00am | Review all assigned PRs | telegram | ✓ active |
| eod-summary | Weekdays 6:00pm | What shipped today + tomorrow's priorities | telegram | ✓ active |
| weekly-report | Fridays 5:00pm | Weekly metrics and highlights | telegram | ✓ active |

## Verify

```bash
openclaw cron list
```

## Add a New Automation

1. Copy a template from `templates/` and customize it
2. Run: `openclaw workflow import my-template.yaml`
3. Add a row to the table above

## Notes

[Any context about why specific automations are configured as they are]

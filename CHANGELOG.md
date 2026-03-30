# Changelog

All notable changes to the **OpenClaw How-To** guide will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [v1.1.0] -- 2026-03-31

### Added

- **POWER_USER_PLAYBOOK.md:** Complete guide covering the 2-hour setup, productivity stack (workspace files, memory, daily automations, high-value workflows, weekly maintenance), operator mode principles, author-level habits, default setup recommendations, first-week plan, and anti-patterns.
- **OPENCLAW_PRODUCTIVITY_STACK.md:** One-page compact blueprint for maximizing work output with OpenClaw.
- **OPERATIONS.md:** Operational guide covering weekly and monthly review checklists with actionable CLI commands, reliability practices, change ladder, backup strategy, multi-machine guidance, and promotion/retirement rules.
- **TROUBLESHOOTING.md:** Deep troubleshooting guide covering 13 failure categories: startup, channels, cron, workflow output, skill failures, error handling modes, memory problems, browser/UI automation, integration auth, cost spikes, operational drift, recovery playbook, and common root causes.

### Improved

- **Cross-links:** Added consistent cross-links to OPERATIONS, POWER_USER_PLAYBOOK, TROUBLESHOOTING, QUICK_REFERENCE, CATALOG, and LEARNING-ROADMAP across all 10 modules.
- **Troubleshooting:** Added skill failures section (Section 5) with diagnosis commands, debug flow, and fix patterns.
- **Troubleshooting:** Expanded recovery playbook (Section 12) with step-by-step CLI commands for each layer of the stack.
- **Operations:** Added actionable CLI commands to weekly and monthly review checklists, replacing prose-only guidance.
- **Operations:** Added Upgrade Playbook with pre-upgrade snapshot, post-upgrade verification, rollback procedure, timing guidance, and community skill compatibility steps.
- **Troubleshooting:** Cross-linked upgrade drift fix to the new Upgrade Playbook.
- **Quick Reference:** Added "broken after upgrade" entry to common troubleshooting table.
- **Getting Started:** Added troubleshooting cross-link matching all other modules.
- **Contributing:** Updated to reference `trunk` as the target branch instead of `main`.
- **README:** Redesigned for visual appeal with badges, module grid, learning path diagram, use-case mind map, and time-savings table.

---

## [v1.0.0] -- 2026-03-30

### Features

- **Module 01 -- Getting Started:** Installation on macOS, Linux, and Windows (WSL2); configuration walkthrough; API key setup; first interaction; Control UI dashboard overview.
- **Module 02 -- Channels:** Connection guides for 15+ messaging platforms; multi-channel routing rules; per-channel permissions and best practices.
- **Module 03 -- Memory:** Persistent memory architecture; memory stack explanation; teaching OpenClaw about yourself; memory commands; auditing and pruning strategies.
- **Module 04 -- Skills:** Skill system explained; installing community skills; creating custom skills with `skill.yaml`; skill chaining and pipelines; three-level loading; sharing skills.
- **Module 05 -- Integrations:** 50+ service connectors covering productivity (Obsidian, Notion, Todoist), communication (Gmail, Calendar), developer tools (GitHub, Jira, Linear), smart home (Hue, HomeKit), media (Spotify), and finance (Plaid, Stripe).
- **Module 06 -- Automation:** Cron jobs and scheduling; event-driven triggers; background tasks; morning briefings, EOD summaries, inbox triage, and PR reminders.
- **Module 07 -- Browser Automation:** Headless and visible browser control; web research with citations; form filling; data extraction; visual testing; screenshot workflows.
- **Module 08 -- Workflows:** Multi-step autonomous pipelines; PR review pipeline; meeting autopilot; research-to-decision pipeline; incident response; personal CRM; workflow templates.
- **Module 09 -- Advanced Features:** Model selection and routing; permission modes; security hardening; performance tuning; cost optimization; network policies; sensitive data handling; local model fallback.
- **Module 10 -- CLI Reference:** Complete `openclaw` command documentation; flags, options, and examples; configuration management; troubleshooting; debug mode.

### Documentation

- **LEARNING-ROADMAP.md:** Structured 3-level progression (Beginner, Intermediate, Advanced) with milestones and self-assessment criteria.
- **QUICK_REFERENCE.md:** Cheat sheets, command tables, and lookup guides for daily use.
- **CATALOG.md:** Complete feature inventory of commands, skills, and integrations.
- **CONTRIBUTING.md:** Contribution guidelines covering writing standards, style guide, security guidelines, and submission process.
- **README.md:** Project overview with learning path, use-case mind map, module summaries, and quick-start instructions.

---

<!-- Comparison URLs -->
[v1.1.0]: https://github.com/openclaw/openclaw-howto/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/openclaw/openclaw-howto/releases/tag/v1.0.0

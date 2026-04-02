# AGENTS.md — AI Agent Guide

> **Start here.** This file is the entry point for any AI agent working in this repo.
> Read this before reading anything else.

## What This Repo Is

`openclaw-howto` is the canonical how-to guide for OpenClaw — an open-source AI assistant.
It contains 11 learning modules, 7 production-ready YAML templates, 3 setup scripts, and
extensive reference documentation.

**Your job as an agent:** improve the repo — fix gaps, add examples, update outdated content,
add new templates, or optimize for a specific use case. This file tells you the rules.

---

## How to Navigate Efficiently

Don't read everything. Use this order:

1. **`.agents/metadata.yaml`** — machine-readable index of every module, template, and script
   with difficulty, keywords, prerequisites, and status. Start here to find what's relevant.
2. **`.agents/glossary.yaml`** — controlled vocabulary. Always check this before introducing
   new terminology.
3. **`CATALOG.md`** — full command/feature inventory. Check before adding docs for existing features.
4. **`QUICK_REFERENCE.md`** — most commonly needed commands in one place.
5. **Module READMEs** (`01-getting-started/README.md` etc.) — individual topic deep-dives.
6. **`templates/`** — YAML workflow definitions. These are the most copy-pasteable artifacts.

---

## Conventions (Follow These Exactly)

### File naming
- Modules: `NN-kebab-case/README.md` (two-digit prefix)
- Templates: `kebab-case.yaml`
- Scripts: `kebab-case.sh`
- Agent metadata: `.agents/*.yaml`

### Module README structure
Every module README must have this exact frontmatter comment block at the top:

```markdown
<!--
module: NN
title: Human-readable title
difficulty: beginner | intermediate | advanced
time: Xh or Xm
prerequisites: [list of module numbers or "none"]
keywords: [comma-separated keywords]
status: stable | draft | needs-update
-->
```

### Template structure
All YAML templates must include: `name`, `description`, `version`, `trigger`, `config`, `steps`.
Steps must use the tool names defined in `.agents/glossary.yaml`.

### Writing style
- Present tense, imperative mood for instructions ("Run this command", not "You should run")
- No filler phrases ("Simply", "Just", "Easy", "Note that")
- Code examples over prose explanations
- Tables over bullet lists where there are 3+ comparable items

---

## What You Can Improve

**High-value tasks (do these first):**
- Add missing frontmatter to module READMEs (check `.agents/metadata.yaml` `frontmatter: false`)
- Add templates for common use cases not yet covered
- Fix any `status: needs-update` entries in metadata
- Add a self-check quiz section to any module that lacks one

**Medium-value tasks:**
- Add cross-links between related modules where `related_modules` in metadata suggests them
- Improve code examples with realistic, copy-pasteable values
- Add a "Common Mistakes" section to modules that don't have one

**Low-value (avoid unless explicitly asked):**
- Reformatting content that already follows conventions
- Adding introductory paragraphs to modules
- Changing terminology (check glossary first)

---

## What NOT to Do

- **Don't rename files** — external links and the module numbering system are stable
- **Don't change glossary terms** without updating all usages across the repo
- **Don't add new top-level documentation files** without adding them to `CATALOG.md` and
  updating `.agents/metadata.yaml`
- **Don't introduce a new tool name** in a template without adding it to `.agents/glossary.yaml`
- **Don't remove content** — mark it `status: deprecated` in metadata instead

---

## How to Add a New Module

1. Create `NN-module-name/README.md` (next available two-digit number)
2. Add frontmatter block (see Conventions above)
3. Follow the existing module structure: What You'll Learn → Concepts → Examples → Exercises → Next Steps
4. Add entry to `.agents/metadata.yaml` under `modules`
5. Add entry to root `README.md` module table
6. Add entry to `LEARNING-ROADMAP.md` in the correct difficulty tier
7. Add to `CATALOG.md` if it introduces new commands

## How to Add a New Template

1. Create `templates/kebab-name.yaml`
2. Include all required fields (name, description, version, trigger, config, steps)
3. Add entry to `.agents/metadata.yaml` under `templates`
4. Add entry to `templates/README.md`

---

## Controlled Vocabulary

See `.agents/glossary.yaml` for the full list. Key terms:

| Term | Meaning | Do NOT use |
|------|---------|------------|
| `skill` | A reusable, named capability invoked with `/skillname` | plugin, command, macro |
| `workflow` | A multi-step automation defined in YAML | pipeline, job, task |
| `trigger` | An event that starts a workflow | hook, listener, watcher |
| `channel` | An output target (Telegram, Slack, WhatsApp, etc.) | integration, sink |
| `integration` | A connected external service (GitHub, Gmail, etc.) | connector, plugin |
| `cron` | A time-based scheduled automation | scheduler, timer |

---

## Machine-Readable Inventory

`.agents/metadata.yaml` is the authoritative index. It contains every module, template,
and script with structured properties. When you add or change content, update this file.

Format for querying with `yq` or Python:
```bash
# List all modules with status=needs-update
yq '.modules[] | select(.status == "needs-update") | .title' .agents/metadata.yaml

# List all templates by trigger type
yq '.templates[] | [.name, .trigger_type] | @tsv' .agents/metadata.yaml
```

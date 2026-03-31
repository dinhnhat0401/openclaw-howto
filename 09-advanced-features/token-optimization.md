# Token Optimization Guide

Reduce token consumption in Claude Code sessions. Every message re-sends the full conversation history, tool schemas, and system prompts — costs add up fast.

## Input Token Reduction

### 1. Start Fresh Conversations Often
The biggest lever. Each message re-sends the entire history. A 50-message conversation costs 10-50x more per turn than a fresh one.

**Rule of thumb:** New conversation per task or when switching context.

### 2. Use `/compact` Between Tasks
Compresses conversation history while preserving key context. Do this before starting a new task within the same session.

### 3. Limit Tool Schemas
Every available tool definition is sent with each message. If you have many MCP tools or custom tools configured, each one adds ~200-500 tokens per turn.

- Disable MCP servers you're not actively using
- Remove unused tool configurations from `settings.json`

### 4. Keep Messages Short
Your messages are re-sent in history too. "do it" beats "could you please go ahead and implement all of the changes we discussed earlier".

## Output Token Reduction

### 5. Tell Claude to Be Concise
Add to your project's `CLAUDE.md`:
```
Be extremely concise. Short responses. Surgical edits only.
```

Or add a memory/feedback entry — Claude will remember across sessions.

### 6. Prefer `Edit` Over `Write`
`Edit` sends only the diff (~50 tokens). `Write` sends the entire file content (~500-5000 tokens). Never rewrite a whole file when you can patch it.

### 7. Use `offset`/`limit` When Reading Files
```
Read file.swift offset=50 limit=20  # reads 20 lines starting at line 50
```
Instead of reading 500 lines when you need 20.

### 8. Avoid Unnecessary Reads
Don't re-read files you already have context on from the same conversation.

## Architecture-Level Optimization

### 9. Use Subagents for Research
Subagents run in their own context window. Their full exploration output doesn't bloat the main conversation — only the summary comes back.

### 10. Batch Related Changes
Make multiple `Edit` calls in one turn instead of spreading them across many turns (each turn re-sends full history).

### 11. Use Haiku for Simple Tasks
For straightforward tasks (formatting, renaming, simple searches), specify `model: haiku` in agent calls. 10x cheaper per token.

## Measuring Usage

Monitor your token usage:
- Check the Claude Code status bar for per-message costs
- Watch for conversations where each turn costs more than the last — that's history growth
- If a turn costs >$0.50, it's time for a new conversation

## Quick Checklist

- [ ] New conversation per task
- [ ] `/compact` when switching context
- [ ] `CLAUDE.md` says "be concise"
- [ ] Disable unused MCP tools
- [ ] Check that edits use `Edit` not `Write`

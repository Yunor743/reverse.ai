---
name: learn
description: Use when a problem or task requires multiple iterations (5 or more attempts). Automatically captures the problem, context, steps attempted, and solutions found into a structured learning note for future reference and self-improvement.
---

# Learn — Persistent Problem-Solving Memory

This skill triggers **automatically** when you iterate on the same problem or task **5 or more times**. Reaching 5 iterations signals a genuinely hard or recurring problem that is worth recording for future reference.

## When to trigger

- You attempted a fix/solution and it **failed** or was **incomplete** 5 or more times.
- You are going back and forth on a task extensively (5+ rounds of trial-and-error, debugging, refining).
- You encountered an unexpected error, blocker, or edge case that required 5+ rounds of rework.
- You solved a problem that required significantly more effort than initially expected (5+ iterations).

**Do NOT trigger for**: one-shot answers, trivial edits, straightforward tasks completed on the first attempt.

## Workflow

When the trigger condition is met:

### Step 1 — Create a learning note

Create a markdown file under `~/.config/opencode/learn/` with this naming convention:

```
~/.config/opencode/learn/YYYY-MM-DD_<short-slug>.md
```

Example: `~/.config/opencode/learn/2026-06-23_docker-network-dns-resolution.md`

### Step 2 — Structure of the note

Every learning note **must** contain these sections:

```markdown
# <Problem Title>

## Problem
Clear, concise description of the problem encountered.

## Context
- Project / repo / environment details
- Relevant technologies, frameworks, versions
- What was being attempted when the problem arose

## Steps Attempted
Chronological list of attempts:

1. **Attempt 1** — What was tried → What happened (failed/incomplete)
2. **Attempt 2** — What was tried → What happened (failed/incomplete)
3. **Attempt N** — ...

## Solution
The final working solution, with enough detail to reproduce it.

## Key Takeaway
1-3 bullet points capturing the essential lesson. This is the distilled knowledge.
```

### Step 3 — Update on each new iteration

If you are iterating on an **already-recorded** problem (same session or future session):

1. **Check `~/.config/opencode/learn/`** for an existing note that matches the current problem.
2. If found, **append new attempts** to the "Steps Attempted" section and update "Solution" and "Key Takeaway" once resolved.
3. If not found, create a new note following Step 1 & 2.

### Step 4 — Consult past learnings proactively

Before starting a non-trivial task:

1. Scan `~/.config/opencode/learn/` for notes related to the current task's domain.
2. If relevant notes exist, read them and apply the lessons before attempting a solution.
3. This avoids repeating past mistakes and accelerates resolution.

## Rules

- **Be honest**: record failed attempts, not just successes. Failures are equally valuable.
- **Be specific**: include exact commands, file paths, error messages, version numbers.
- **Be concise**: the "Key Takeaway" section is the most important — make it sharp and actionable.
- **Never overwrite**: always append to existing notes; preserve the full iteration history.
- **Persist immediately**: create/update the note as soon as the trigger condition is met, not at the end of the session.

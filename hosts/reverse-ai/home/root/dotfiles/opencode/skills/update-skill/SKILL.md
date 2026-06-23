---
name: update-skill
description: Use when a previously called skill did not work as intended and required iteration to resolve the problem. Updates the faulty skill's SKILL.md so it works correctly next time. Trigger after noticing a skill's instructions were inaccurate, incomplete, or led to wrong results.
---

# Update Skill

This skill is triggered when you have called another skill and discovered that its instructions were inaccurate, incomplete, or did not produce the expected result — and you had to iterate or work around the issue to solve the problem.

## When to use

- You called a skill and its instructions led you to an incorrect or incomplete solution.
- You had to deviate from the skill's guidance, iterate, or patch things manually.
- The skill missed a step, referenced wrong paths, used outdated commands, or failed to account for an edge case.

## Workflow

1. **Identify the problem** — Pinpoint exactly what part of the skill's instructions failed or was insufficient. Note the specific step, command, path, or logic that was wrong.

2. **Locate the skill file** — Find the SKILL.md of the faulty skill. Check these locations in order:
   - `~/.config/opencode/skills/<skill-name>/SKILL.md` (global)
   - `.opencode/skills/<skill-name>/SKILL.md` (project)

3. **Read the current skill** — Read the full SKILL.md to understand its current content and structure.

4. **Apply the fix** — Edit the SKILL.md to correct the problematic part. The edit must:
   - Fix the specific instruction that was wrong.
   - Add any missing steps or edge cases you encountered.
   - Keep the rest of the skill intact — only change what needs changing.
   - Preserve the frontmatter format (`name` and `description` fields).
   - If the `description` itself was misleading, update it too.

5. **Verify the edit** — Re-read the updated SKILL.md to confirm it now accurately reflects what actually works.

6. **Summarize the change** — Briefly report what was wrong and what was fixed.

## Guidelines

- Do NOT rewrite the entire skill — only fix what was broken.
- Preserve the skill's original structure and tone.
- If the skill's `description` no longer matches its behavior, update it.
- If you discovered a new edge case, add it explicitly in the body.
- If a referenced path, command, or file was wrong, correct it precisely.
- Always test your mental model: "If I followed this updated skill from scratch, would it work without iteration?"

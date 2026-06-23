---
name: create-skill
description: Use when the user wants to create, write, or scaffold a new opencode skill. Guides through naming, description, frontmatter, file placement, and validation of SKILL.md files.
---

# Create opencode skill

This skill helps you create new opencode skills correctly.

## Where skills live

| Scope       | Path                                              |
| ----------- | ------------------------------------------------- |
| Project     | `.opencode/skills/<name>/SKILL.md`                 |
| Global      | `~/.config/opencode/skills/<name>/SKILL.md`       |
| External    | `~/.claude/skills/<name>/SKILL.md`                 |

Always create the folder matching the skill name, then place `SKILL.md` inside.

## SKILL.md structure

```markdown
---
name: my-skill-name
description: One sentence covering WHAT the skill does AND WHEN to trigger it. Front-load concrete keywords and filenames the user is likely to say.
---

# My Skill Title

Body in markdown: instructions, examples, references.
```

## Rules to enforce

1. **`name`** — required, lowercase hyphen-separated, max 64 chars, must match the folder name.
2. **`description`** — effectively required (skills without one are filtered out). Third person ("Use when...", not "I help..."). Cover both _what_ and _when_. Front-load trigger keywords. Gate with "Use ONLY when..." if the skill should stay quiet on adjacent topics.
3. **Frontmatter** — only `name` and `description` are required. Optional: `license`, `compatibility`, `metadata` (string-string map).
4. **Body** — markdown only. No code execution, no scripts. The body is injected into the model context when the skill triggers, so keep it focused and actionable.
5. **File name** — must be exactly `SKILL.md` (case-sensitive), inside its own folder named after the skill.

## Workflow

When asked to create a skill:

1. Determine the skill's purpose and trigger conditions from the user's request.
2. Choose a short, descriptive, lowercase-hyphenated name (max 64 chars).
3. Write a `description` that front-loads keywords and covers both what and when.
4. Choose scope: global (`~/.config/opencode/skills/`) or project (`.opencode/skills/`). Default to global unless the user specifies a project.
5. Create the directory: `mkdir -p <scope>/skills/<name>`.
6. Write the `SKILL.md` file with frontmatter and body.
7. Tell the user to restart opencode for the skill to be loaded.

## Checklist before saving

- [ ] Folder name matches `name` in frontmatter exactly.
- [ ] File is named `SKILL.md` (not `skill.md`, not `README.md`).
- [ ] `description` uses third person and front-loads trigger keywords.
- [ ] `description` covers both WHAT the skill does and WHEN to use it.
- [ ] Body is focused, actionable, and in markdown.
- [ ] No unknown frontmatter fields (only `name`, `description`, optionally `license`, `compatibility`, `metadata`).
- [ ] Name is lowercase, hyphen-separated, max 64 chars.
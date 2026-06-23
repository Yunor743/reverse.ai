---
name: memory-first
description: Use when needing to recall, store, or verify information. Triggers on any question or task where the answer might already be known from a past interaction. Prompts the model to consult the memory MCP before searching externally, and to persist relevant information proactively.
---

# Memory-First

You have access to a **memory MCP** (knowledge graph) that persists across sessions. Treat it as your primary long-term memory.

## Core rules

1. **Consult memory first.** Before searching the web, reading files, or answering from training data alone, check your memory for relevant information. Use `memory_search_nodes` or `memory_read_graph` to look up entities, facts, or past decisions related to the current query.

2. **Save relevant information.** After learning something worth remembering — user preferences, project-specific conventions, important decisions, discovered facts, recurring patterns — proactively store it using `memory_create_entities`, `memory_add_observations`, or `memory_create_relations`. Do not wait to be asked.

3. **Keep memory accurate.** If you discover that a stored observation is outdated or incorrect, update it with `memory_add_observations` (add the corrected info) and `memory_delete_observations` (remove the stale one).

## When to consult memory

- A user asks a question you might have answered before.
- You need a project convention, preference, or context that may have been discussed in a prior session.
- You encounter a recurring problem or pattern.
- You are about to search externally for something that could already be known.

## When to save to memory

- The user states a preference, constraint, or rule (e.g. "I always use pnpm", "commit messages in French").
- You discover an important fact about the codebase, architecture, or tooling.
- You resolve a non-trivial problem that could recur.
- The user explicitly shares personal or project context worth retaining.

## How to use the memory tools

| Action | Tool |
|---|---|
| Search for info | `memory_search_nodes` |
| Browse everything | `memory_read_graph` |
| Open specific nodes | `memory_open_nodes` |
| Store a new entity | `memory_create_entities` |
| Add info to existing entity | `memory_add_observations` |
| Link two entities | `memory_create_relations` |
| Remove wrong info | `memory_delete_observations` |
| Remove an entity | `memory_delete_entities` |
| Remove a relation | `memory_delete_relations` |

## Principle

**Memory is your first reflex, not your last resort.** Always check before you look elsewhere, and always persist what matters.

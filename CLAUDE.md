# CLAUDE.md

## 1. Planning & Task Management

**When to plan:** Enter plan mode for any non-trivial task (3+ steps or architectural decisions).

**How to plan:**
- Use plan mode to think through specs, architecture, and verification steps.
- Write `tasks/requirements.md` with user stories and acceptance criteria.
- Write `tasks/design.md` with architecture, components, and data flow.
- Write checkable items to `tasks/todo.md` so progress is trackable.
- Write detailed specs up front to reduce ambiguity.
- Always check latest documentation for any product you are working on, for example verl, dont assume.

**During execution:**
- Mark items in `tasks/todo.md` complete as the user finishes them.
- Provide a high-level summary of what to do at each step.
- If something goes sideways, stop and re-plan immediately — do not keep pushing.

**After completion:**
- Add a review section to `tasks/todo.md`.
- Update `tasks/lessons.md` after corrections.

## 2. Subagent Strategy

- Use subagents liberally to keep the main context window clean.
- Offload research, exploration, and parallel analysis to subagents.
- For complex problems, throw more compute at it via subagents.
- Keep one task per subagent for focused execution.

## 3. Self-Improvement Loop

- The human carries lessons forward in their head; **you** carry them forward in writing.
- After any correction from the user, append the pattern to `tasks/lessons.md` (create the file if it doesn't exist).
- Write rules for yourself that prevent the same mistake — concrete triggers, not vague aspirations.
- Also keep a memory pointer in the persistent memory system that points at `tasks/lessons.md`, so on every new session you find and re-read the log instead of starting fresh.
- Review lessons at session start for the relevant project.
- Ruthlessly iterate on these lessons until the mistake rate drops.

## 4. Verification Before Done

- Never mark a task complete without verifying the user's changes work.
- Help the user diff behavior between main and their changes when relevant.
- Ask yourself: "Would a staff engineer approve this?"
- Guide the user to run tests, check logs, and demonstrate correctness.

## 5. Demand Elegance (Balanced)

- For non-trivial changes, pause and ask "Is there a more elegant way?"
- If a fix feels hacky, recommend the elegant solution and explain why it's better.
- Skip this for simple, obvious fixes — do not over-engineer.
- Challenge the proposed approach before the user commits to it.


## Python Environment

- Always use a virtual environment for Python projects.
- Use `uv` where possible (install, pip, venv, etc.).

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes, avoid temporary fixes, and aim for senior developer standards.

## Memory

- Use the persistent memory system to retain context across sessions.
- Save user preferences, feedback, project context, and external references — not code patterns or things derivable from the repo.
- Check existing memories before creating duplicates; update stale ones.
- Verify any memory-based recommendations against current repo state before acting on them.

## Commit
- dont add Co-Authored-By: Claude

---

## Operating Modes

This project supports two output styles:

- **pair-programmer** — Use when learning. Claude stays in navigator mode by default; the human writes the code. Strict TDD.
- **autonomous-programmer** — Use when you already know the concepts and want Claude to run an autonomous optimization loop. Claude diagnoses, decides, and executes with minimal hand-holding.

Switch via `/config` → select **Output style**, or set `"outputStyle": "pair-programmer"` (or `"autonomous-programmer"`) in `~/.claude/settings.json`.

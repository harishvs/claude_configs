# claude_configs

A portable, git-tracked configuration for [Claude Code](https://docs.claude.com/en/docs/claude-code). Clone it once, run the installer, and Claude Code will use the same global instructions and operating modes on every machine you work on.

## What this project is

Claude Code reads two kinds of configuration from your home directory:

1. **Global instructions** — `~/.claude/CLAUDE.md`. A markdown file Claude reads at the start of every session, on every project. Things like "always use a virtualenv for Python", "plan before coding", "don't add Co-Authored-By to commits".
2. **Output styles** — `~/.claude/output-styles/*.md`. Named "modes" you can switch between with `/output-style <name>`. Each mode tells Claude how to collaborate with you (e.g. pair-programmer, autonomous-programmer).

If you set these up by hand on each machine, they drift. This repo keeps them in one place. The files in `~/.claude/` become **symlinks** into the repo, so:

- Editing here updates `~/.claude/` instantly.
- `git pull` on another machine updates that machine instantly.
- Nothing to copy, nothing to remember.

## What you get

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Global instructions for Claude — planning rules, subagent strategy, verification expectations, Python/uv preference, memory hygiene, commit conventions. |
| `output-styles/pair-programmer.md` | "Pair programming" mode. Claude acts as the navigator; you write the code. Strict TDD. Use this when learning a new area. |
| `output-styles/autonomous-programmer.md` | "Autonomous" mode. Claude diagnoses, decides, and executes with minimal hand-holding. Use this when you already know the concepts and just want the work done. |
| `install.sh` | Sets up the symlinks on a new machine. Safe to re-run. |

## Prerequisites

- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed (`claude` on your `$PATH`).
- `git`.
- Linux or macOS (the installer uses `ln -s` and `bash`).

## First-time setup

```bash
git clone <repo-url> ~/claude_configs
cd ~/claude_configs
./install.sh
```

That's it. Open a new shell, `cd` into any project, run `claude`, and the global instructions will be active.

### What `install.sh` does

It creates these symlinks:

```
~/.claude/CLAUDE.md                            -> ~/claude_configs/CLAUDE.md
~/.claude/output-styles/pair-programmer.md     -> ~/claude_configs/output-styles/pair-programmer.md
~/.claude/output-styles/autonomous-programmer.md -> ~/claude_configs/output-styles/autonomous-programmer.md
```

If any of those paths already exist as real files, the script backs them up first with a `.bak.<timestamp>` suffix — your old config is preserved, not overwritten.

### Verify it worked

```bash
ls -la ~/.claude/CLAUDE.md
ls -la ~/.claude/output-styles/
```

You should see arrows (`->`) pointing into `~/claude_configs/`.

## Using it day to day

### In a new project

Nothing to do per project. Claude Code reads the global config from `~/.claude/` automatically. Just `cd` into the project and run `claude`.

If a specific project needs extra rules on top of the globals, drop a `CLAUDE.md` in the project root — Claude Code merges project-level and global instructions.

### Switching modes mid-session

```
/output-style pair-programmer
/output-style autonomous-programmer
```

The mode change takes effect on the next message.

### Editing the config

Edit either side — they're the same file via symlink:

```bash
# from the repo
vim ~/claude_configs/CLAUDE.md

# or directly through the symlink
vim ~/.claude/CLAUDE.md
```

Then commit from the repo:

```bash
cd ~/claude_configs
git add -A
git commit -m "describe the change"
git push
```

### Syncing to another machine

On the second machine, after the first-time setup is done:

```bash
cd ~/claude_configs
git pull
```

Changes are live immediately — no reinstall needed because the live files are symlinks.

## Customizing for yourself

This repo ships with one author's preferences. To make it yours:

1. Open `CLAUDE.md` and rewrite the rules you disagree with. Common things to adjust: planning style, subagent usage, Python tooling (`uv` vs `pip`), commit conventions.
2. Open the files in `output-styles/` and tweak the mode definitions, or add your own (e.g. `output-styles/code-reviewer.md`).
3. Commit and push to your own fork.

## Repo layout

```
.
├── CLAUDE.md                          # global instructions
├── output-styles/
│   ├── autonomous-programmer.md
│   └── pair-programmer.md
├── install.sh                         # one-shot symlink installer
├── .gitignore
└── README.md
```

## What's intentionally not tracked

These live under `~/.claude/` but stay out of the repo because they're machine-specific or managed by Claude Code itself:

- `settings.json` — may contain local paths, model preferences, API keys.
- `projects/`, `sessions/`, `history.jsonl` — per-machine session state.
- `plugins/` — installed plugins, managed by Claude Code.
- `memory/` — persistent memory written by Claude during sessions.

## Uninstalling

Delete the symlinks and (optionally) restore your `.bak.*` files:

```bash
rm ~/.claude/CLAUDE.md
rm ~/.claude/output-styles/pair-programmer.md
rm ~/.claude/output-styles/autonomous-programmer.md
# then if you have backups:
# mv ~/.claude/CLAUDE.md.bak.<timestamp> ~/.claude/CLAUDE.md
```

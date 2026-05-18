# claude_configs

My portable [Claude Code](https://docs.claude.com/en/docs/claude-code) configuration. The files in this repo are the **global instructions** and **output-style modes** that Claude Code loads for every project on a machine. Keeping them in git means I can sync the same setup across laptops, desktops, cloud VMs — and roll back if I break something.

## What's in here

| File | What it controls |
|------|------------------|
| `CLAUDE.md` | Global instructions Claude reads at the start of every session: how I plan, when to use subagents, verification rules, Python/uv preference, commit conventions, memory hygiene. Lives at `~/.claude/CLAUDE.md`. |
| `output-styles/pair-programmer.md` | Pair-programming mode. Claude stays in navigator role, I write the code, strict TDD. Used when learning. |
| `output-styles/autonomous-programmer.md` | Autonomous mode. Claude diagnoses, decides, and executes with minimal hand-holding. Used when I already know the concepts. |
| `install.sh` | One-shot setup script for a new machine — symlinks everything into `~/.claude/`. |

## How it works

The live files under `~/.claude/` are **symlinks** into this repo. That means:

- Edit a file here → it's live in `~/.claude/` immediately. No copy step.
- Edit a file in `~/.claude/` → it's already in the repo, ready to commit.
- `git pull` on another machine → changes are picked up instantly, no reinstall.

```
~/.claude/CLAUDE.md  ──symlink──▶  ~/claude_configs/CLAUDE.md
~/.claude/output-styles/*.md ──symlink──▶  ~/claude_configs/output-styles/*.md
```

## Using this in a new project

### Same machine — already set up

Nothing to do. Claude Code loads `~/.claude/CLAUDE.md` and `~/.claude/output-styles/` for **every** project automatically. Just `cd` into the project and run `claude`.

If a project needs extra instructions on top of the globals, drop a `CLAUDE.md` in the project root — Claude Code merges project-level and global instructions.

### New machine — first time setup

```bash
git clone <repo-url> ~/claude_configs
cd ~/claude_configs
./install.sh
```

`install.sh` backs up anything already at the target paths (suffix `.bak.<timestamp>`) before creating the symlinks. Safe to re-run.

### Switching modes inside a session

```
/output-style pair-programmer        # learning / TDD
/output-style autonomous-programmer  # hands-off execution
```

## Editing the config

Edit either side — they're the same file:

```bash
# from the repo
vim ~/claude_configs/CLAUDE.md

# or from the live location (also fine, it's a symlink)
vim ~/.claude/CLAUDE.md
```

Then commit and push from the repo:

```bash
cd ~/claude_configs
git add -A
git commit -m "tweak: <what changed>"
git push
```

Other machines pick it up with `git pull`.

## Layout

```
.
├── CLAUDE.md                          # global instructions
├── output-styles/
│   ├── autonomous-programmer.md
│   └── pair-programmer.md
├── install.sh                         # symlink installer for new machines
├── .gitignore
└── README.md
```

## Not tracked (intentionally)

- `~/.claude/settings.json` — may contain machine-specific paths or keys.
- `~/.claude/projects/`, `sessions/`, `history.jsonl` — per-machine session state.
- `~/.claude/plugins/` — installed plugins, managed by Claude Code itself.

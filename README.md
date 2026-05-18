# claude_configs

Portable Claude Code configuration: global instructions and output-style modes, kept in one place so they can be reused across machines and projects.

## Layout

```
.
├── CLAUDE.md                 # global instructions (~/.claude/CLAUDE.md)
├── output-styles/
│   ├── autonomous-programmer.md
│   └── pair-programmer.md
└── install.sh                # symlink files into ~/.claude on a new machine
```

## How it works

The live files under `~/.claude/` are symlinks pointing into this repo. Editing either side updates both — there is no copy step. To pick up changes on another machine, `git pull` here.

## Setup on a new machine

```bash
git clone <repo-url> ~/claude_configs
cd ~/claude_configs
./install.sh
```

`install.sh` backs up any existing files in `~/.claude/` (suffix `.bak.<timestamp>`) before symlinking.

## Switching modes

```
/output-style pair-programmer
/output-style autonomous-programmer
```

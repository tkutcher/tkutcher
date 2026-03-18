# CLAUDE.md

Personal dotfiles, configuration templates, and utilities repository for Tim Kutcher.

## Repository Overview

| Directory | Purpose |
|---|---|
| `rc/` | Modular shell configuration files (aliases, env vars, functions, prompt) |
| `configs/` | Reusable project configuration templates (Python, ESLint, Prettier, gitignores) |
| `scripts/` | Utility Python scripts |
| `keys/` | Public SSH keys |
| `gfx/` | Avatar and headshot images |

## Key Files

- **`rc/aliases.sh`** — Shell aliases for git, navigation, Python, and common typos
- **`rc/env.sh`** — Environment variable defaults (locale, Python venv, editor)
- **`rc/funs.sh`** — Shell utility functions (`mkcd`, `cdl`, `svnclone`)
- **`rc/p10k.zsh`** — Powerlevel10k prompt configuration
- **`scripts/inbox_gather.py`** — Moves files from TurboScan dropoff to inbox with date-prefixed names; uses `TK_TURBOSCAN_DIR` and `TK_INBOX_DIR` env vars


## Conventions

- Commit messages use prefixes: `feat:`, `fix:`, `refactor:`, `task:`, `docs:`
- Python scripts are formatted with Black
- Shell files live in `rc/` and are meant to be sourced by machine-specific rc files (not executed directly)
- Config templates in `configs/` are starting points to copy into new projects

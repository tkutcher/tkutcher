# rc/

Modular shell configuration files, sourced by `install.zsh` via `~/.zshrc`.

| File | Description |
|---|---|
| `defaults.sh` | Shell defaults: `LANG`, `LC_ALL`, `EDITOR` |
| `omz.zsh` | oh-my-zsh setup (theme, plugins, history options) and powerlevel10k config |
| `aliases.sh` | Aliases for navigation, git, Python, and common typos |
| `cdl.sh` | `cdl` — `cd` into a directory and list its contents |
| `mkcd.sh` | `mkcd` — create a directory and `cd` into it |
| `go2.zsh` | `go2` — jump to named directories defined in `~/.tkrc.json` |
| `greeting.sh` | Prints hostname, date/time, and cwd on new shell |
| `p10k.zsh` | Powerlevel10k prompt configuration |
| `.vimrc` | Vim configuration (symlinked to `~/.vimrc` when `include_vimrc` is set) |

Files are intended to be sourced, not executed directly. The active set and load order is controlled by `source_files` in `~/.tkrc.json`.

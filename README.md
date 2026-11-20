# Dotfiles

Shared configuration for Ghostty, Neovim, Zsh, and tmux. This repository lives at
`~/.config`.

## Configuration locations

| Path | Purpose |
| --- | --- |
| `ghostty/config` | Ghostty terminal settings |
| `nvim/` | Neovim configuration |
| `tmux/tmux.conf` | tmux sessions and project picker keybindings |
| `scripts/project-picker.sh` | Skim directory picker and tmux session switching |
| `zsh/.zshrc` | Shell environment, utilities, and shared aliases |
| `zsh/.zprofile` | Login shell setup, including Homebrew and Python paths |
| `~/.zshrc.local` | Local account-switching helpers and private shell settings; outside this repository |
| `~/.gitconfig` | Local Git identity; outside this repository |

## Project picker (Skim + fd + tmux)

Inspired by SylvanFranklin's tmux session picker, with a smaller configuration.
This setup **does not replace fzf or zoxide** in Zsh; it adds a project-session picker.

Install dependencies on macOS:

```sh
brew install tmux fd skim
```

Start tmux with this repo's config (or link it for future launches):

```sh
mkdir -p ~/.tmux
ln -sfn "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
tmux new -s home
```

Inside tmux press **Ctrl+Space**, release, then **f**. The picker displays
folders under `~/Dev` and `~/.config`, to depth four. Type part of the path and
press Enter to create or resume a session in that directory. Escape cancels.
The directory scan excludes `.git`, `node_modules`, `.venv`, `build`, `.next`,
and `target`. Edit `roots` or `--max-depth` in `scripts/project-picker.sh` if
needed. Sessions use a path-derived suffix to avoid collisions between folders
with the same basename. Reopen the picker with Ctrl+Space, f to switch again.

Common tmux shortcuts: Ctrl+Space then `c` creates a window; `d` detaches;
`r` reloads the config. Reattach from your shell with `tmux attach` or list
sessions using `tmux ls`.

The script runs through `bash` and doesn't need the executable bit set.

## Shell setup

The original `~/.zshrc` and `~/.zprofile` were moved into `zsh/` and replaced
with symlinks. Zsh continues to use its normal home directory entry points.

To set up another machine, first clone this repository into `~/.config` and
back up any existing `~/.zshrc` and `~/.zprofile`. Then create the links:

```sh
ln -s .config/zsh/.zshrc ~/.zshrc
ln -s .config/zsh/.zprofile ~/.zprofile
```

The relative link targets resolve from the home directory. Existing files must
be moved aside before running these commands.

### Shared aliases

Project paths are intentionally included in `zsh/.zshrc`:

| Alias | Command |
| --- | --- |
| `tareek` | `cd ~/Dev/SCSU/tareek/TAREEK` |
| `lab` | `cd ~/Dev/SCSU/CSCI201/` |
| `src` | `source ~/.zshrc` |

Edit `~/.config/zsh/.zshrc` to change shared aliases, then run `src` to reload.

### Local settings

At the end of startup, `.zshrc` sources `~/.zshrc.local` if it exists and is
readable. Keep tokens, private environment variables, and account-switching
helpers there. The current `use-codex1` and `use-codex2` helpers remain in this
local file; their credential files remain under `~/.codex`, outside the repo.
The local file is optional and is not installed by cloning this repository.

Git identity, including email, remains in `~/.gitconfig` and is not linked into
this repository. Shell histories, profile backups, caches, and application state
also remain outside the shared configuration.

## Git tracking and privacy

The root `.gitignore` allows only `.gitignore`, `README.md`, `ghostty/`, `nvim/`,
`tmux/`, `scripts/`, and `zsh/`. New top-level application folders are ignored by default, including
`cagent/`. Within `zsh/`, only `.zshrc` and `.zprofile` are allowed.

Additional rules ignore local override files, environment files, common credential
filenames, private key files, macOS metadata, and Vim swap files. Ignore rules do
not protect files already tracked by Git or detect every possible secret. Review
new files and diffs before committing, and keep credentials outside the repo.

## Migration backup

Copies of the original shell files and the previous README and ignore rules were
saved locally in `~/.local/share/dotfiles-backups/20261118-115558/` before the
migration. This backup is outside the repository.

# Dotfiles

Shared configuration for Ghostty, Neovim, and Zsh. This repository lives at
`~/.config`.

## Configuration locations

| Path | Purpose |
| --- | --- |
| `ghostty/config` | Ghostty terminal settings |
| `nvim/` | Neovim configuration |
| `zsh/.zshrc` | Shell environment, utilities, and shared aliases |
| `zsh/.zprofile` | Login shell setup, including Homebrew and Python paths |
| `~/.zshrc.local` | Local account-switching helpers and private shell settings; outside this repository |
| `~/.gitconfig` | Local Git identity; outside this repository |

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
and `zsh/`. New top-level application folders are ignored by default, including
`cagent/`. Within `zsh/`, only `.zshrc` and `.zprofile` are allowed.

Additional rules ignore local override files, environment files, common credential
filenames, private key files, macOS metadata, and Vim swap files. Ignore rules do
not protect files already tracked by Git or detect every possible secret. Review
new files and diffs before committing, and keep credentials outside the repo.

## Migration backup

Copies of the original shell files and the previous README and ignore rules were
saved locally in `~/.local/share/dotfiles-backups/20261118-115558/` before the
migration. This backup is outside the repository.

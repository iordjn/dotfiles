# Dotfiles

Configuration for Ghostty, LazyVim/Neovim, and Zsh on macOS.

## Install workflow tools

```sh
brew install fd sk lazygit glow
```

The project picker needs `fd` and `sk` (Skim CLI, **not** the `skim` PDF app).

## Project navigation (no tmux required)

`zsh/.zshrc` defines `proj`, which uses `fd` to find folders in
`~/Dev` plus `~/.config`, and Skim (`sk`) to pick one.

```sh
source ~/.zshrc
proj
```

Type a name, press Enter to change the **current shell's** directory, or
Esc to cancel. Then run `nvim .`. New Ghostty tabs or splits can be opened
in the current directory using Ghostty's native functionality.

This replaces the former `cproj` function and tmux-only picker.
The independent `fzf` and `zoxide` shell integrations are retained.

## Git

Inside a Git repository run `lg` (alias for `lazygit`).
Inside Neovim use `Space g g` to open Lazygit through Snacks.

Inspect diffs, stage selected changes, and commit from Lazygit.

## Preview from Neovim

With a saved file open, press `Space p`:

- HTML: save changed content and open the file in your default browser
- Markdown: save changed content and open `glow -p` in a floating terminal

For Markdown, press `q` to leave the pager. These are on-demand previews,
not automatic live reload. Other file types show an informational message.

## Config files

- `ghostty/config` — terminal appearance and split navigation
- `nvim/lua/config/keymaps.lua` — preview and Lazygit mappings
- `nvim/lua/plugins/` — LazyVim plugin overrides, including Oil and theme
- `zsh/.zshrc` — shell setup and project navigation

Keep credentials and private machine settings outside tracked dotfiles.

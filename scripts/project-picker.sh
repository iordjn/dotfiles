#!/usr/bin/env bash
# Choose a directory with Skim, then open/resume its tmux session.
set -euo pipefail

command -v fd >/dev/null || { echo "Install fd: brew install fd"; exit 1; }
command -v sk >/dev/null || { echo "Install skim: brew install skim"; exit 1; }
[[ -n "${TMUX:-}" ]] || { echo "Run this from inside tmux"; exit 1; }

roots=()
[[ -d "$HOME/Dev" ]] && roots+=("$HOME/Dev")
[[ -d "$HOME/.config" ]] && roots+=("$HOME/.config")
[[ ${#roots[@]} -gt 0 ]] || { echo "No directories to search"; exit 1; }

# A limited search depth prevents the menu filling up with build outputs.
selected=$(
  for root in "${roots[@]}"; do
    fd --type d --hidden --max-depth 4 \
      --exclude .git --exclude node_modules --exclude .venv \
      --exclude build --exclude .next --exclude target \
      . "$root"
  done |
    sed "s|^$HOME/||" |
    sk --reverse --height=100% --prompt="Project > "
) || exit 0

[[ -n "$selected" ]] || exit 0
project="$HOME/$selected"
[[ -d "$project" ]] || { echo "Directory no longer exists: $project"; exit 1; }

# Stable session names distinguish similarly named folders.
name=$(basename "$project" | tr -c '[:alnum:]_-' '_')
hash=$(printf '%s' "$project" | shasum | cut -c1-7)
session="${name}_${hash}"

if ! tmux has-session -t "=${session}" 2>/dev/null; then
  tmux new-session -d -s "$session" -c "$project" -n shell
fi
tmux switch-client -t "=${session}"

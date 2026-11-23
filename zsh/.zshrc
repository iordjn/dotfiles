
# ==========================================
# Homebrew
# ==========================================

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi


# ==========================================
# Development Environments
# ==========================================

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# .NET global tools
export PATH="$HOME/.dotnet/tools:$PATH"

# Java 21
if /usr/libexec/java_home -v 21 >/dev/null 2>&1; then
    export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
    export PATH="$JAVA_HOME/bin:$PATH"
fi

# Local executables
export PATH="$HOME/.local/bin:$PATH"

# Qt6
if command -v brew >/dev/null 2>&1; then
    QT_PREFIX="$(brew --prefix qt 2>/dev/null)"
    if [[ -n "$QT_PREFIX" && -d "$QT_PREFIX/bin" ]]; then
        export PATH="$QT_PREFIX/bin:$PATH"
    fi
    unset QT_PREFIX
fi

# Prevent duplicate PATH entries
typeset -U path PATH
export PATH


# ==========================================
# Shell Utilities
# ==========================================

# fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

eval "$(zoxide init zsh)"

# Fuzzy project picker (Ghostty-compatible, no tmux required)
proj() {
  if ! command -v fd >/dev/null || ! command -v sk >/dev/null; then
    print -u2 "Project picker needs fd and sk: brew install fd sk"
    return 1
  fi

  local directory
  directory=$(
    {
      if [[ -d "$HOME/Dev" ]]; then
        fd --type d --hidden --max-depth 5 \
          --exclude .git --exclude node_modules --exclude .venv \
          --exclude build --exclude .next --exclude target \
          . "$HOME/Dev"
      fi
      [[ -d "$HOME/.config" ]] && print -r -- "$HOME/.config"
    } | sk --reverse --height=80% --prompt="Project > "
  ) || return

  [[ -n "$directory" ]] && cd -- "$directory"
}

# ==========================================
# Aliases
# ==========================================

# Short-Cuts
alias vim='nvim'
alias im='nvim'
alias lg='lazygit'

# Projects
alias tareek='cd ~/Dev/SCSU/tareek/TAREEK'
alias lab='cd ~/Dev/SCSU/CSCI201/'

# Reload Zsh configuration
alias src='source ~/.zshrc'

# Make Virtual Environment and Source Virtual Environment
alias mkvenv='python3 -m venv .venv'
alias venv='source .venv/bin/activate'


# Private settings stay outside the dotfiles repository.
[[ ! -r "$HOME/.zshrc.local" ]] || source "$HOME/.zshrc.local"

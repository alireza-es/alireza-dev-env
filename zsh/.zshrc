# ~/.zshrc - managed via alireza-dev-env (GNU Stow)

# --- Homebrew (Apple Silicon) ---
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- pyenv ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory sharehistory hist_ignore_dups hist_ignore_space hist_reduce_blanks

# --- zsh behavior ---
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
unsetopt BEEP

# --- Completion ---
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive

# --- Editor ---
export EDITOR="nvim"
export VISUAL="nvim"

# --- Aliases ---
# Modern replacements
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons'
  alias ll='eza -la --group-directories-first --icons --git'
  alias la='eza -a --group-directories-first --icons'
  alias lt='eza --tree --level=2 --icons'
else
  alias ll='ls -la'
  alias la='ls -A'
fi
command -v bat >/dev/null 2>&1 && alias cat='bat --paging=never'
alias l='ls -CF'
alias v='nvim'
alias vim='nvim'
alias lg='lazygit'
alias gs='git status'
alias gd='git diff'

# --- nvm ---
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# --- Google Cloud SDK ---
if [ -f '/Users/alireza/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/alireza/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/alireza/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/alireza/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# --- fzf (fuzzy finder) ---
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
fi

# --- zoxide (smarter cd) ---
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# --- starship prompt ---
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# --- local bin / claude CLI ---
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

#!/usr/bin/env bash
# Bootstrap the dev environment on a fresh macOS machine.
# Usage: ./bootstrap.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "==> Dotfiles dir: $DOTFILES_DIR"

# 1. Xcode command line tools (compiler for treesitter, git, etc.)
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "    Re-run this script after the CLT install finishes."
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Load brew into this shell (Apple Silicon path)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. Install everything from the Brewfile
echo "==> Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 4. tree-sitter CLI (Homebrew's tree-sitter formula no longer ships the CLI;
#    nvim-treesitter's main branch needs it to compile parsers)
if ! command -v tree-sitter >/dev/null 2>&1; then
  echo "==> Installing tree-sitter CLI via npm..."
  if command -v npm >/dev/null 2>&1; then
    npm install -g tree-sitter-cli
  else
    echo "    npm not found; install Node (nvm) then run: npm install -g tree-sitter-cli"
  fi
fi

# 5. LazyVim starter (only if the nvim package is empty - normally it's tracked here)
if [ ! -f "$DOTFILES_DIR/nvim/.config/nvim/init.lua" ]; then
  echo "==> Cloning LazyVim starter..."
  git clone https://github.com/LazyVim/starter "$DOTFILES_DIR/nvim/.config/nvim"
  rm -rf "$DOTFILES_DIR/nvim/.config/nvim/.git"
fi

# 6. Stow all packages into $HOME
echo "==> Stowing dotfiles..."
for pkg in nvim tmux ghostty zsh starship sesh git; do
  stow --dir "$DOTFILES_DIR" --target "$HOME" --restow "$pkg"
done

# 7. tmux plugin manager + plugins
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
echo "==> Installing tmux plugins..."
tmux kill-server >/dev/null 2>&1 || true
tmux -f "$HOME/.config/tmux/tmux.conf" new-session -d -s bootstrap >/dev/null 2>&1 || true
TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins/" "$TPM_DIR/bin/install_plugins" || true
tmux kill-server >/dev/null 2>&1 || true

# 8. Sync Neovim plugins, Mason tools, and treesitter parsers
echo "==> Syncing Neovim plugins (this can take a few minutes)..."
nvim --headless "+Lazy! sync" +qa || true

echo ""
echo "==> Done! Open Ghostty (it will start tmux/zsh) and run nvim."
echo "    In nvim, run :LazyHealth and :Mason to confirm everything is installed."

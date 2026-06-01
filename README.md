# alireza-dev-env

My macOS development environment, managed with [GNU Stow](https://www.gnu.org/software/stow/).

A clean, professional, reproducible setup:

- **Terminal:** [Ghostty](https://ghostty.org) (GPU-accelerated)
- **Multiplexer:** [tmux](https://github.com/tmux/tmux) with [TPM](https://github.com/tmux-plugins/tpm)
- **Editor:** [Neovim](https://neovim.io) with [LazyVim](https://www.lazyvim.org)
- **Shell:** zsh + [starship](https://starship.rs) prompt + [zoxide](https://github.com/ajeetdsouza/zoxide) + [fzf](https://github.com/junegunn/fzf)
- **AI:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — in the terminal (tmux popup) and inside Neovim via [claudecode.nvim](https://github.com/coder/claudecode.nvim) (reuses your existing Claude auth, no API key)
- **Theme:** [tokyonight](https://github.com/folke/tokyonight.nvim) (storm) across Neovim, tmux, and Ghostty
- **Font:** JetBrainsMono Nerd Font

## Layout (Stow packages)

Each top-level folder is a Stow "package" that mirrors `$HOME`:

```
alireza-dev-env/
├── Brewfile                      # all tools / casks / fonts
├── bootstrap.sh                  # one-shot installer for a new machine
├── nvim/.config/nvim/            # LazyVim config + custom plugin specs
├── tmux/.config/tmux/tmux.conf   # tmux config (TPM auto-bootstraps)
├── ghostty/.config/ghostty/config
├── zsh/.zshrc
├── starship/.config/starship.toml
└── git/.gitconfig
```

`stow nvim` symlinks `nvim/.config/nvim` -> `~/.config/nvim`, and so on.

## New machine setup

```sh
git clone git@github.com:alireza-es/alireza-dev-env.git ~/code/alireza-es/alireza-dev-env
cd ~/code/alireza-es/alireza-dev-env
./bootstrap.sh
```

`bootstrap.sh` installs Xcode CLT, Homebrew, all Brewfile packages, the tree-sitter
CLI, stows every package, and installs tmux + Neovim plugins.

## Manual stow (after the repo is cloned)

```sh
cd ~/code/alireza-es/alireza-dev-env
stow --target "$HOME" nvim tmux ghostty zsh starship git
```

To remove the symlinks for a package: `stow -D <package>`.

## Neovim

Built on **LazyVim**. Custom specs live in `nvim/.config/nvim/lua/plugins/`:

- `colorscheme.lua` — tokyonight (storm), set as the default colorscheme.
- `claudecode.lua` — Claude Code integration. Keys under `<leader>a` (toggle `<leader>ac`,
  send selection `<leader>as`, accept/deny diff `<leader>aa` / `<leader>ad`).
- `python.lua` — basedpyright + ruff + debugpy, inlay hints, `venv-selector` (`<leader>cv`).
- `typescript.lua` — vtsls inlay hints, `nvim-ts-autotag`, `package-info.nvim`.
- `trending.lua` — oil (`-`), grug-far (`<leader>sr`), harpoon (`<leader>h` / `<leader>1..4`),
  yanky, refactoring.nvim (`<leader>rr`).

Enabled **LazyVim extras** (declared in `lua/config/lazy.lua`): `lang.python`,
`lang.typescript`, `lang.tailwind`, `lang.json`, `lang.yaml`, `lang.docker`,
`lang.markdown`, `formatting.prettier`, `linting.eslint`, `editor.fzf`, `dap.core`,
`test.core`, `coding.mini-surround`, `util.mini-hipatterns`.

After editing, run `:Lazy sync`, then `:LazyHealth` and `:Mason` to verify.

## tmux

- Prefix is `Ctrl-a`.
- `prefix + a` opens a **Claude** popup; `prefix + g` opens **lazygit**.
- `Ctrl-h/j/k/l` navigates seamlessly between tmux panes and Neovim splits
  (via vim-tmux-navigator).
- Sessions auto-save/restore (resurrect + continuum).
- `prefix + |` / `prefix + -` split vertically / horizontally.

## Languages

| Language          | LSP            | Lint / Format            | Debug / Test           |
| ----------------- | -------------- | ------------------------ | ---------------------- |
| Python            | basedpyright   | ruff (lint+format+isort) | debugpy / neotest      |
| TypeScript / JS   | vtsls          | eslint / prettier        | js-debug-adapter       |
| JSON/YAML/Docker  | dedicated LSPs | prettier / hadolint      | —                      |

All language servers and tools are installed automatically via Mason.

## Notes

- `lazy-lock.json` is committed for reproducible plugin versions.
- tmux plugins and TPM live under `~/.config/tmux/plugins/` and are not tracked
  (installed by `bootstrap.sh`).
- Backups of any pre-existing configs are saved to `~/dev-env-backup-<timestamp>/`.

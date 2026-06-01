<div align="center">

# 🛠️ alireza-dev-env

### A fast, modern, reproducible macOS development environment

_Ghostty · tmux · LazyVim · Claude AI · managed with GNU Stow_

<p>
  <img alt="Platform" src="https://img.shields.io/badge/platform-macOS-000000?style=for-the-badge&logo=apple&logoColor=white">
  <img alt="Shell" src="https://img.shields.io/badge/shell-zsh-89e051?style=for-the-badge&logo=gnu-bash&logoColor=white">
  <img alt="Editor" src="https://img.shields.io/badge/editor-Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white">
  <img alt="Terminal" src="https://img.shields.io/badge/terminal-Ghostty-3b4261?style=for-the-badge">
  <img alt="Theme" src="https://img.shields.io/badge/theme-tokyonight-7aa2f7?style=for-the-badge">
</p>

</div>

---

A complete, opinionated developer setup built for **Python**, **TypeScript**, and **JavaScript**, with first-class **Claude AI** integration both in the terminal and inside the editor. Every config lives in this repo and is symlinked into place with [GNU Stow](https://www.gnu.org/software/stow/), so a fresh machine is one command away.

## 📑 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start-fresh-machine)
- [Manual Installation](#-manual-installation)
- [Repository Layout](#-repository-layout)
- [Daily Usage Guide](#-daily-usage-guide)
- [Keybindings](#-keybindings)
- [Language Support](#-language-support)
- [Using Claude AI](#-using-claude-ai)
- [Customizing](#-customizing)
- [Updating](#-updating)
- [Uninstalling](#-uninstalling)
- [Credits](#-credits)

## ✨ Features

- ⚡ **GPU-accelerated terminal** — [Ghostty](https://ghostty.org) with ligatures, a Nerd Font, and the tokyonight theme.
- 🪟 **Powerful multiplexing** — tmux with seamless Neovim navigation, session persistence, and a one-key Claude popup.
- 🔀 **Instant repo switching** — [sesh](https://github.com/joshmedeski/sesh) + [persistence.nvim](https://github.com/folke/persistence.nvim): fuzzy-jump between projects (each its own tmux session) and resume your exact Neovim layout per repo — perfect for running a backend and frontend at once.
- 💤 **IDE-grade editor** — [LazyVim](https://www.lazyvim.org) with LSP, completion, debugging, testing, and fuzzy finding pre-wired.
- 🤖 **Claude everywhere** — Claude Code in a tmux popup _and_ inside Neovim via [claudecode.nvim](https://github.com/coder/claudecode.nvim) (reuses your existing Claude login — no API key).
- 🐍 **Python / TS / JS ready** — language servers, formatters, linters, and debuggers installed automatically.
- 🎨 **One consistent theme** — tokyonight (storm) across Neovim, tmux, and Ghostty.
- 🧩 **Modern CLI** — `eza`, `bat`, `fzf`, `zoxide`, `ripgrep`, `fd`, `lazygit`, `delta`, and a `starship` prompt.
- 📦 **Reproducible** — a single `Brewfile`, committed plugin lockfile, and a `bootstrap.sh` that sets up a new Mac end to end.

## 🧰 Tech Stack

| Category        | Tool                                                                 |
| --------------- | -------------------------------------------------------------------- |
| Terminal        | [Ghostty](https://ghostty.org)                                       |
| Multiplexer     | [tmux](https://github.com/tmux/tmux) + [TPM](https://github.com/tmux-plugins/tpm) |
| Session manager | [sesh](https://github.com/joshmedeski/sesh) + [persistence.nvim](https://github.com/folke/persistence.nvim) |
| Editor          | [Neovim](https://neovim.io) + [LazyVim](https://www.lazyvim.org)     |
| Shell           | zsh + [starship](https://starship.rs)                                |
| Prompt extras   | [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf) |
| Listing / view  | [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat) |
| Search          | [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd) |
| Git             | [lazygit](https://github.com/jesseduffield/lazygit), [delta](https://github.com/dandavison/delta) |
| AI              | [Claude Code](https://docs.anthropic.com/en/docs/claude-code) + [claudecode.nvim](https://github.com/coder/claudecode.nvim) |
| Dotfiles        | [GNU Stow](https://www.gnu.org/software/stow/)                       |
| Font            | JetBrainsMono Nerd Font                                              |
| Theme           | [tokyonight](https://github.com/folke/tokyonight.nvim) (storm)       |

## 📋 Prerequisites

- **macOS** (Apple Silicon or Intel)
- **Xcode Command Line Tools** — `xcode-select --install` (the bootstrap script handles this)
- A **Claude** account for AI features ([Claude Code](https://docs.anthropic.com/en/docs/claude-code))

Everything else (Homebrew, Neovim, tmux, fonts, CLI tools) is installed for you.

## 🚀 Quick Start (fresh machine)

```sh
git clone git@github.com:alireza-es/alireza-dev-env.git ~/code/alireza-es/alireza-dev-env
cd ~/code/alireza-es/alireza-dev-env
./bootstrap.sh
```

The bootstrap script will:

1. Install **Xcode Command Line Tools** and **Homebrew** (if missing).
2. Install all packages, casks, and the font from the **Brewfile**.
3. Install the **tree-sitter** CLI (needed by nvim-treesitter).
4. **Stow** every config into `$HOME`.
5. Install **tmux** plugins (TPM) and sync **Neovim** plugins.

When it finishes, open **Ghostty** and start coding. In Neovim, run `:LazyHealth` and `:Mason` to confirm everything is green.

> 💡 Existing configs are never clobbered — any pre-existing `~/.zshrc`, `~/.gitconfig`, or `~/.config/nvim` is backed up to `~/dev-env-backup-<timestamp>/`.

## 🔧 Manual Installation

If you'd rather run the steps yourself:

```sh
# 1. Install tools
brew bundle --file=Brewfile
npm install -g tree-sitter-cli

# 2. Symlink configs into $HOME
stow --target "$HOME" nvim tmux ghostty zsh starship sesh git

# 3. tmux plugins (or just open tmux — it auto-bootstraps TPM)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
~/.config/tmux/plugins/tpm/bin/install_plugins

# 4. Neovim plugins
nvim --headless "+Lazy! sync" +qa
```

## 🗂️ Repository Layout

Each top-level folder is a **Stow package** that mirrors `$HOME`. Running `stow nvim`
symlinks `nvim/.config/nvim` → `~/.config/nvim`, and so on.

```text
alireza-dev-env/
├── Brewfile                       # all tools, casks, and the font
├── bootstrap.sh                   # one-shot installer for a new Mac
├── README.md
├── nvim/.config/nvim/             # LazyVim config
│   ├── lua/config/lazy.lua        # plugin manager + enabled extras
│   └── lua/plugins/               # custom specs:
│       ├── colorscheme.lua        #   tokyonight (default theme)
│       ├── claudecode.lua         #   Claude Code integration
│       ├── python.lua             #   basedpyright + ruff + venv
│       ├── typescript.lua         #   vtsls + autotag + package-info
│       └── trending.lua           #   oil, grug-far, harpoon, yanky...
├── tmux/.config/tmux/tmux.conf
├── ghostty/.config/ghostty/config
├── zsh/.zshrc
├── starship/.config/starship.toml
├── sesh/.config/sesh/sesh.toml    # smart session manager config
└── git/.gitconfig
```

## 📖 Daily Usage Guide

A walkthrough of a typical session — from opening a terminal to editing code with Claude.

### 1. Open your terminal

Launch **Ghostty** (press `Cmd+Space`, type `Ghostty`, hit Enter). It opens straight
into `zsh` with the starship prompt. New tab: `Cmd+T`, new window: `Cmd+N`.

### 2. Go to your project

Use normal `cd`, or `zoxide` to jump to recent folders by name:

```sh
cd ~/code/my-project       # classic
z my-project               # zoxide — jumps to the best match from your history
ll                         # list files (eza, with icons + git status)
```

### 3. Organize your work with tmux

[tmux](https://github.com/tmux/tmux) keeps everything alive even if you close the
terminal. It has three levels — think of them like this:

| Level       | Think of it as…              | Good for                                  |
| ----------- | ---------------------------- | ----------------------------------------- |
| **Session** | a whole project / workspace  | one per repo (backend, frontend, …)       |
| **Window**  | a tab inside a session       | editor / dev server / git / logs          |
| **Pane**    | a split inside a window      | seeing two things side by side (optional) |

The prefix is **`Ctrl-a`** — press and release it, then press the next key.

#### Sessions (one per project — your main unit)

```sh
tmux new -s backend        # create + enter a session called "backend"
tmux new -s frontend       # another one for the frontend
tmux ls                    # list all sessions
tmux attach -t backend     # re-attach to one later
```

Switch between sessions without leaving tmux:

| Keys                | Action                                              |
| ------------------- | --------------------------------------------------- |
| `Ctrl-a` then `T`   | **sesh** — fuzzy-pick any session/repo (easiest)    |
| `Ctrl-a` then `s`   | visual list of sessions — pick with arrows + Enter  |
| `Ctrl-a` then `)`   | jump to the next session                            |
| `Ctrl-a` then `(`   | jump to the previous session                        |
| `Ctrl-a` then `$`   | rename the current session                          |
| `Ctrl-a` then `d`   | detach (the session keeps running in the background)|

> A backend/frontend day: `Ctrl-a T` → pick `backend`, work, `Ctrl-a T` → pick
> `frontend`. Each stays running independently; you just hop between them.

#### Windows (tabs within a session)

```text
[ 1:nvim ] [ 2:server ] [ 3:git ]      ← window bar at the top
```

| Keys                  | Action                          |
| --------------------- | ------------------------------- |
| `Ctrl-a` then `c`     | new window                      |
| `Ctrl-a` then `1`/`2`…| jump to window by number        |
| `Ctrl-a` then `n`/`p` | next / previous window          |
| `Ctrl-a` then `,`     | rename the current window       |
| `Ctrl-a` then `&`     | close the current window        |

This is usually all you need: an `nvim` window, a window for `npm run dev`, a
window for `git`/`lazygit` — and switch with `Ctrl-a 1/2/3`.

#### Panes / splits (optional)

If you ever want two things visible at once in the same window — say the editor
on the left and a shell on the right:

```text
┌─────────────────────────┬───────────────┐
│                         │  $ npm run dev │
│        nvim             │                │
│                         ├───────────────┤
│                         │  $ pytest      │
└─────────────────────────┴───────────────┘
```

| Keys                       | Action                                       |
| -------------------------- | -------------------------------------------- |
| `Ctrl-a` then `\|`         | split left / right                           |
| `Ctrl-a` then `-`          | split top / bottom                           |
| `Ctrl-h` `Ctrl-j` `Ctrl-k` `Ctrl-l` | move between panes (and Neovim splits!) |
| `Ctrl-a` then `H/J/K/L`    | resize the current pane                      |
| `Ctrl-a` then `x`          | close the current pane                       |
| `Ctrl-a` then `z`          | zoom a pane to fullscreen (toggle)           |

### 4. Open Neovim on your project

`cd` into the project folder first, then launch `nvim` so the editor's working
directory (and the file tree, fuzzy finder, LSP, git) all root there:

```sh
cd ~/code/my-project
nvim .                     # open Neovim in the current folder
# or open a specific file:
nvim src/app.py
```

`v .` and `vim .` are aliases for `nvim .`.

### 5. Move around in Neovim

The leader key is **`Space`**.

| What you want                  | Do this                                            |
| ------------------------------ | -------------------------------------------------- |
| Toggle the file explorer       | `Space` `e`                                         |
| Find a file by name            | `Space` `Space` (or `Space` `f` `f`)                |
| Search text across the project | `Space` `/` (or `Space` `s` `g`) — live grep        |
| Edit the filesystem as a buffer| `-` (oil.nvim) — rename/move/delete, then `:w`       |
| Jump between recent buffers    | `Space` `,`                                          |
| Open a terminal inside nvim    | `Ctrl-/`                                             |
| Pin / jump to hot files        | `Space` `H` to pin, `Space` `1`..`4` to jump (harpoon)|
| Save / quit                    | `:w` / `:q` (`:wq` to do both, `:qa` to quit all)    |

First time you open a Python/TS/JS file, Mason finishes wiring up the language
server automatically — you'll get completion, diagnostics, and go-to-definition
(`g` `d`), hover docs (`K`), and rename (`Space` `c` `r`).

### 6. Use git

```sh
lg                         # lazygit — full TUI for staging, commits, branches, diffs
```

Inside Neovim, changed lines are marked in the gutter, and `Space` `g` `g` opens
lazygit in a floating window.

### 7. Ask Claude

- **From any pane:** `Ctrl-a` then `a` — Claude opens in a popup. Ask questions,
  run tasks, close it when done; your panes are untouched.
- **Inside Neovim:** `Space` `a` `c` toggles Claude. Select code in visual mode
  (`v`), then `Space` `a` `s` sends it as context. When Claude proposes an edit,
  review it and `Space` `a` `a` to accept or `Space` `a` `d` to reject.

### 8. Wrap up

Detach from tmux with `Ctrl-a` then `d` (everything keeps running), or quit
Neovim with `:qa`. Next time, `tmux attach -t work` drops you right back in —
and tmux also auto-saves/restores sessions across reboots.

> 🆕 **New to Vim?** Run `nvim` and type `:Tutor` for the built-in 30-minute
> interactive tutorial. Press `Space` to see which-key menus of every shortcut.

### Working with multiple repos (e.g. backend + frontend)

Two pieces work together so you can flip between projects and pick up exactly
where you left off:

**`sesh`** gives every project its own tmux session and a fuzzy switcher. From
anywhere, press `prefix` (`Ctrl-a`) then `T` — a popup lists your open sessions,
recent (zoxide) directories, and any repos pinned in
[`sesh.toml`](sesh/.config/sesh/sesh.toml). Pick one and you jump straight into a
session rooted there. So a backend/frontend day looks like:

```text
prefix T → pick "backend"    # working on the API
prefix T → pick "frontend"   # hop over to the UI — backend stays running
prefix T → pick "backend"    # hop back, exactly as you left it
```

You can pin your common repos by uncommenting the examples in `sesh.toml`, so
they always appear in the picker by name.

**`persistence.nvim`** (built into LazyVim) remembers your Neovim state _per
directory_ — open buffers, splits, and tabs. It saves automatically when you
quit. Next time you open `nvim` in that repo, restore it with:

| Keys         | Action                                     |
| ------------ | ------------------------------------------ |
| `<leader>qs` | Restore the session for the current folder |
| `<leader>ql` | Restore the last session                   |
| `<leader>qS` | Pick a session from the list               |
| `<leader>qd` | Stop auto-saving the current session       |

> 💡 To auto-open Neovim **and** restore the session whenever you enter a repo,
> set that repo's `startup_command` in `sesh.toml` to
> `nvim -c 'lua require"persistence".load()'` (commented examples are included).

## ⌨️ Keybindings

### tmux (prefix = `Ctrl-a`)

| Keys                | Action                                   |
| ------------------- | ---------------------------------------- |
| `prefix` + `a`      | Open **Claude** in a popup               |
| `prefix` + `g`      | Open **lazygit** in a popup              |
| `prefix` + `T`      | **sesh** — fuzzy-switch project/session  |
| `prefix` + `s`      | List sessions (pick from a menu)         |
| `prefix` + `(` / `)`| Previous / next session                  |
| `prefix` + `$`      | Rename the current session               |
| `prefix` + `d`      | Detach (session keeps running)           |
| `prefix` + `c`      | New window (tab)                         |
| `prefix` + `1`/`2`… | Jump to window by number                 |
| `prefix` + `,`      | Rename the current window                |
| `prefix` + `\|`     | Split pane vertically (optional)         |
| `prefix` + `-`      | Split pane horizontally (optional)       |
| `Ctrl` + `h/j/k/l`  | Move between tmux panes **and** nvim splits |
| `prefix` + `H/J/K/L`| Resize the current pane                  |
| `prefix` + `z`      | Zoom current pane to fullscreen (toggle) |
| `prefix` + `r`      | Reload tmux config                       |

### Neovim (leader = `Space`)

| Keys           | Action                                  |
| -------------- | --------------------------------------- |
| `<leader>ac`   | Toggle Claude Code                      |
| `<leader>as`   | Send selection to Claude (visual mode)  |
| `<leader>aa` / `<leader>ad` | Accept / deny a Claude diff |
| `-`            | Open parent directory (oil.nvim)        |
| `<leader>sr`   | Project-wide search & replace (grug-far)|
| `<leader>h`    | Harpoon menu · `<leader>1..4` jump      |
| `<leader>p`    | Yank history (yanky)                    |
| `<leader>rr`   | Refactor menu                           |
| `<leader>cv`   | Select Python virtualenv                |
| `<leader>qs`   | Restore this project's session          |
| `<leader>ql`   | Restore last session                    |
| `<leader>qd`   | Stop saving the current session         |

> The rest follow standard LazyVim defaults — see [lazyvim.org/keymaps](https://www.lazyvim.org/keymaps).

## 🧑‍💻 Language Support

All servers and tools below install automatically via [Mason](https://github.com/williamboman/mason.nvim) — no manual setup.

| Language            | LSP            | Lint / Format               | Debug / Test         |
| ------------------- | -------------- | --------------------------- | -------------------- |
| **Python**          | basedpyright   | ruff (lint + format + isort)| debugpy · neotest    |
| **TypeScript / JS** | vtsls          | eslint · prettier           | js-debug-adapter     |
| **JSON / YAML**     | dedicated LSPs | prettier                    | —                    |
| **Docker**          | dockerls       | hadolint                    | —                    |
| **Markdown**        | marksman       | markdownlint                | live preview         |

Plus quality-of-life: auto-closing JSX/TSX tags, inline `package.json` versions, inlay hints, and a per-project virtualenv picker.

## 🤖 Using Claude AI

Two complementary surfaces, both reusing your existing Claude login:

- **In the terminal** — press `prefix` + `a` in tmux to open Claude in a floating popup, anywhere.
- **In Neovim** — press `<leader>ac` to toggle Claude Code. Select code in visual mode and `<leader>as` to send it as context; review and accept/deny edits with `<leader>aa` / `<leader>ad`.

No API key is required — [claudecode.nvim](https://github.com/coder/claudecode.nvim) talks to the official `claude` CLI over its MCP/WebSocket protocol.

## 🎛️ Customizing

- **Add a Neovim plugin:** drop a new `lua/plugins/<name>.lua` spec — lazy.nvim loads it automatically.
- **Enable a LazyVim extra:** add an `{ import = "lazyvim.plugins.extras..." }` line to [`lua/config/lazy.lua`](nvim/.config/nvim/lua/config/lazy.lua), or run `:LazyExtras`.
- **Change the theme:** edit `style` in [`colorscheme.lua`](nvim/.config/nvim/lua/plugins/colorscheme.lua) and the matching values in the tmux/Ghostty configs.
- **Add a tool:** add it to the [`Brewfile`](Brewfile) and run `brew bundle`.

After editing tracked files, commit and push so your machines stay in sync.

## 🔄 Updating

```sh
# Pull the latest configs
cd ~/code/alireza-es/alireza-dev-env && git pull

# Update everything
brew bundle              # tools
nvim "+Lazy sync" +qa    # Neovim plugins
# tmux: prefix + U       # tmux plugins (via TPM)
```

## 🧹 Uninstalling

```sh
cd ~/code/alireza-es/alireza-dev-env
stow -D nvim tmux ghostty zsh starship sesh git   # remove the symlinks
```

Your backed-up originals remain in `~/dev-env-backup-<timestamp>/`.

## 🙌 Credits

Built on the shoulders of [LazyVim](https://www.lazyvim.org), [folke](https://github.com/folke)'s plugins,
[Ghostty](https://ghostty.org), [tmux](https://github.com/tmux/tmux),
[starship](https://starship.rs), and [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim).

<div align="center">

_Happy hacking._ 🚀

</div>

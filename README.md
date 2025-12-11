# Linux Desktop Dotfiles

Modern, modular configuration for Linux desktop with optimized zsh shell, kitty terminal, and system utilities. **Startup ZSH performance: ~150ms**.

## 📋 Prerequisites

### System Requirements

- **Linux** (tested on Arch Linux, works on based distro)
- **zsh 5.9+** (shell)
- **git** (for cloning and plugin management)

---

## 🛠️ Required Tools

### Core Shell & Terminal

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| **zsh** | 5.9+ | Shell runtime | `sudo pacman -S zsh` |
| **kitty** | latest | Terminal emulator | `sudo pacman -S kitty` |

### Plugin Managers & ZSH Extensions

| Tool | Purpose | Install |
|------|---------|----------|
| **Znap** | Plugin manager (simpler & faster) | Auto-installed on first `.zshrc` load |
| **zsh-autosuggestions** | Command suggestions | `znap` (auto) |
| **zsh-completions** | Extended completions | `znap` (auto) |
| **fast-syntax-highlighting** | Syntax highlighting | `znap` (auto) |
| **fzf-tab** | Fuzzy tab completion | `znap` (auto) |
| **history-search-multi-word** | Advanced history search | `znap` (auto) |
| **zsh-you-should-use** | Alias reminders | `znap` (auto) |

### Tools for Enhanced Shell Experience (CLI Utilities)

| Tool | Purpose | Install |
|------|---------|----------|
| **eza** | Modern `ls` replacement | `sudo pacman -S eza` |
| **fzf** | Fuzzy finder | `sudo pacman -S fzf` |
| **bat** | cat with syntax highlighting | `sudo pacman -S bat` |
| **zoxide** | cd replacement with history | `sudo pacman -S zoxide` |
| **Starship** | Prompt customization | `sudo pacman -S starship` |

### System Utilities

| Tool | Purpose | Install |
|------|---------|----------|
| **fastfetch** | System info display | `sudo pacman -S fastfetch` |
| **qt6ct** | Qt6 theme manager | `sudo pacman -S qt6ct` |
| **nano** | Text editor | `sudo pacman -S nano` |
| **code** | Text editor | `yay/paru visual-studio-code-bin` |

## ⚡ Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/ParaDevOne/dotfiles-plasma ~/.config/dotfiles
cd ~/.config/dotfiles
```

### 2. Install Core Tools

```bash
# Arch Linux
sudo pacman -S zsh kitty eza fzf bat zoxide starship fastfetch qt6ct --noconfirm
```

### 3. Install Dotfiles

```bash
# Backup existing config (optional)
mkdir -p ~/.config/backup
[[ -f ~/.zshrc ]] && cp ~/.zshrc ~/.config/backup/
[[ -d ~/.config/zsh ]] && cp -r ~/.config/zsh ~/.config/backup/

# Link dotfiles
ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
ln -sf ~/.config/dotfiles/.config/zsh ~/.config/
ln -sf ~/.config/dotfiles/.config/kitty ~/.config/
ln -sf ~/.config/dotfiles/.config/fastfetch ~/.config/
```

### 4. Initialize ZSH

```bash
# Change default shell
chsh -s /usr/bin/zsh

# Open new terminal or reload
zsh

source ~/.zshrc
```

---

## 📁 Directory Structure

```txt
dotfiles/
├── .zshrc                      # Entry point (sources modular configs)
├── .config/
│   ├── zsh/
│   │   ├── init.zsh           # PATH, env vars (LOAD FIRST)
│   │   ├── config.zsh         # Zsh options, history, completions
│   │   ├── znap.zsh           # Plugin manager (auto-install)
│   │   ├── aliases.zsh        # Command aliases
│   │   └── keybindings.zsh    # Keyboard shortcuts
│   ├── kitty/
│   │   ├── kitty.conf         # Main configuration
│   │   ├── theme.conf         # Catppuccin Macchiato theme
│   │   └── keybindings.conf   # Terminal keybindings
│   ├── fastfetch/
│   │   └── config.jsonc       # System info display config
│   └── qt6ct/
│       └── qt6ct.conf         # Qt6 theme settings
└── README.md                  # This file
```

---

## 🚀 Performance Optimization

### Shell Startup Time

```bash
# Benchmark startup
time zsh -i -c exit

# Debug plugin loading
znap list
```

**Target**: ~150ms with all plugins loaded

### Performance Strategy

- **Synchronous loading**: Znap sources plugins sequentially without delay
- **Early syntax highlighting**: fast-syntax-highlighting loads before other plugins
- **Syntax highlighting**: Loads synchronously before other plugins
- **Auto-completion**: Loads on-demand

---

## ⌨️ Keyboard Shortcuts

All keybindings are centralized and documented in **[`.config/KEYBINDINGS.md`](.config/KEYBINDINGS.md)** for easy reference.

### Quick Overview

| Tool | Keybindings | Documentation |
|------|-------------|---|
| **ZSH** | History, navigation, editing | [ZSH Keybindings](.config/KEYBINDINGS.md#zsh-shell-keybindings) |
| **Kitty** | Tab/window management, copy/paste | [Kitty Keybindings](.config/KEYBINDINGS.md#kitty-terminal-keybindings) |
| **Zellij** | Pane/tab management, navigation | [Zellij Keybindings](.config/KEYBINDINGS.md#zellij-terminal-multiplexer-keybindings) |

### Key Changes & Resolutions

- ✅ **Alt+S**: Sudo prefix (changed from deprecated `Esc Esc` to avoid Zellij conflicts)
- ✅ **Alt+hjkl**: Vim-style navigation in Zellij
- ✅ **Ctrl+Shift**: Universal Kitty prefix (avoids shell conflicts)

### Validation

Run keybindings validation:

```bash
./check-keybindings.sh
```

---

## ⚙️ Configuration

### Customize Aliases

Edit `~/.config/zsh/aliases.zsh`:

```bash
alias mycommand='actual command'
```

### Add Keybindings

ZSH keybindings are now **modularized** for better maintainability:

- **History navigation**: `~/.config/zsh/keybinds/history.zsh`
- **Word navigation**: `~/.config/zsh/keybinds/navigation.zsh`
- **Line editing**: `~/.config/zsh/keybinds/editing.zsh`
- **System utilities**: `~/.config/zsh/keybinds/system.zsh`

To add a new keybinding, edit the appropriate module or create a new one and source it in `~/.config/zsh/keybinds.zsh`.

Example (add to `~/.config/zsh/keybinds/custom.zsh`):

```bash
bindkey '^X' my-function
```

Then add to `~/.config/zsh/keybinds.zsh`:

```bash
source "$KEYBINDS_DIR/custom.zsh"
```

For **Kitty** keybindings, edit `~/.config/kitty/keybindings.conf`.

For **Zellij** keybindings, edit `~/.config/Code/User/zellij/config.kdl`.

**Important:** After any keybinding changes, test with the validation script:

```bash
./check-keybindings.sh
```

### Add Zsh Plugins

Edit `~/.config/zsh/znap.zsh`:

```bash
znap source owner/plugin-name
```

### Customize Terminal Theme

Edit `~/.config/kitty/theme.conf` (supports all Catppuccin variants)

---

## 🧪 Validation & Troubleshooting

### Validate Shell Config

```bash
# Test shell load
zsh -c "source ~/.zshrc && echo SUCCESS"
```

### Test Shell Loading

```bash
zsh -c "source ~/.zshrc && echo SUCCESS"
```

### Debug Startup Issues

```bash
# Check for errors
zsh -x ~/.zshrc 2>&1 | head -50

# List loaded plugins
znap list
```

### Common Issues

### Error: "bad set of key/value pairs for associative array"

- Check `~/.config/zsh/*.zsh` for `export ARRAY=()` instead of `typeset -A ARRAY=()`

### Slow startup time

- Profile: `time zsh -i -c exit`
- Check plugin load order in `znap.zsh`
- Disable unnecessary plugins

### Keybindings not working

- Test in kitty terminal: `kitty` (supports shell integration)
- Check conflict with other key bindings
- Run: `./check-keybindings.sh` to validate configuration
- Review: `.config/KEYBINDINGS.md` for conflict documentation

---

## 📚 External Tool Documentation

- **Znap**: <https://github.com/marlonrichert/zsh-snap>
- **Kitty**: <https://sw.kovidgoyal.net/kitty/>
- **fzf**: <https://github.com/junegunn/fzf>
- **Starship**: <https://starship.rs/>
- **Catppuccin**: <https://catppuccin.com/>

---

## 🔧 Manual Installation (if auto-install fails)

### Znap (Plugin Manager)

```bash
git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/plugins/zsh-snap
```

### Rust Tools

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Then install tools if needed
# Alternative: Via Arch Linux pacman (system packages)
sudo pacman -S zsh kitty eza fzf bat zoxide thefuck starship fastfetch --noconfirm
```

## 🆘 Support

If something breaks:

1. Check `.github/copilot-instructions.md` for architecture details
2. Validate shell config: `zsh -c "source ~/.zshrc && echo OK"`
3. Test shell: `zsh -c "source ~/.zshrc && echo OK"`
4. Check errors: `zsh -x ~/.zshrc 2>&1 | grep -i error`

---

**Last Updated**: 2025-12-1 | **Startup Time**: ~150ms | **Shell**: zsh 5.9+

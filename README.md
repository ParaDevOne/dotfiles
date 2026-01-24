# Linux Desktop Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Arch Linux](https://img.shields.io/badge/OS-Arch%20Linux-blue.svg)](https://archlinux.org)
[![Tested on EndeavourOS](https://img.shields.io/badge/Tested%20on-EndeavourOS-green.svg)](https://endeavousos.com)
[![ZSH](https://img.shields.io/badge/Shell-ZSH%205.9%2B-success.svg)](https://www.zsh.org)

Modern, modular configuration for Arch Linux & Arch-based distros with optimized ZSH shell, Kitty terminal, and developer tools. **ZSH startup: ~73ms** with instant prompt.

---

## 📖 Table of Contents

- [Quick Start](#-quick-start)
- [Prerequisites](#-Prerequisites)
- [Installation](#-installation)
- [Managing Dotfiles](#-managing-dotfiles-with-stow)
- [Directory Structure](#-structure)
- [Performance](#-performance)
- [Configuration](#-configuration)
- [Keybindings](#-keybindings)
- [Theming](#-theming)
- [Troubleshooting](#-troubleshooting-index)
- [Tools & Extensions](#-tools-reference)
- [Contributing](#-contributing)

---

## 🚀 Quick Start

**Minimal install** (5 minutes):

```bash
# 1. Clone
git clone https://github.com/ParaDevOne/dotfiles ~/dotfiles

# 2. Install dependencies
sudo pacman -S stow zsh kitty eza fzf bat fd

# 3. Deploy with Stow
cd ~/dotfiles && stow -t ~ dots home

# 4. Set ZSH as default shell
chsh -s $(which zsh)

# 5. Open new terminal
zsh
```

See [Installation](#-installation) for detailed steps and troubleshooting.

---

## 🛠️ Prerequisites

### System Requirements

- **OS**: Arch Linux or Arch-based distros (tested on **EndeavourOS**)
- **Shell**: zsh 5.9+
- **Package Manager**: pacman + AUR helper (yay/paru)

### Core Dependencies

```bash
# Essential
sudo pacman -S zsh git kitty stow

# CLI Tools
sudo pacman -S eza fzf bat

# Optional but recommended
sudo pacman -S lazygit fastfetch
```

---

## 📦 Installation

### Prerequisites

1. **Install GNU Stow** (if not already installed)

```bash
sudo pacman -S stow
```

2. **Install Antidote** (ZSH plugin manager)

```bash
yay -S antidote
```

### Installation Steps

#### 1. Clone Repository

```bash
git clone https://github.com/ParaDevOne/dotfiles ~/dotfiles
cd ~/dotfiles
```

#### 2. Backup Existing Config (Recommended)

```bash
# Create backup of existing configs
mkdir -p ~/.config/backup_$(date +%Y%m%d)
[[ -f ~/.zshrc ]] && cp ~/.zshrc ~/.config/backup_$(date +%Y%m%d)/
[[ -d ~/.config/zsh ]] && cp -r ~/.config/zsh ~/.config/backup_$(date +%Y%m%d)/
[[ -d ~/.config/kitty ]] && cp -r ~/.config/kitty ~/.config/backup_$(date +%Y%m%d)/
```

#### 3. Install Dependencies

```bash
# Essential tools
sudo pacman -S zsh kitty eza fzf bat fd

# Optional but recommended
sudo pacman -S lazygit fastfetch

# Set ZSH as default shell
chsh -s $(which zsh)
```

#### 4. Deploy Dotfiles with Stow

```bash
cd ~/dotfiles

# Deploy user dotfiles (ZSH, Kitty, VSCode, etc.)
stow -t ~ dots

# Deploy system/desktop environment configs (KDE Plasma)
stow -t ~ home
```

#### 5. Verify Installation

```bash
# Test ZSH configuration loads correctly
zsh -c

# Check if dotfiles were symlinked correctly
ls -la $ZDOTDIR/.zshrc
ls -la ~/.config/zsh
ls -la ~/.config/kitty
```

#### 6. Open New Terminal

```bash
# Option 1: Open new terminal
zsh

# Option 2: Logout/Login (required for shell change to take effect)
exit
```

---

## 🔄 Managing Dotfiles with Stow

### Deploy/Install Dotfiles

```bash
# Deploy user configs only
stow -t ~ dots

# Deploy system/DE configs only
stow -t ~ home

# Deploy both
stow -t ~ dots home
```

### Remove/Uninstall Dotfiles

```bash
# Remove user configs
stow -t ~ -D dots

# Remove system/DE configs
stow -t ~ -D home

# Remove both
stow -t ~ -D dots home
```

### Verify Symlinks

```bash
# List all created symlinks
ls -la ~/ | grep '^l'
ls -la ~/.config/ | grep '^l'
```

### Update Existing Installation

```bash
# Pull latest changes
git -C ~/dotfiles pull

# Re-apply stow (safe if no conflicts)
stow -t ~ dots home
```

**Key Benefits:**

- ✅ Clean separation between user and system configs
- ✅ Easy installation/uninstallation with Stow
- ✅ No manual symlink management
- ✅ Supports multiple machines with different configs

---

## 📁 Structure

This repository uses **GNU Stow** to manage dotfiles across two main categories:

```
dotfiles/
├── dots/                           # User-specific dotfiles (non-system)
│   └── .config/
│       ├── zsh/                    # ZSH configuration (modular)
│       │   ├── .zshrc             # Entry point + P10K instant prompt
│       │   ├── .zprofile          # Login environment
│       │   ├── .zsh_plugins.txt   # Antidote plugin list
│       │   ├── aliases.zsh        # Command aliases (~50)
│       │   ├── functions.zsh      # Shell functions
│       │   └── keybinds.zsh       # ZSH keybindings (~38)
│       ├── kitty/                  # Terminal emulator
│       │   ├── kitty.conf         # Main config (includes theme/keybindings)
│       │   ├── theme.conf         # Catppuccin Macchiato theme
│       │   └── keybindings.conf   # Terminal shortcuts (~25)
│       ├── Code/User/              # VS Code settings
│       │   └── settings.json      # Editor configuration
│       └── qt6ct/
│           └── qt6ct.conf         # Qt6 theming
│
├── home/                           # System/Desktop Environment config (KDE Plasma)
│   ├── .config/
│   │   ├── dolphinrc              # File manager settings
│   │   ├── katerc                 # Kate text editor
│   │   ├── konsolerc              # Konsole terminal emulator
│   │   ├── kwriterc               # KWrite text editor
│   │   └── user-dirs.dirs         # XDG user directories
│   └── .zshenv                    # Global shell environment (SHARED)
│
├── LICENSE
└── README.md
```

### What Each Directory Contains

**`dots/`** — User-specific, non-system-critical configs

- ZSH configuration with modular structure
- Terminal emulator (Kitty) configuration
- Text editor settings (VS Code)
- Qt6 theming

**`home/`** — System and Desktop Environment configs

- KDE Plasma settings (Dolphin, Kate, Konsole)
- Global shell environment variables
- XDG user directories configuration

---

## ⚡ Performance

### Benchmark Results

```bash
# Full startup (with all plugins)
❯ hyperfine 'zsh -i -c exit'
Time (mean ± σ):      63.5 ms ±   0.5 ms

# Perceived startup (P10K instant prompt)
< 10ms (prompt visible immediately)
```

### Optimization Techniques

1. **P10K Instant Prompt**: Renders prompt from cache before loading config
2. **Antidote Turbo Mode**: Defers non-critical plugins with `wait lucid`
3. **Compinit Caching**: Only regenerates on `.zshrc` changes
4. **Smart Plugin Loading**: Minimal plugin set, aggressive caching

### Performance Profiling

```bash
# Detailed profiling
zsh -i -c 'zmodload zsh/zprof && source ~/.zshrc && zprof' | head -20

# Benchmark
hyperfine --warmup 3 'zsh -i -c exit'
```

---

## 🔧 Configuration

### Customize Plugins

Edit `~/.config/zsh/.zsh_plugins.txt`:

```bash
# Add new plugin
romkatv/powerlevel10k
owner/your-new-plugin
```

Then reload ZSH:

```bash
exec zsh
```

### Aliases

Comprehensive aliases are organized by category in `~/.config/zsh/aliases.zsh`:

**Navigation:**

- `..` → `cd ..`
- `...` → `cd ../..`

**File Listing:**

- `ls` → `eza -a --icons --group-directories-first`
- `ll` → `eza -al --icons --git`
- `lt` → `eza --tree --level=2`

**Development:**

- `lg` → `lazygit`

See full list in `~/.config/zsh/aliases.zsh` with inline comments explaining each section.

## 🎨 Theming

### Active Theme: Catppuccin Macchiato

Color scheme applied consistently across:

- **Kitty**: `~/.config/kitty/kitty.conf` (includes theme.conf)
- **P10K Prompt**: Generated via `p10k configure`
- **FZF**: Catpuccin-Macchiato colors in `~/.config/zsh/config.zsh`

### Change Theme

**Kitty:**

```bash
# Download new theme
cd ~/.config/kitty
curl -O https://raw.githubusercontent.com/catppuccin/kitty/main/themes/mocha.conf

# Update kitty.conf
include ./mocha.conf
```

**P10K:**

```bash
p10k configure
```

---

## 🧪 Testing & Validation

### Test Configuration

```bash
# Syntax check
zsh -n ~/.zshrc

# Full load test
zsh -c "source ~/.zshrc && echo '✓ Config loaded successfully'"

# Check for errors
zsh -x ~/.zshrc 2>&1 | grep -i error
```

### Benchmark

```bash
# Simple benchmark
for i in {1..10}; do time zsh -i -c exit; done 2>&1 | grep real

# Precise benchmark (requires hyperfine)
hyperfine --warmup 3 'zsh -i -c exit'
```

### Debug Slow Startup

```bash
# Profile with zprof
zsh -i -c 'zmodload zsh/zprof && source ~/.zshrc && zprof' | head -20

# Check plugin load times
antidote bundle ~/.config/zsh/.zsh_plugins.txt
```

---

## 🔧 Tools Reference

### Core Tools

| Tool | Purpose | Config |
| --- | --- | --- |
| **zsh** | Shell | `~/.zshrc`, `~/.config/zsh/` |
| **antidote** | Plugin manager | `~/.config/zsh/.zsh_plugins.txt` |
| **powerlevel10k** | Prompt | `~/.p10k.zsh` |
| **kitty** | Terminal | `~/.config/kitty/` |
| **atuin** | History search | `~/.config/atuin/client.toml` |

### CLI Utilities

| Tool | Replaces | Usage |
| --- | --- | --- |
| **eza** | ls | `ls`, `ll`, `lt` |
| **bat** | cat | `cat`, `ccat` |
| **fd** | find | `fd <pattern>` |
| **ripgrep** | grep | `rg <pattern>` |
| **zoxide** | cd | `z <dir>`, aliased to `cd` |
| **fzf** | — | Fuzzy finder (Ctrl+T, Ctrl+R, Alt+C) |
| **atuin** | history | Enhanced history (Ctrl+R) |
| **lazygit** | git | TUI for git operations |

### VS Code Extensions

Recommended extensions for development (automatically configured in `settings.json`):

| Extension | Purpose |
| --- | --- |
| **GitHub Copilot** | AI code suggestions |
| **Pylance** | Python language server |
| **Prettier** | Code formatter |
| **ESLint** | JavaScript linting |
| **Rust Analyzer** | Rust development |
| **Remote - SSH** | Remote development |
| **GitLens** | Enhanced git integration |
| **Thunder Client** | REST API client |

---

## 🆘 Troubleshooting Index

### Quick Links to Common Issues

- [Plugins not loading](#plugins-not-loading)
- [P10K not showing](#p10k-not-showing)
- [Slow startup](#slow-startup-after-changes)
- [Keybinding conflicts](#keybinding-conflicts)
- [ZSH not set as default](#zsh-not-set-as-default-shell)

---

### Plugins not loading

```bash
# Reinstall Antidote
rm -rf ~/.local/share/antidote
source ~/.zshrc

# Verify plugins
antidote bundle ~/.config/zsh/.zsh_plugins.txt
```

**Issue**: Plugins still not working?

1. Check for syntax errors: `zsh -n ~/.config/zsh/.zsh_plugins.txt`
2. Verify plugin URLs in `.zsh_plugins.txt`
3. Check GitHub connectivity: `curl -I https://github.com`

---

### P10K not showing

```bash
# Reconfigure P10K
p10k configure

# Check instant prompt cache
ls -la ~/.cache/p10k-instant-prompt-*

# Verify P10K is installed
ls -la ~/.local/share/antidote/powerlevel10k
```

**Issue**: Prompt still broken?

1. Delete and recreate the cache
2. Run `p10k configure` again
3. Verify terminal supports Unicode fonts

---

### Slow startup after changes

```bash
# Profile to identify slow plugins
zsh -i -c 'zmodload zsh/zprof && source ~/.zshrc && zprof' | head -30

# Check compinit dump age
ls -la ~/.config/zsh/.zcompdump*

# Regenerate completion cache
rm ~/.config/zsh/.zcompdump*
zsh
```

**Quick fixes**:

1. Remove unnecessary plugins from `.zsh_plugins.txt`
2. Use `wait` and `lucid` in plugin specifications
3. Verify disk I/O is not the bottleneck

---

### Keybinding conflicts

```bash
# List all current bindings
bindkey

# Test specific binding
bindkey '^R'  # Should show atuin

# Check for duplicate bindings
bindkey | grep -c 'Ctrl-'
```

**Issue**: Custom keybinding not working?

1. Verify syntax in `keybinds.zsh`
2. Check for conflicts with other plugins
3. Test with `bindkey <key>` to see what's mapped

---

### ZSH not set as default shell

```bash
# Check current shell
echo $SHELL

# List available shells
cat /etc/shells

# Change default shell
chsh -s /usr/bin/zsh

# Verify change (requires logout/login)
echo $SHELL
```

---

### Stow conflict errors

```bash
# Check for existing files/symlinks
stow --simulate -t ~ dots

# Force adopt conflicting files
stow --adopt -t ~ dots

# If conflicts persist, manually move
mkdir -p ~/.config/backup
mv ~/.zshrc ~/.config/backup/
stow -t ~ dots
```

---

### Reset to Defaults

```bash
# Remove all dotfiles
stow -t ~ -D dots home

# Remove ZSH configs
rm -rf ~/.zshrc ~/.zprofile ~/.config/zsh ~/.config/kitty ~/.config/atuin ~/.p10k.zsh

# Unset ZSH as default
chsh -s /bin/bash

# Reinstall from scratch
cd ~/dotfiles
stow -t ~ dots home
chsh -s $(which zsh)
zsh
```

---

## 📚 Additional Resources

Official documentation:

- **Antidote**: https://getantidote.github.io/
- **Powerlevel10k**: https://github.com/romkatv/powerlevel10k
- **Kitty**: https://sw.kovidgoyal.net/kitty/
- **Atuin**: https://atuin.sh/
- **FZF**: https://github.com/junegunn/fzf
- **Catppuccin**: https://catppuccin.com/

---

## 🤝 Contributing

Found a bug, have a suggestion, or want to improve something? Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Steps

1. Fork the repository
2. Test on fresh Arch Linux/EndeavourOS install
3. Benchmark startup time: `hyperfine 'zsh -i -c exit'`
4. Check for keybinding conflicts: Test all bindings
5. Submit a PR with clear description of changes

---

## 📄 License

MIT License - Feel free to use and modify.

See [LICENSE](LICENSE) for full terms.

---

**Maintained by**: [@ParaDevOne](https://github.com/ParaDevOne)
**Last Updated**: 2025-01-24
**ZSH Startup**: ~63ms (real), <10ms (perceived with P10K)
**Tested on**: Arch Linux, EndeavourOS

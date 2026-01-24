# Linux Desktop Dotfiles

Modern, modular configuration for Arch Linux desktop with optimized ZSH shell, Kitty terminal, and developer tools. **ZSH startup: ~63ms** with instant prompt.

## 📋 Overview

Highly optimized dotfiles featuring:
- ⚡ **Fast startup**: ~63ms ZSH with P10K instant prompt (<10ms perceived)
- 🎨 **Catppuccin Macchiato** theme across all tools
- 🔧 **Modular architecture**: Easy to customize and maintain
- 🚀 **Modern CLI tools**: eza, bat, fzf, zoxide, ripgrep
- 🔑 **Advanced keybindings**: ~80 shortcuts without conflicts

---

## 🛠️ Prerequisites

### System Requirements
- **OS**: Arch Linux (or Arch-based distros)
- **Shell**: zsh 5.9+
- **Package Manager**: pacman + AUR helper (yay/paru)

### Core Dependencies

```bash
# Essential
sudo pacman -S zsh git kitty

# CLI Tools
sudo pacman -S eza fzf bat fd ripgrep zoxide atuin

# Development
sudo pacman -S hyperfine # For benchmarking
```

---

## 🚀 Quick Install

### Prerequisites

1. **Install GNU Stow** (if not already installed)
   ```bash
   sudo pacman -S stow
   ```

2. **Install Antidote** (ZSH plugin manager)
   ```bash
   sudo pacman -S zsh-antidote
   ```

### Installation Steps

#### 1. Clone Repository

```bash
git clone https://github.com/ParaDevOne/dotfiles-plasma ~/dotfiles
cd ~/dotfiles
```

#### 2. Backup Existing Config (Optional)

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
sudo pacman -S zsh kitty eza fzf bat fd ripgrep zoxide atuin

# Optional but recommended
sudo pacman -S lazygit fastfetch xclip hyperfine

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
zsh -c "source ~/.zshrc && echo '✓ ZSH config loaded successfully'"

# Check if dotfiles were symlinked correctly
ls -la ~/.zshrc
ls -la ~/.config/zsh
ls -la ~/.config/kitty
```

#### 6. Logout and Login

```bash
# Option 1: Open new terminal
zsh

# Option 2: Logout/Login (required for shell change)
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

### Stow Management

Each subdirectory (`dots/`, `home/`) is managed independently with Stow:

```bash
# Deploy user dotfiles
stow -t ~ dots

# Deploy system/desktop environment config
stow -t ~ home

# Remove (unstow) dotfiles
stow -t ~ -D dots
stow -t ~ -D home
```

**Key Benefits:**
- ✅ Clean separation between user and system configs
- ✅ Easy installation/uninstallation with Stow
- ✅ No manual symlink management
- ✅ Supports multiple machines with different configs

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
2. **Zinit Turbo Mode**: Defers non-critical plugins with `wait lucid`
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

### ZSH Plugins (Zinit)

Installed automatically on first load:

| Plugin                       | Purpose              | Load Mode             |
| ---------------------------- | -------------------- | --------------------- |
| **powerlevel10k**            | Prompt theme         | Sync (instant prompt) |
| **fzf-tab**                  | Fuzzy completions    | Turbo                 |
| **zsh-completions**          | Extended completions | Turbo                 |
| **zsh-autosuggestions**      | Command suggestions  | Turbo                 |
| **fast-syntax-highlighting** | Syntax colors        | Turbo (last)          |
| **OMZ::git**                 | Git aliases          | Turbo                 |
| **OMZ::sudo**                | Alt+S for sudo       | Turbo                 |

### Customize Plugins

Edit `~/.config/zsh/zinit.zsh`:

```bash
# Add new plugin
zinit ice wait lucid
zinit light owner/repo
```

### Aliases

**Navigation:**
```bash
..     → cd ..
...    → cd ../..
cd     → zi (zoxide)
```

**File Listing:**
```bash
ls     → eza -a --icons --group-directories-first
ll     → eza -al --icons --git
lt     → eza --tree --level=2
```

**Development:**
```bash
lg     → lazygit
code   → code . (VSCode)
v/vi   → $EDITOR
```

**System:**
```bash
update → sudo pacman -Syu
install → sudo pacman -S
remove  → sudo pacman -Rns
```

Full list: `~/.config/zsh/aliases.zsh`

---

## ⌨️ Keybindings

### ZSH Shortcuts

**History:**
- `Ctrl+R` → Atuin fuzzy search
- `Up/Down` → Navigate history
- `Ctrl+P/N` → Navigate history (alt)
- `PageUp/Down` → Search history with current input

**Navigation:**
- `Ctrl+A/E` → Line start/end
- `Ctrl+←/→` → Word navigation
- `Alt+F/B` → Word navigation (emacs-style)

**Editing:**
- `Ctrl+W` → Delete word backward
- `Ctrl+K` → Kill to end of line
- `Ctrl+U` → Kill to start of line
- `Ctrl+Z/Y` → Undo/Redo
- `Alt+U/L/C` → Uppercase/Lowercase/Capitalize word

**Utilities:**
- `Alt+S` → Prepend/remove sudo
- `Ctrl+L` → Clear screen
- `Alt+.` → Insert last argument
- `Ctrl+X Ctrl+E` → Edit command in $EDITOR

Full reference: `~/.config/zsh/keybinds.zsh`

### Kitty Shortcuts

**Tabs:**
- `Ctrl+Shift+T` → New tab (with CWD)
- `Ctrl+Shift+W` → Close tab
- `Ctrl+Shift+→/←` → Navigate tabs
- `Ctrl+Shift+1-5` → Go to tab N

**Windows:**
- `Ctrl+Shift+Enter` → New window (with CWD)
- `Ctrl+Shift+]/[` → Navigate windows
- `Ctrl+Shift+R` → Resize mode

**Layouts:**
- `Ctrl+Shift+L` → Cycle layouts
- `Ctrl+Alt+Z` → Toggle fullscreen (stack)

**Hints (keyboard selection):**
- `Ctrl+Shift+E` → Open URLs
- `Ctrl+Shift+P>F` → Select paths
- `Ctrl+Shift+P>L` → Select lines
- `Ctrl+Shift+P>H` → Select git hashes

Full reference: `~/.config/kitty/keybindings.conf`

---

## 🎨 Theming

### Active Theme: Catppuccin Macchiato

- **Kitty**: `~/.config/kitty/kitty.conf` (includes theme.conf)
- **P10K**: Generated via `p10k configure`
- **FZF**: Dracula colors in `~/.config/zsh/config.zsh`

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
zinit times
```

---

## 🔧 Tools Reference

### Core Tools

| Tool              | Purpose        | Config                        |
| ----------------- | -------------- | ----------------------------- |
| **zsh**           | Shell          | `~/.zshrc`, `~/.config/zsh/`  |
| **zinit**         | Plugin manager | `~/.config/zsh/zinit.zsh`     |
| **powerlevel10k** | Prompt         | `~/.p10k.zsh`                 |
| **kitty**         | Terminal       | `~/.config/kitty/`            |
| **atuin**         | History search | `~/.config/atuin/config.toml` |

### CLI Utilities

| Tool        | Replaces | Usage                                |
| ----------- | -------- | ------------------------------------ |
| **eza**     | ls       | `ls`, `ll`, `lt`                     |
| **bat**     | cat      | `cat`, `ccat`                        |
| **fd**      | find     | `fd <pattern>`                       |
| **ripgrep** | grep     | `rg <pattern>`                       |
| **zoxide**  | cd       | `z <dir>`, aliased to `cd`           |
| **fzf**     | -        | Fuzzy finder (Ctrl+T, Ctrl+R, Alt+C) |
| **atuin**   | history  | Enhanced history (Ctrl+R)            |

---

## 🆘 Troubleshooting

### Common Issues

**Plugins not loading:**
```bash
# Reinstall Zinit
rm -rf ~/.local/share/zinit
source ~/.zshrc
```

**P10K not showing:**
```bash
# Reconfigure
p10k configure

# Check instant prompt cache
ls -la ~/.cache/p10k-instant-prompt-*
```

**Slow startup after adding plugins:**
```bash
# Profile
zsh -i -c 'zmodload zsh/zprof && source ~/.zshrc && zprof'

# Check compinit dump
ls -la ~/.config/zsh/.zcompdump
```

**Keybinding conflicts:**
```bash
# List all bindings
bindkey

# Test specific binding
bindkey '^R'  # Should show: atuin
```

### Reset to Defaults

```bash
# Remove all configs
rm -rf ~/.zshrc ~/.zprofile ~/.config/zsh ~/.config/kitty ~/.config/atuin ~/.p10k.zsh

# Reinstall
cd ~/.dotfiles
./install.sh  # (if you create an install script)
```

---

## 📚 Documentation

- **Zinit**: https://github.com/zdharma-continuum/zinit
- **Powerlevel10k**: https://github.com/romkatv/powerlevel10k
- **Kitty**: https://sw.kovidgoyal.net/kitty/
- **Atuin**: https://atuin.sh/
- **FZF**: https://github.com/junegunn/fzf
- **Catppuccin**: https://catppuccin.com/

---

## 🤝 Contributing

Found a bug or have a suggestion? Open an issue or PR!

**Before submitting:**
1. Test on fresh Arch Linux install
2. Benchmark startup time: `hyperfine 'zsh -i -c exit'`
3. Check for conflicts: Run all keybindings

---

## 📄 License

MIT License - Feel free to use and modify.

---

**Maintained by**: [@ParaDevOne](https://github.com/ParaDevOne)
**Last Updated**: 2025-12-19
**ZSH Startup**: ~63ms (real), <10ms (perceived with P10K)
**Tested on**: EndeavourOS (Arch-based)

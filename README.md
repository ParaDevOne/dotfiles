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

### 1. Clone Repository

```bash
git clone https://github.com/ParaDevOne/dotfiles-plasma ~/.dotfiles
cd ~/.dotfiles
```

### 2. Backup Existing Config

```bash
# Create backup
mkdir -p ~/.config/backup_$(date +%Y%m%d)
[[ -f ~/.zshrc ]] && cp ~/.zshrc ~/.config/backup_$(date +%Y%m%d)/
[[ -d ~/.config/zsh ]] && cp -r ~/.config/zsh ~/.config/backup_$(date +%Y%m%d)/
[[ -d ~/.config/kitty ]] && cp -r ~/.config/kitty ~/.config/backup_$(date +%Y%m%d)/
```

### 3. Install Dependencies

```bash
# Core tools
sudo pacman -S zsh kitty eza fzf bat fd ripgrep zoxide atuin hyperfine

# Optional but recommended
sudo pacman -S lazygit fastfetch xclip

# Set ZSH as default shell
chsh -s $(which zsh)
```

### 4. Deploy Dotfiles

```bash
# Link configs
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.zprofile ~/.zprofile
ln -sf ~/.dotfiles/.config/zsh ~/.config/
ln -sf ~/.dotfiles/.config/kitty ~/.config/
ln -sf ~/.dotfiles/.config/atuin ~/.config/
ln -sf ~/.dotfiles/.config/fastfetch ~/.config/
```

### 5. Initialize

```bash
# Logout and login (for shell change)
# Or open new terminal
zsh

# Zinit will auto-install on first load
# P10K configuration wizard will run automatically
p10k configure
```

---

## 📁 Structure

```
~/.dotfiles/
├── .zshrc                          # Entry point + P10K instant prompt
├── .zprofile                       # Login shell (Wayland, XDG, PATH)
├── .config/
│   ├── zsh/
│   │   ├── config.zsh             # Options, history, completions, FZF
│   │   ├── zinit.zsh              # Plugin manager + plugins
│   │   ├── aliases.zsh            # Command aliases (~50)
│   │   └── keybinds.zsh           # ZSH keybindings (~38)
│   ├── kitty/
│   │   ├── kitty.conf             # Main config + theme
│   │   ├── kittysession.conf      # Startup tabs
│   │   └── keybindings.conf       # Terminal shortcuts (~80)
│   ├── atuin/
│   │   └── config.toml            # Enhanced history search
│   └── fastfetch/
│       └── config.jsonc           # System info display
└── README.md
```

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
**Tested on**: Arch Linux + Garuda Linux

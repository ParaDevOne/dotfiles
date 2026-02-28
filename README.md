# Linux Desktop Dotfiles - Hyprland

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Arch Linux](https://img.shields.io/badge/OS-Arch%20Linux-blue.svg)](https://archlinux.org)
[![Tested on EndeavourOS](https://img.shields.io/badge/Tested%20on-EndeavourOS-green.svg)](https://endeavousos.com)

Modern, modular configuration for Arch Linux & Arch-based distros.

## Prerequisites

### System Requirements

- **OS**: Arch Linux or Arch-based distros (tested on **EndeavourOS**)
- **Package Manager**: Pacman + Paru (AUR helper)

### Dependencies

```bash
# Essential
yay -S zsh git kitty fd rofi awww

# CLI Tools
yay -S eza fzf bat antidote

# Optional but recommended
yay -S lazygit fastfetch
```

## Installation

```bash
# 1. Clone
git clone --recurse-submodules https://github.com/ParaDevOne/dotfiles ~/dotfiles

# 2. Change directory to ~/dotfiles
cd ~/dotfiles

# 3. Create symlinks
./install
```

---

## 📄 License

MIT License - Feel free to use and modify.

See [LICENSE](LICENSE) for full terms.

---

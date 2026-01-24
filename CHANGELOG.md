# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added (Future)

- Placeholder for upcoming features
- Machine-specific profiles
- Additional documentation

## [1.1.0] - 2025-01-24

### Added

- Comprehensive README with table of contents and troubleshooting index
- Quick Start section for minimal 5-minute setup
- Tested on EndeavourOS with compatibility badges
- Extended documentation for configuration files
- Tools reference table with VS Code extensions
- Detailed troubleshooting guide with multiple solutions per issue
- CHANGELOG.md for version tracking
- CONTRIBUTING.md for contributor guidelines

### Changed

- Restructured README for better navigation
- Updated installation instructions with clearer steps
- Improved Stow management documentation
- Enhanced keybindings documentation with descriptions
- Migrated plugin manager documentation from Zinit to Antidote

### Fixed

- Markdown formatting issues in documentation
- Corrected plugin manager references

## [1.0.0] - 2025-01-19

### Added

- Initial release with stable dotfiles configuration
- ZSH setup with ~63ms startup time
- Kitty terminal configuration with Catppuccin theme
- KDE Plasma desktop environment configs
- VS Code settings with Tokyo Night Storm theme
- GNU Stow-based dotfile management
- Powerlevel10k prompt with instant rendering
- 50+ command aliases organized by category
- 38+ keybindings for ZSH and Kitty
- Antidote plugin manager with 7+ essential plugins
- Performance benchmarking tools and documentation
- Testing and validation procedures

### Features

- **Fast Performance**: ~63ms ZSH startup with <10ms perceived (P10K instant prompt)
- **Modern CLI Tools**: Integration with eza, bat, fzf, zoxide, ripgrep, atuin, lazygit
- **Clean Architecture**: Modular ZSH configuration with separate files for aliases, keybinds, functions
- **Theme Consistency**: Catppuccin Macchiato across Kitty, P10K, and FZF
- **XDG Compliance**: Proper XDG Base Directory handling via .zshenv
- **Easy Management**: GNU Stow for atomic install/uninstall operations

---

## Migration Guide

### From Zinit to Antidote (v1.0 → v1.1)

**Why?** Antidote is simpler, faster, and more actively maintained.

**Steps:**

1. Backup old configuration:

```bash
cp ~/.config/zsh/zinit.zsh ~/.config/zsh/zinit.zsh.bak
```

2. Remove Zinit:

```bash
rm -rf ~/.local/share/zinit
```

3. Install Antidote:

```bash
sudo pacman -S zsh-antidote
```

4. Update `.zsh_plugins.txt` with Antidote syntax

5. Reload shell:

```bash
source ~/.zshrc
```

---

## Planned Features

- [ ] Machine-specific configuration profiles (laptop, server, vm)
- [ ] Automated setup script with dependency checking
- [ ] CI/CD validation on PRs
- [ ] Multi-distro support (Debian, Fedora, NixOS)
- [ ] Configuration backup/restore utilities
- [ ] Theme switching script

---

## Known Issues

### No known issues at this time

---

## Support

For issues, questions, or suggestions:

1. Check [Troubleshooting](README.md#-troubleshooting-index) section in README
2. Open an issue on GitHub
3. See [Contributing](CONTRIBUTING.md) for guidelines

---

**Note**: This changelog started with v1.0.0. Earlier changes not documented.

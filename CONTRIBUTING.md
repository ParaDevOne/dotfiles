# Contributing to Linux Desktop Dotfiles

Thanks for your interest in contributing! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

- Be respectful and constructive in all interactions
- Provide helpful feedback and accept constructive criticism
- Focus on what is best for the community

## How Can You Contribute?

### Reporting Bugs

Found a bug? Please help us fix it!

1. **Check existing issues** to avoid duplicates
2. **Create a detailed report** including:
   - Your system (Arch Linux / EndeavourOS version)
   - Steps to reproduce the issue
   - Expected vs actual behavior
   - Environment details (shell version, terminal, etc.)
   - Output of relevant commands or logs

### Suggesting Enhancements

Have an idea to improve the project?

1. **Check existing discussions** to avoid duplicates
2. **Describe your suggestion** clearly:
   - What problem does it solve?
   - Why is this useful?
   - How would you implement it?

### Submitting Pull Requests

Ready to contribute code?

**Before you start:**

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test thoroughly

**Requirements for PRs:**

- Test on fresh Arch Linux or EndeavourOS installation
- Verify ZSH startup time: `hyperfine --warmup 3 'zsh -i -c exit'`
- Test all keybindings to prevent conflicts
- Update relevant documentation (README, inline comments)
- Include clear PR description explaining changes
- Reference any related issues with `Closes #issue-number`

**Testing Checklist:**

- [ ] ZSH loads without errors: `zsh -n ~/.zshrc`
- [ ] Full startup test: `zsh -c "source ~/.zshrc && echo 'OK'"`
- [ ] Startup time is acceptable (~63ms ±5ms)
- [ ] No keybinding conflicts
- [ ] All aliases work
- [ ] Plugins load correctly
- [ ] README/docs updated if needed

## Contribution Guidelines

### Code Style

**ZSH Configuration:**

- Use clear, descriptive variable names
- Add comments for non-obvious logic
- Group related functionality together
- Follow existing style conventions
- Keep functions organized in separate files

**Comments:**

```bash
# Good: Explains WHY, not just WHAT
# Use fzf for fuzzy command search instead of standard Ctrl+R
bindkey '^R' 'fzf-history-widget'

# Avoid: Obvious comments
# Set history size
HISTSIZE=10000
```

### File Organization

```
dots/.config/zsh/
├── .zshrc              # Entry point (minimal)
├── .zprofile           # Login shell setup
├── .zsh_plugins.txt    # Plugin declarations
├── aliases.zsh         # Command aliases (organized by category)
├── functions.zsh       # Custom shell functions
├── keybinds.zsh        # Keybindings (organized by category)
└── (config files)      # Theme, colors, etc.
```

### Commit Messages

Use clear, descriptive commit messages:

```bash
# Good
feat: add fzf-tab plugin for improved completions
fix: correct P10K instant prompt cache path
docs: update keybindings documentation

# Avoid
fix stuff
update
changes
```

### Documentation Standards

- Update README.md if you change user-facing functionality
- Add inline comments for complex configurations
- Keep troubleshooting section current
- Document new dependencies with installation commands

## Project Structure Overview

```
dotfiles/
├── dots/              # User-specific configs (non-system)
│   └── .config/
│       ├── zsh/      # Shell configuration (modular)
│       ├── kitty/    # Terminal emulator
│       └── Code/     # VS Code settings
│
├── home/              # System/desktop environment configs
│   └── .config/       # KDE Plasma settings
│
├── README.md          # Main documentation
├── CHANGELOG.md       # Version history
├── CONTRIBUTING.md    # This file
└── LICENSE            # MIT License
```

## Development Workflow

1. **Set up your environment:**

```bash
# Clone your fork
git clone https://github.com/your-username/dotfiles-plasma ~/dotfiles-dev

# Create feature branch
cd ~/dotfiles-dev
git checkout -b feature/my-feature
```

2. **Make changes and test:**

```bash
# Test in isolated environment (recommended)
mkdir -p ~/.dotfiles-test
stow -t ~/.dotfiles-test dots home

# Or test directly
cd ~/dotfiles-dev
stow -t ~ dots home
```

3. **Verify everything works:**

```bash
# Run validation tests
zsh -n ~/.zshrc
zsh -c "source ~/.zshrc && echo '✓ Configuration valid'"
hyperfine --warmup 3 'zsh -i -c exit'
```

4. **Commit and push:**

```bash
git add .
git commit -m "feat: describe your changes"
git push origin feature/my-feature
```

5. **Open a Pull Request:**
   - Go to GitHub and create a PR from your fork
   - Provide clear title and description
   - Reference any related issues
   - Wait for review

## Testing Guidelines

### Performance Testing

Ensure changes don't negatively impact startup time:

```bash
# Before changes
hyperfine --warmup 3 'zsh -i -c exit'

# Make changes

# After changes (should be similar or faster)
hyperfine --warmup 3 'zsh -i -c exit'
```

### Configuration Testing

```bash
# Syntax check
zsh -n ~/.zshrc
zsh -n ~/.config/zsh/aliases.zsh
zsh -n ~/.config/zsh/keybinds.zsh

# Load test
zsh -c "source ~/.zshrc && echo '✓ All files load successfully'"

# Manual verification
- Type new aliases and verify they work
- Test modified keybindings
- Check that plugins load
- Verify no shell errors
```

### Installation Testing

Test on a clean system:

```bash
# Create test user
sudo useradd -m -s /bin/bash testuser
sudo su - testuser

# Follow install steps
git clone ~/dotfiles
cd ~/dotfiles
sudo pacman -S stow zsh-antidote ...
stow -t ~ dots home

# Verify
zsh
# Test commands and features
```

## Areas for Contribution

### High Priority

- [ ] Bug fixes (always welcome)
- [ ] Performance improvements
- [ ] Clearer documentation
- [ ] Better error messages

### Medium Priority

- [ ] New aliases or keybindings
- [ ] Theme improvements
- [ ] Plugin optimizations
- [ ] Extended troubleshooting guides

### Lower Priority

- [ ] Multi-distro support (Debian, Fedora, etc.)
- [ ] Configuration profiles for different use cases
- [ ] Automated setup scripts
- [ ] GUI configuration tools

## Getting Help

- **Documentation**: Check [README.md](README.md)
- **Issues**: Search existing GitHub issues
- **Discussions**: Start a discussion for questions
- **Troubleshooting**: See [Troubleshooting Index](README.md#-troubleshooting-index)

## Recognition

Contributors will be acknowledged in:

- [README.md](README.md) - in a contributors section (to be added)
- Commit history
- Release notes (for significant contributions)

## Questions?

- Open a GitHub issue with the `question` label
- Start a discussion in the repository
- Comment on related pull requests

---

**Thank you for contributing!** 🎉

Even small improvements make a difference. Whether it's fixing a typo, improving documentation, or optimizing performance, your contribution helps make this project better for everyone.

---

*Last updated: 2025-01-24*

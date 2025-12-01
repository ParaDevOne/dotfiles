# AI Agent Instructions for Dotfiles Repository

## Project Overview
This is a **Linux desktop dotfiles repository** containing modular configuration for zsh shell, kitty terminal, and system utilities. The architecture prioritizes **startup performance** (~150ms) through efficient, synchronous plugin loading.

## Directory Structure
```
dotfiles/
├── .config/
│   ├── zsh/            # Shell configuration (modular, sourced from .zshrc)
│   ├── kitty/          # Terminal emulator config (theme + keybindings)
│   ├── fastfetch/      # System info display (JSON-based config)
│   └── qt6ct/          # Qt6 theming
│   .zshrc              # Main entry point (sources modular configs)
└── .zprfile            # Zsh performance profile data
```

## Critical Architecture Patterns

### Zsh Configuration (Most Important)
**Modular sourcing order matters**. `.zshrc` loads in strict sequence:
1. `init.zsh` - PATH, environment variables, critical tools (must be first)
2. `config.zsh` - Zsh options, history, completions
3. `znap.zsh` - Plugin manager (simpler but less optimized)
4. `aliases.zsh` - Command aliases
5. `keybindings.zsh` - Keyboard shortcuts

## Key Conventions

### JSON/JSONC Configuration (fastfetch)
- Uses Nerd Font icons with numeric color codes: `{#31}` (red), `{#32}` (green), etc.
- Format: `"│ {#color}icon name  {#keys}│"` for consistent module display
- Separator structure: `├───────────┤` between logical sections

### Shell Script Conventions
- Use `typeset -A` for associative arrays in zsh (not `export ARRAY=()`), else "bad set of key/value pairs" error
- Bind keys with `bindkey` (not `map`)
- Use `zstyle` for plugin configuration
- Environment variables in `.zshrc` modules use `export` with coherent naming

### Terminal Configuration (Kitty)
- Theme: Catppuccin Macchiato (dark mode, soothing colors)
- Font: Hack Nerd Font Mono, size 11pt
- Keybindings defined in separate `keybindings.conf`

## Common Tasks

### Adding a New Zsh Plugin
```bash
# In znap.zsh, add to the plugin sourcing block:
znap source owner/plugin-name
```

### Fixing Syntax Errors
- Shell: Check array initialization with `typeset -A` not `export`
- JSON: Configuration file (no external validation needed)
- Zsh: Source test with `zsh -x ~/.zshrc 2>&1 | head -50`

### Performance Profiling
```bash
# Time shell startup
time zsh -i -c exit

# Debug plugin loading order
znap list
```

## Files Not to Modify Without Planning
- `.zshrc`: Entry point—changes affect all shells; test with `zsh -c "source ~/.zshrc; echo OK"`
- `znap.zsh`: Plugin loading order is critical; test after edits
- `keybindings.zsh`: Keyboard conflicts; test in actual terminal

## Testing & Validation
- Test shell load: `zsh -c "source ~/.zshrc && echo SUCCESS"` (should complete in <500ms)
- Test shell load: `zsh -c "source ~/.zshrc && echo SUCCESS"` (should complete in <500ms)
- Manual test: Open new kitty window; check for errors in startup

## External Tool Integration
- **fzf**: Auto-init if present; used by history search
- **zoxide**: Navigation helper (auto-init)
- **Starship**: Prompt (evaluated at end of .zshrc via `eval`)
- **fzf**: Auto-init if present; used by history search

---

**Last Updated**: 2025-11-29 | **Startup Time**: ~150ms | **Shell**: zsh 5.9+

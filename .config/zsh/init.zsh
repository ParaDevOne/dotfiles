# =============================================================================
# Modular Configuration Loading
# =============================================================================

# 1. Config
source ~/.config/zsh/config.zsh

# 2. Plugins
source ~/.config/zsh/znap.zsh

# 3. Aliases
source ~/.config/zsh/aliases.zsh

# 4. Keybindings
source ~/.config/zsh/keybinds.zsh

# =============================================================================
# Environment Setup
# =============================================================================

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/lib/ccache/bin:$PATH"

# Editor configuration
export EDITOR=nano
export VISUAL=code

# =============================================================================
# Terminal & Display
# =============================================================================

# Enable colors in less
export LESS="-R"

# =============================================================================
# FZF Configuration (if installed)
# =============================================================================

if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS='--height 50% --multi --reverse --border'
fi

# =============================================================================
# External Tools Initialization
# =============================================================================

# FZF (fuzzy finder)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# Zoxide (navigate directories faster)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Atuin (enhanced shell history)
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

# =============================================================================
# Development Tools
# =============================================================================

# Rust/Cargo configuration
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

start_if_needed

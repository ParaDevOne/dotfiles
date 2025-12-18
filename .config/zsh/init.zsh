# =============================================================================
# Modular Configuration Loading
# =============================================================================

# 1. Config
source ~/.config/zsh/config.zsh

# 2. Plugins
source ~/.config/zsh/zinit.zsh

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
# Development Tools
# =============================================================================

# Rust/Cargo configuration
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

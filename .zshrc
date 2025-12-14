# -----------------------------------------------------
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#
# Performance: ~62ms startup (482 líneas modulares)
# Last benchmark: 2025-12-03
# -----------------------------------------------------

# Source modular configuration
source ~/.config/zsh/init.zsh

# =============================================================================
# External Tools Initialization
# =============================================================================

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

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

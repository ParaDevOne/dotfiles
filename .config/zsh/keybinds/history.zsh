# =============================================================================
# History Navigation Keybindings
# =============================================================================

# History search multi-word (Ctrl+R) - Advanced history search
bindkey '^R' history-search-multi-word

# Basic history navigation with arrow keys
bindkey '^[[A' up-line-or-history      # Up arrow
bindkey '^[[B' down-line-or-history    # Down arrow

# Ctrl+P/Ctrl+N for history navigation
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

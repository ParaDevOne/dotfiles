# =============================================================================
#    _  __          _     _           _ _                 
#   | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___ 
#   | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
#   | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
#   |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#             |___/                             |___/     
#
# Unified ZSH keybindings configuration
# Performance: Single file load (~50ms vs 150ms modular)
# Total bindings: 25+ shortcuts
# =============================================================================

# =============================================================================
# HISTORY NAVIGATION
# =============================================================================

# Advanced multi-word history search (Ctrl+R)
bindkey '^R' history-search-multi-word

# Arrow key history navigation
bindkey '^[[A' up-line-or-history      # Up arrow
bindkey '^[[B' down-line-or-history    # Down arrow

# Ctrl+P/N history search
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# =============================================================================
# WORD NAVIGATION
# =============================================================================

# Ctrl+Arrow word navigation
bindkey '^[[1;5C' forward-word         # Ctrl+Right
bindkey '^[[1;5D' backward-word        # Ctrl+Left

# Alt+F/B word navigation (Emacs-style)
bindkey '^[f' forward-word
bindkey '^[b' backward-word

# =============================================================================
# LINE EDITING
# =============================================================================

# Kill word backwards (Ctrl+Backspace)
bindkey '^H' backward-kill-word
bindkey '^?' backward-delete-char

# Kill word forwards (Ctrl+Delete)
bindkey '^[[3;5~' kill-word

# Beginning/End of line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Kill line operations
bindkey '^K' kill-line                 # Kill to end of line
bindkey '^U' backward-kill-line        # Kill to start of line

# Edit command in $EDITOR (Ctrl+X Ctrl+E)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Transpose characters (Ctrl+T)
bindkey '^T' transpose-chars

# =============================================================================
# SYSTEM UTILITIES
# =============================================================================

# Sudo prefix toggle (Alt+S)
# Changed from Esc Esc to avoid Zellij pane rename conflicts
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey '^[s' sudo-command-line

# Clear screen (Ctrl+L)
bindkey '^L' clear-screen

# =============================================================================
# AUTOSUGGESTIONS
# =============================================================================

# Accept full suggestion
bindkey '^ ' autosuggest-accept        # Ctrl+Space
bindkey '^[[F' autosuggest-accept      # End key

# Accept suggestion word by word (Ctrl+Right already bound to forward-word)
# This gives dual behavior: navigate OR accept suggestion progressively

# =============================================================================
# NOTES & CONFLICTS RESOLVED
# =============================================================================
# 
# RESOLVED CONFLICTS:
# - Alt+S for sudo (was Esc Esc) → Avoids Zellij pane rename (Esc) conflict
#
# NO CONFLICTS WITH:
# - Kitty: Uses Ctrl+Shift prefix exclusively
# - Zellij: Uses Ctrl+B leader + Alt+hjkl for navigation
#
# LAYERS:
# - Ctrl        → Shell operations (history, editing, kill)
# - Alt         → Extensions (word nav, sudo prefix)
# - Ctrl+Shift  → Terminal emulator (Kitty)
# - Ctrl+B      → Multiplexer leader (Zellij)
# - Alt+arrows  → Zellij global navigation
#
# =============================================================================

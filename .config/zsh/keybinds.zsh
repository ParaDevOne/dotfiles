# =============================================================================
#    _  __          _     _           _ _                 
#   | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___ 
#   | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
#   | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
#   |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#             |___/                             |___/     
#
# ZSH keybindings
# Total bindings: ~18 shortcuts
# =============================================================================

# =============================================================================
# HISTORY NAVIGATION
# =============================================================================
# NOTE: Ctrl+R is handled by Atuin (loaded in .zshrc after this file)
# We only keep basic arrow navigation for manual history browsing

# Arrow key history navigation (basic fallback)
bindkey '^[[A' up-line-or-history      # Up arrow
bindkey '^[[B' down-line-or-history    # Down arrow

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
# KEYBINDING LAYERS & CONFLICTS
# =============================================================================
# 
# LAYER SEPARATION:
# - Ctrl        → Shell operations (editing, navigation)
# - Alt         → Shell extensions (sudo, word nav)
# - Ctrl+Shift  → Terminal emulator (Kitty)
# - Ctrl+B      → Multiplexer leader (Zellij)
# - Ctrl+R      → Atuin history search (loaded in .zshrc)
#
# NO CONFLICTS WITH:
# - Atuin: Uses Ctrl+R (loaded AFTER this file in .zshrc)
# - Kitty: Uses Ctrl+Shift prefix exclusively
# - Zellij: Uses Ctrl+B leader + Alt+hjkl navigation
#
# REMOVED REDUNDANT BINDINGS:
# - history-search-multi-word (replaced by Atuin)
# - Ctrl+P/N history search (Atuin handles this)
# - Ctrl+R binding (Atuin overrides it automatically)
#
# =============================================================================

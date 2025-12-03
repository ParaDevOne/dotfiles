# =============================================================================
# Keybindings Configuration
# =============================================================================

# =============================================================================
# History Navigation
# =============================================================================

# History search multi-word (Ctrl+R) - Advanced history search
bindkey '^R' history-search-multi-word

# Basic history navigation with arrow keys
bindkey '^[[A' up-line-or-history      # Up arrow
bindkey '^[[B' down-line-or-history    # Down arrow

# Ctrl+P/Ctrl+N for history navigation
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# =============================================================================
# Word Navigation (Ctrl+Left/Right)
# =============================================================================

# Forward/Backward word
bindkey "^[[1;5C" forward-word         # Ctrl+Right
bindkey "^[[1;5D" backward-word        # Ctrl+Left

# Alt+F/Alt+B navigation by word
bindkey "^[f" forward-word
bindkey "^[b" backward-word

# =============================================================================
# Line Editing
# =============================================================================

# Kill word backwards (Ctrl+Backspace)
bindkey '^H' backward-kill-word
bindkey '^?' backward-delete-char

# Kill word forwards (Ctrl+Delete)
bindkey '^[[3;5~' kill-word

# Beginning/End of line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Delete to end of line (Ctrl+K)
bindkey '^K' kill-line

# Delete to beginning of line (Ctrl+U)
bindkey '^U' backward-kill-line

# =============================================================================
# Editing Commands
# =============================================================================

# Edit command in $EDITOR (Ctrl+X Ctrl+E)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Transpose characters (Ctrl+T)
bindkey '^T' transpose-chars

# =============================================================================
# Sudo Prefix (ESC ESC)
# =============================================================================

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# =============================================================================
# Clear Screen Integration (Ctrl+L)
# =============================================================================

bindkey '^L' clear-screen

# =============================================================================
# Autosuggestions Accept (Ctrl+Space o End)
# =============================================================================

# Accept full suggestion
bindkey '^ ' autosuggest-accept         # Ctrl+Space
bindkey '^[[F' autosuggest-accept       # End key

# Accept one word from suggestion
bindkey '^[[1;5C' forward-word          # Ctrl+Right

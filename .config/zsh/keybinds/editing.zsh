# =============================================================================
# Line Editing Keybindings
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

# Edit command in $EDITOR (Ctrl+X Ctrl+E)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Transpose characters (Ctrl+T)
bindkey '^T' transpose-chars

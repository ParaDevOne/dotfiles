# ZSH Keybindings

# Set keymap to emacs (default)
bindkey -e

# =============================================================================
# History Navigation
# =============================================================================

bindkey '^[[A' up-line-or-history          # Up arrow
bindkey '^[[B' down-line-or-history        # Down arrow
bindkey '^P' up-line-or-history            # Ctrl+P
bindkey '^N' down-line-or-history          # Ctrl+N

# Search history
bindkey '^S' history-incremental-search-forward   # Ctrl+S
bindkey '^[[5~' history-beginning-search-backward # Page Up
bindkey '^[[6~' history-beginning-search-forward  # Page Down

# =============================================================================
# Word Navigation
# =============================================================================

# Ctrl+Arrow
bindkey '^[[1;5C' forward-word             # Ctrl+Right
bindkey '^[[1;5D' backward-word            # Ctrl+Left

# Alt+Arrow
bindkey '^[[1;3C' forward-word             # Alt+Right
bindkey '^[[1;3D' backward-word            # Alt+Left

# Emacs-style
bindkey '^[f' forward-word                 # Alt+F
bindkey '^[b' backward-word                # Alt+B

# =============================================================================
# Vi-style HJKL Navigation (Ctrl+Alt+)
# =============================================================================
# [INFER] Movimiento estilo Vim sin joder el modo Emacs base

bindkey '^[^H' backward-char               # Ctrl+Alt+H (izquierda)
bindkey '^[^L' forward-char                # Ctrl+Alt+L (derecha)
bindkey '^[^K' up-line-or-history          # Ctrl+Alt+K (arriba)
bindkey '^[^J' down-line-or-history        # Ctrl+Alt+J (abajo)

# Word jump con hjkl
bindkey '^[^B' backward-word               # Ctrl+Alt+B (palabra atrás)
bindkey '^[^W' forward-word                # Ctrl+Alt+W (palabra adelante)

# =============================================================================
# Line Navigation
# =============================================================================

bindkey '^A' beginning-of-line             # Ctrl+A
bindkey '^E' end-of-line                   # Ctrl+E
bindkey '^[[H' beginning-of-line           # Home
bindkey '^[[F' end-of-line                 # End

# =============================================================================
# Text Editing
# =============================================================================

# Delete operations
bindkey '^?' backward-delete-char          # Backspace
bindkey '^[[3~' delete-char                # Delete
bindkey '^[[3;5~' kill-word                # Ctrl+Delete

# Alt operations
bindkey '^[^?' backward-kill-word          # Alt+Backspace
bindkey '^[[3;3~' kill-word                # Alt+Delete

# Kill line
bindkey '^K' kill-line                     # Ctrl+K
bindkey '^U' backward-kill-line            # Ctrl+U
bindkey '^W' backward-kill-word            # Ctrl+W

# Undo/Redo
bindkey '^[z' undo                         # Alt+Z
bindkey '^Y' redo                          # Ctrl+Y
bindkey '^[y' yank-pop                     # Alt+Y

# Transpose
bindkey '^T' transpose-chars               # Ctrl+T
bindkey '^[t' transpose-words              # Alt+T

# Case transformations
bindkey '^[u' up-case-word                 # Alt+U
bindkey '^[l' down-case-word               # Alt+L

# =============================================================================
# Autosuggestions
# =============================================================================

bindkey '^@' autosuggest-accept            # Ctrl+Space
bindkey '^[[F' autosuggest-accept          # End

# =============================================================================
# System Utilities
# =============================================================================

bindkey '^L' clear-screen                  # Ctrl+L

# Sudo Command Line Prepend

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}

zle -N sudo-command-line
bindkey '^[s' sudo-command-line            # Alt+S

# Clear + ls
clear-and-ls() {
    clear
    zle reset-prompt
    ls -lah --color=auto
    zle redisplay
}

zle -N clear-and-ls
bindkey '^[L' clear-and-ls                 # Alt+Shift+L

# =============================================================================
# FZF Integration
# =============================================================================
# Loaded via `fzf --zsh` in .zshrc
# Defaults: Ctrl+T (files), Ctrl+R (history), Alt+C (dirs)

# =============================================================================
# Keybinding Reference
# =============================================================================
#
# NAVIGATION:
#   Ctrl+A/E        → Beginning/End of line
#   Home/End        → Beginning/End of line
#   Ctrl+←/→        → Word jump
#   Alt+←/→         → Word jump
#   Alt+F/B         → Word jump (emacs)
#   Ctrl+Alt+H/L    → Char left/right (vim-style)
#   Ctrl+Alt+K/J    → Line up/down (vim-style)
#   Ctrl+Alt+B/W    → Word backward/forward (vim-style)
#
# HISTORY:
#   Up/Down         → History
#   Ctrl+P/N        → History
#   PageUp/Down     → History search
#   Ctrl+R          → Reverse search (FZF if enabled)
#   Ctrl+S          → Forward search
#
# EDITING:
#   Backspace       → Delete char back
#   Delete          → Delete char forward
#   Alt+Backspace   → Kill word back
#   Ctrl+Delete     → Kill word forward
#   Ctrl+K          → Kill line forward
#   Ctrl+U          → Kill line backward
#   Ctrl+W          → Kill word back
#   Alt+Z           → Undo
#   Ctrl+Y          → Redo
#   Alt+Y           → Yank-pop
#   Ctrl+T          → Transpose chars
#   Alt+T           → Transpose words
#   Alt+U/L         → Upper/lowercase word
#
# ADVANCED:
#   Ctrl+X Ctrl+E   → Edit in $EDITOR
#   Alt+.           → Last argument
#   Alt+Q           → Quote line
#   Alt+S           → Prepend sudo
#   Alt+Shift+L     → Clear + ls
#
# AUTOSUGGESTIONS:
#   Ctrl+Space      → Accept
#   End             → Accept
#   Alt+F           → Accept word
#
# SYSTEM:
#   Ctrl+L          → Clear
#   Ctrl+Z          → Suspend (UNIX standard)
#   Ctrl+T          → FZF files
#   Alt+C           → FZF dirs
#
# =============================================================================
# DISABLED (Conflicts):
# =============================================================================
# Ctrl+H    → Terminal Backspace conflict
# Ctrl+Z    → SIGTSTP reserved
# Alt+C     → FZF directory search
# =============================================================================

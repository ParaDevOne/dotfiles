# =============================================================================
# ZSH Keybindings
# =============================================================================

# =============================================================================
# Vi Mode Configuration
# =============================================================================
# Use Emacs mode (standard bash-like bindings)
# Comment out to enable Vi mode
bindkey -e

# Uncomment for Vi mode:
# bindkey -v
# export KEYTIMEOUT=1  # Reduce ESC delay in vi mode

# =============================================================================
# History Navigation
# =============================================================================
# NOTE: Ctrl+R is handled by Atuin (loaded in .zshrc)

bindkey '^[[A' up-line-or-history          # Up arrow
bindkey '^[[B' down-line-or-history        # Down arrow
bindkey '^P' up-line-or-history            # Ctrl+P (alternative)
bindkey '^N' down-line-or-history          # Ctrl+N (alternative)

# Search history incrementally
bindkey '^[[5~' history-beginning-search-backward  # Page Up
bindkey '^[[6~' history-beginning-search-forward   # Page Down

# =============================================================================
# Word Navigation
# =============================================================================

# Ctrl+Arrow word navigation
bindkey '^[[1;5C' forward-word             # Ctrl+Right
bindkey '^[[1;5D' backward-word            # Ctrl+Left

# Alt+Arrow word navigation (alternative)
bindkey '^[[1;3C' forward-word             # Alt+Right
bindkey '^[[1;3D' backward-word            # Alt+Left

# Emacs-style word navigation
bindkey '^[f' forward-word                 # Alt+F
bindkey '^[b' backward-word                # Alt+B

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
bindkey '^H' backward-kill-word            # Ctrl+Backspace
bindkey '^[[3~' delete-char                # Delete
bindkey '^[[3;5~' kill-word                # Ctrl+Delete

# Kill line operations
bindkey '^K' kill-line                     # Kill to end of line
bindkey '^U' backward-kill-line            # Kill to start of line
bindkey '^W' backward-kill-word            # Kill word backwards

# Undo/Redo
bindkey '^Z' undo                          # Ctrl+Z
bindkey '^Y' redo                          # Ctrl+Y

# Transpose
bindkey '^T' transpose-chars               # Swap characters
bindkey '^[t' transpose-words              # Swap words (Alt+T)

# Case transformations
bindkey '^[u' up-case-word                 # Uppercase word (Alt+U)
bindkey '^[l' down-case-word               # Lowercase word (Alt+L)
bindkey '^[c' capitalize-word              # Capitalize word (Alt+C)

# =============================================================================
# Advanced Editing
# =============================================================================

# Edit command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line           # Ctrl+X Ctrl+E

# Insert last argument from previous command
bindkey '^[.' insert-last-word             # Alt+.

# Quote current line
autoload -U quote-line
zle -N quote-line
bindkey '^[q' quote-line                   # Alt+Q

# =============================================================================
# Autosuggestions
# =============================================================================

bindkey '^ ' autosuggest-accept            # Ctrl+Space (accept full)
bindkey '^[[F' autosuggest-accept          # End key (accept full)
bindkey '^[f' forward-word                 # Alt+F (accept word by word)

# =============================================================================
# System Utilities
# =============================================================================

bindkey '^L' clear-screen                  # Clear screen

# ============================================================================
# Sudo Command Line Prepend
# ===========================================================================

sudo-command-line() {
  if [[ -z $BUFFER ]]; then
    BUFFER="sudo "
  elif [[ $BUFFER != sudo\ * ]]; then
    BUFFER="sudo $BUFFER"
  fi
  CURSOR=${#BUFFER}
}

zle -N sudo-command-line

bindkey '^[s' sudo-command-line           # Alt+S

# =============================================================================
# FZF Integration
# =============================================================================
# NOTE: FZF keybindings are loaded via `fzf --zsh` in .zshrc
# Default FZF bindings:
# - Ctrl+T: File search
# - Ctrl+R: History search (overridden by Atuin)
# - Alt+C:  Directory search

# =============================================================================
# Keybinding Reference
# =============================================================================
#
# NAVIGATION:
#   Ctrl+A/E        → Beginning/End of line
#   Home/End        → Beginning/End of line
#   Ctrl+←/→        → Word navigation
#   Alt+←/→         → Word navigation (alternative)
#   Alt+F/B         → Word navigation (emacs-style)
#   Up/Down         → History navigation
#   Ctrl+P/N        → History navigation (alternative)
#   PageUp/PageDown → History search
#
# EDITING:
#   Backspace       → Delete char backward
#   Delete          → Delete char forward
#   Ctrl+Backspace  → Delete word backward
#   Ctrl+Delete     → Delete word forward
#   Ctrl+K          → Kill to end of line
#   Ctrl+U          → Kill to start of line
#   Ctrl+W          → Kill word backward
#   Ctrl+Z/Y        → Undo/Redo
#   Ctrl+T          → Transpose chars
#   Alt+T           → Transpose words
#   Alt+U/L/C       → Uppercase/Lowercase/Capitalize word
#
# ADVANCED:
#   Ctrl+X Ctrl+E   → Edit command in $EDITOR
#   Alt+.           → Insert last argument
#   Alt+Q           → Quote line
#   Alt+S           → Prepend sudo
#
# AUTOSUGGESTIONS:
#   Ctrl+Space      → Accept suggestion
#   End             → Accept suggestion
#   Alt+F           → Accept word by word
#
# SYSTEM:
#   Ctrl+L          → Clear screen
#   Ctrl+R          → Atuin history search
#   Ctrl+T          → FZF file search
#   Alt+C           → FZF directory search
#
# LAYER SEPARATION:
#   Ctrl            → Shell operations
#   Alt             → Shell extensions
#   Ctrl+Shift      → Terminal emulator (Kitty)
#   Ctrl+B          → Multiplexer (Zellij)
#
# =============================================================================

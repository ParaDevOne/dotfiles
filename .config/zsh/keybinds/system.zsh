# =============================================================================
# System & Utility Keybindings
# =============================================================================

# Sudo Prefix (Alt+S)
# Changed from Esc Esc to avoid conflicts with Zellij pane renaming
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "^[s" sudo-command-line

# Clear Screen Integration (Ctrl+L)
bindkey '^L' clear-screen

# Autosuggestions Accept (Ctrl+Space or End)
# Accept full suggestion
bindkey '^ ' autosuggest-accept         # Ctrl+Space
bindkey '^[[F' autosuggest-accept       # End key

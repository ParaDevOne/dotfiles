# =============================================================================
# Znap - Plugin Manager
# =============================================================================

# Check if zsh is running
if [[ $SHELL != *zsh* ]]; then
    echo "Warning: This configuration is optimized for zsh"
fi

# =============================================================================
# Znap Installation
# =============================================================================

# Download Znap if it doesn't exist
if ! [[ -f ~/.config/zsh/plugins/zsh-snap/znap.zsh ]]; then
    if command -v git &> /dev/null; then
        echo "Installing Znap..."
        if git clone --depth 1 -- \
            https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/plugins/zsh-snap; then
            echo "✓ Znap installed"
        else
            echo "✗ Failed to install Znap" >&2
            return 1
        fi
    else
        echo "Error: git is required to install Znap" >&2
        return 1
    fi
fi

# Verificar que el source funcionó
if ! source ~/.config/zsh/plugins/zsh-snap/znap.zsh; then
    echo "Error: Failed to load Znap" >&2
    return 1
fi

# =============================================================================
# Plugins
# =============================================================================

# fzf-tab - Fuzzy tab completion
znap source Aloxaf/fzf-tab

# You-should-use - Reminds you of aliases
znap source MichaelAquilina/zsh-you-should-use

# History search multi-word - Advanced history search
znap source zdharma-continuum/history-search-multi-word

# Auto-suggestions - Provides suggestions as you type
znap source zsh-users/zsh-autosuggestions

# Completions - Extended completions for many commands
znap source zsh-users/zsh-completions

# Fast syntax highlighting - Syntax highlighting while typing
znap source zdharma-continuum/fast-syntax-highlighting

# =============================================================================
# Plugin Configuration
# =============================================================================

# Autosuggestions - Strategy and styling
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50000
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# You-should-use - Message position and behavior
export YSU_MESSAGE_POSITION="after"
export YSU_HARDCORE=0
export YSU_MODE=ALL

# =============================================================================
# Fast Syntax Highlighting Configuration
# =============================================================================

# Syntax highlighting options
typeset -A FAST_HIGHLIGHT_STYLES=(
    default 'fg=none,bold=no'
    unknown-token 'fg=red,bold=1'
    reserved-word 'fg=yellow,bold=1'
    alias 'fg=cyan,bold=1'
    builtin 'fg=cyan,bold=1'
    function 'fg=green,bold=1'
    command 'fg=green'
    path 'fg=blue'
    path-pathseparator 'fg=blue'
    globbing 'fg=magenta'
    history-expansion 'fg=magenta'
)

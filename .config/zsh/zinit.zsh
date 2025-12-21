# =============================================================================
# Zinit - Plugin Manager
# =============================================================================

# =============================================================================
# Zinit Installation
# =============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Instalar Zinit si no existe
if [[ ! -d "$ZINIT_HOME" ]]; then
    if command -v git &> /dev/null; then
        echo "Downloads Zinit..."
        if mkdir -p "$(dirname $ZINIT_HOME)" && \
           git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"; then
            echo "✓ Zinit downloaded successfully"
        else
            echo "✗ Error downloaded zinit" >&2
            return 1
        fi
    else
        echo "✗ Includes git for downloaded Zinit" >&2
        return 1
    fi
fi

# Verificar que el source funciona
if ! source "${ZINIT_HOME}/zinit.zsh"; then
    echo "✗ Error cargando Zinit" >&2
    return 1
fi

# =============================================================================
# Plugins
# =============================================================================

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Fzf-tab - Fuzzy completion for Zsh using fzf
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# Snippets
# OMZP Git Plugin - Git utilities from Oh My Zsh
zinit ice wait lucid; zinit snippet OMZP::git

# Alias Tips - Suggests aliases for commands you type
zinit ice wait'0' lucid
zinit light djui/alias-tips

# Completions - Extended completions for many commands
zinit ice wait lucid atpull='zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Auto-suggestions - Provides suggestions as you type
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Fast syntax highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# =============================================================================
# Plugin Configuration
# =============================================================================

# Autosuggestions - Strategy and styling
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# =============================================================================
# Fast Syntax Highlighting Configuration
# =============================================================================

# Syntax highlighting options
typeset -gA FAST_HIGHLIGHT_STYLES=(
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

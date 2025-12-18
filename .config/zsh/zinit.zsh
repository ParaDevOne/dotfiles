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
        echo "Instalando Zinit..."
        if mkdir -p "$(dirname $ZINIT_HOME)" && \
           git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"; then
            echo "✓ Zinit instalado"
        else
            echo "✗ Error instalando Zinit" >&2
            return 1
        fi
    else
        echo "✗ Se necesita git para instalar Zinit" >&2
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

# Powerlevel10k - Theme for Zsh
# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k


# fzf-tab - Fuzzy tab completion (debe cargar ANTES de completions)
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# You-should-use - Reminds you of aliases
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

# Auto-suggestions - Provides suggestions as you type
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Completions - Extended completions for many commands
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Fast syntax highlighting - DEBE IR ÚLTIMO
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting


# Add in snippets
zinit ice wait lucid
zinit snippet OMZP::git

zinit ice wait lucid
zinit snippet OMZP::sudo

zinit ice wait lucid
zinit snippet OMZP::command-not-found
# =============================================================================
# Plugin Configuration
# =============================================================================

# Autosuggestions - Strategy and styling
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# You-should-use - Message position and behavior
export YSU_MESSAGE_POSITION="after"
export YSU_HARDCORE=0
export YSU_MODE=ALL

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

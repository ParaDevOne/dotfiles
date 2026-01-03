# =============================================================================
# Zsh-Snap - Plugin Manager
# =============================================================================

# =============================================================================
# Zsh-Snap Installation
# =============================================================================
ZNAP_HOME="${ZDOTDIR:-${HOME}/.config/zsh}/plugins/zsh-snap"

# Instalar Zsh-Snap si no existe
if [[ ! -d "$ZNAP_HOME" ]]; then
    if command -v git &> /dev/null; then
        echo "Downloading Zsh-Snap..."
        if mkdir -p "$(dirname $ZNAP_HOME)" && \
           git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git "$ZNAP_HOME"; then
            echo "Zsh-Snap downloaded successfully"
        else
            echo "Error downloading Zsh-Snap" >&2
            return 1
        fi
    else
        echo "Git is required to download Zsh-Snap" >&2
        return 1
    fi
fi

# Verificar que el source funciona
if ! source "${ZNAP_HOME}/znap.zsh"; then
    echo "Error loading Zsh-Snap" >&2
    return 1
fi

# =============================================================================
# Plugins
# =============================================================================

# Powerlevel10k
znap source romkatv/powerlevel10k

# Fzf-tab - Fuzzy completion for Zsh using fzf
znap source Aloxaf/fzf-tab

# Completions - Extended completions for many commands
znap source zsh-users/zsh-completions

# Oh My Zsh Plugin Snippets
znap source ohmyzsh/ohmyzsh plugins/git                             # OMZP Git Plugin - Git utilities
znap source ohmyzsh/ohmyzsh plugins/extract                         # OMZP Extract Plugin - Extract various archive formats easily
znap source ohmyzsh/ohmyzsh plugins/command-not-found               # OMZP Command Not Found Plugin - Suggests installation commands for missing commands

# Alias Tips - Suggests aliases for commands you type
znap source djui/alias-tips

# Auto-suggestions - Provides suggestions as you type
znap source zsh-users/zsh-autosuggestions

# Autosuggestions - Strategy and styling
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Tealdeer (tldr) completions
znap fpath _tldr 'tealdeer-rs/tealdeer:completion/zsh_tealdeer'

# Fast syntax highlighting - DEBE SER EL ÚLTIMO
znap source zdharma-continuum/fast-syntax-highlighting

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

# Compile Zsh-Snap for faster loading
znap compile ~/.config/zsh/*.zsh

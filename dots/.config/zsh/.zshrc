# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugin Manager - Antidote
source /usr/share/zsh-antidote/antidote.zsh
antidote load "$ZDOTDIR/.zsh_plugins.txt" &>/dev/null

# Completion System
autoload -U colors && colors
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Fzf Tab Configuration
zstyle ':fzf-tab:*' fzf-flags \
    --height=50% \
    --layout=reverse \
    --border=rounded \
    --info=inline \
    --prompt='➜ ' \
    --pointer='▶' \
    --marker='✓' \
    --color=fg:#cad3f5,bg:#24273a,hl:#ed8796 \
    --color=fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796 \
    --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6 \
    --color=marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4


# Set minimum height for fzf-tab
zstyle ':fzf-tab:*' fzf-min-height 15
# Preview for files using bat if available
if command -v eza &> /dev/null; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null'
fi
# Man preview with bat if available
if command -v bat &> /dev/null; then
    zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word 2>/dev/null | bat --color=always --language=man --plain'
fi

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
# Navigation
setopt AUTOCD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt GLOB_DOTS
# Correction and Globbing
unsetopt CORRECT_ALL
setopt CORRECT
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT
setopt BRACE_CCL
# Completion
unsetopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
# Terminal
setopt PROMPT_SUBST
setopt NO_BEEP
setopt NO_HUP
setopt CHECK_JOBS
setopt NOTIFY
setopt INTERACTIVE_COMMENTS

# FZF
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --color=fg:#cad3f5,bg:#24273a,hl:#ed8796,fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796
        --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6,marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4
    "

    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --strip-cwd-prefix'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi

    eval "$(fzf --zsh)"
fi

# Zsh Autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Fast Syntax Highlighting
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

# Load external files
[[ -f "$ZDOTDIR/keybinds.zsh" ]]   && source "$ZDOTDIR/keybinds.zsh"
[[ -f "$ZDOTDIR/aliases.zsh" ]]  && source "$ZDOTDIR/aliases.zsh"
[[ -f "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"
[[ -f "$ZDOTDIR/.p10k.zsh" ]]     && source "$ZDOTDIR/.p10k.zsh"

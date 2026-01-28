# Powerlevel10k instant prompt - must be at start of file
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugin manager - Antidote
zsh_plugins="$ZDOTDIR/.zsh_plugins.zsh"
zsh_plugins_txt="$ZDOTDIR/.zsh_plugins.txt"

# Compile plugins if the source file is newer than the compiled one
if [[ ! -f "$zsh_plugins" || "$zsh_plugins_txt" -nt "$zsh_plugins" ]]; then
  source /usr/share/zsh-antidote/antidote.zsh
  antidote bundle < "$zsh_plugins_txt" > "$zsh_plugins"
  zcompile "$zsh_plugins"
fi

# Load plugins from compiled file
source "$zsh_plugins"

# Completion system
autoload -Uz compinit
if [[ -n ${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}(#qNmh-24) ]]; then
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
else
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
  ${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}.zwc(#qN) || {
    zcompile "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
  }
fi

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion performance
zstyle ':completion:*' file-patterns '*(-/):directories' '*:all-files'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,%cpu,cmd'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps auxww | awk "{print \$11}"'
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*' single-ignored show

# Fzf Tab - fuzzy tab completion
zstyle ':fzf-tab:*' fzf-flags \
    --height=50% --layout=reverse --border=rounded --info=inline \
    --prompt='➜ ' --pointer='▶' --marker='✓' \
    --color=fg:#cad3f5,bg:#24273a,hl:#ed8796 \
    --color=fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796 \
    --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6 \
    --color=marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4

zstyle ':fzf-tab:*' fzf-min-height 15
if command -v eza &> /dev/null; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null'
fi
if command -v bat &> /dev/null; then
    zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word 2>/dev/null | bat --color=always --language=man --plain'
fi

# History
HISTFILE="$XDG_CONFIG_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
# Navigation
setopt AUTOCD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt GLOB_DOTS
# Correction and globbing
unsetopt CORRECT_ALL
setopt CORRECT
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT
setopt BRACE_CCL
# Completion behavior
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

# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS="
        --height 40% --layout=reverse --border --inline-info
        --color=fg:#cad3f5,bg:#24273a,hl:#ed8796,fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796
        --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6,marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4
    "
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --strip-cwd-prefix'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    eval "$(fzf --zsh)"
fi

# Autosuggestions - zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_ASYNC_DELAY=100
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line)

# Alias tips - Show when you have an alias for a command
export ZSH_ALIAS_TIPS_TEXT='Tip: '
export ZSH_ALIAS_TIPS_EXCLUDES='_*'

# Fast syntax highlighting - Extended colors & styles
export FAST_HIGHLIGHT_USE_EXTENDED_STYLES=1
typeset -gA FAST_HIGHLIGHT_STYLES=(
    default 'fg=none,bold=no'
    unknown-token 'fg=#ED8796,bold=1'
    reserved-word 'fg=#EED49F,bold=1'
    alias 'fg=#A6DA95,bold=1'
    builtin 'fg=#A6DA95,bold=1'
    function 'fg=#A6DA95,bold=1'
    command 'fg=#A6DA95'
    path 'fg=#8BD5CA,bold=1'
    path-pathseparator 'fg=#8BD5CA'
    globbing 'fg=#F5BDE6,bold=1'
    history-expansion 'fg=#F5BDE6'
    single-hyphen-option 'fg=#8AADF4'
    double-hyphen-option 'fg=#8AADF4'
    back-quoted-argument 'fg=#EED49F'
    single-quoted-argument 'fg=#EED49F'
    double-quoted-argument 'fg=#EED49F'
    dollar-quoted-argument 'fg=#C6A0F6'
    rc-quote 'fg=#EED49F'
    dollar-double-quoted-argument 'fg=#EED49F'
    back-double-quoted-argument 'fg=#EED49F'
    redirection 'fg=#F5BDE6,bold=1'
    comment 'fg=#6E738D'
    arg0 'fg=#8AADF4'
    param-expansion 'fg=#C6A0F6'
)

# OMZ Git plugin configuration
export GIT_OPTIONAL_LOCKS=0
zstyle ':omz:plugins:git' aliases yes

# Load external config files
[[ -f "$ZDOTDIR/keybinds.zsh" ]]   && source "$ZDOTDIR/keybinds.zsh"
[[ -f "$ZDOTDIR/aliases.zsh" ]]    && source "$ZDOTDIR/aliases.zsh"
[[ -f "$ZDOTDIR/functions.zsh" ]]  && source "$ZDOTDIR/functions.zsh"
[[ -f "$ZDOTDIR/.p10k.zsh" ]]      && source "$ZDOTDIR/.p10k.zsh"

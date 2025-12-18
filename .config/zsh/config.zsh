# -----------------------------------------------------
# ZSH Configuration
# -----------------------------------------------------

# -----------------------------------------------------
# History
# =============================================================================
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# =============================================================================
# History Options
# =============================================================================
setopt BANG_HIST                 # ! works in expansion
setopt EXTENDED_HISTORY          # Saves timestamps
setopt INC_APPEND_HISTORY        # Writes immediately
setopt SHARE_HISTORY             # Shares between sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Deletes duplicates first when cleaning
setopt HIST_IGNORE_DUPS          # Doesn't save consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS      # Deletes old duplicates
setopt HIST_FIND_NO_DUPS         # Doesn't show duplicates in search
setopt HIST_IGNORE_SPACE         # Ignores if starts with space
setopt HIST_SAVE_NO_DUPS         # Doesn't write duplicates to file
setopt HIST_REDUCE_BLANKS        # Cleans extra spaces
setopt HIST_VERIFY               # Confirms before executing !command

# =============================================================================
# Completion Options
# =============================================================================
setopt MENU_COMPLETE             # Auto-selects first element
setopt LIST_PACKED               # Compact menu
setopt AUTO_LIST                 # Lists automatically on ambiguity
setopt COMPLETE_IN_WORD          # Completes from both ends
setopt ALWAYS_TO_END             # Mueve cursor al final en completado
setopt AUTO_PARAM_KEYS           # Completa claves de parámetros automáticamente

# =============================================================================
# Navigation Options
# =============================================================================
setopt AUTOCD                    # cd with directory name only
setopt AUTO_NAME_DIRS            # Creates named dirs automatically
setopt PUSHD_TO_HOME             # cd without args goes to $HOME
setopt PUSHD_IGNORE_DUPS         # No duplica directorios en stack
setopt CDABLE_VARS               # Permite cd ~/var si var es variable

# =============================================================================
# Correction and Globbing Options
# =============================================================================
unsetopt CORRECT_ALL             # Only correct first word
setopt CORRECT                   # Enables correction
setopt NO_CASE_GLOB              # Case insensitive globbing
setopt EXTENDED_GLOB             # Advanced globbing
setopt NUMERIC_GLOB_SORT         # Sorts files numerically
setopt GLOB_DOTS                 # Includes dotfiles in globbing
setopt NO_NOMATCH                # No error if glob finds nothing
setopt BRACE_CCL                 # Advanced brace expansion

# =============================================================================
# Terminal Options
# =============================================================================
setopt PROMPT_SUBST              # Allows expansion in prompt
setopt NO_BEEP                   # No terminal sound
setopt NO_HUP                    # Doesn't kill jobs on exit
setopt CHECK_JOBS                # Checks jobs on exit
setopt NO_GLOBAL_RCS             # Doesn't load global rc files
setopt NOTIFY                    # Notifies when job finishes

# =============================================================================
# Environment Variables
# =============================================================================
# Color support & locale
export TERM="xterm-256color"
export COLORTERM="truecolor"
export LANG=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8

# Less with colors
export LESS='-R'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# FZF default commands
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exlude .git"

# =============================================================================
# Completions
# =============================================================================
if [[ ! -f ~/.config/zsh/.zcompdump || \
      ~/.config/zsh/.zcompdump -ot ~/.zshrc ]]; then
    autoload -Uz compinit
    compinit -d ~/.config/zsh/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.config/zsh/.zcompdump
fi

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' list-separator '#'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' menu no                              # Disable default tab completion in favor of fzf-tab
zstyle ':completion:*:history-search-multi-word:*' history-search-multi-word true
zstyle ':completion:*:history-search-multi-word:*' max-entries 50
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/.zcompcache
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*:descriptions' format '[%d]'
# fzf-tab styling
zstyle ':fzf-tab:*' fzf-flags --preview-window=right:50%    # FZF-Tab color scheme
zstyle ':fzf-tab:*' fzf-colors 'fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'

# =============================================================================
# FZF Configuration
# =============================================================================
if command -v fzf &> /dev/null; then
    # Generar archivo FZF solo si no existe
    if [[ ! -f ~/.config/zsh/fzf.zsh ]]; then
        fzf --zsh > ~/.config/zsh/fzf.zsh
    fi
    source ~/.config/zsh/fzf.zsh

    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
        --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
        --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
        --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
    "

    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

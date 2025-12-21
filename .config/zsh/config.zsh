# =============================================================================
# ZSH Configuration
# =============================================================================

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/lib/ccache/bin:$PATH"

# =============================================================================
# History
# =============================================================================
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTDUP=erase

# =============================================================================
# History Options
# =============================================================================
setopt BANG_HIST                 # ! works in expansion
setopt EXTENDED_HISTORY          # Saves timestamps
setopt INC_APPEND_HISTORY        # Writes immediately
setopt SHARE_HISTORY             # Shares between sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Deletes duplicates first when cleaning
setopt HIST_FIND_NO_DUPS         # Doesn't show duplicates in search
setopt HIST_IGNORE_SPACE         # Ignores if starts with space
setopt HIST_REDUCE_BLANKS        # Cleans extra spaces
setopt HIST_VERIFY               # Confirms before executing !command

# =============================================================================
# Completion Options
# =============================================================================
setopt MENU_COMPLETE             # Auto-selects first element
setopt LIST_PACKED               # Compact menu
setopt AUTO_LIST                 # Lists automatically on ambiguity
setopt COMPLETE_IN_WORD          # Completes from both ends
setopt ALWAYS_TO_END             # Moves cursor to end on completion
setopt AUTO_PARAM_KEYS           # Auto-completes parameter keys

# =============================================================================
# Navigation Options
# =============================================================================
setopt AUTOCD                    # cd with directory name only
setopt AUTO_NAME_DIRS            # Creates named dirs automatically
setopt PUSHD_TO_HOME             # cd without args goes to $HOME
setopt PUSHD_IGNORE_DUPS         # No duplicate directories in stack
setopt CDABLE_VARS               # Allows cd ~/var if var is variable

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
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Less with colors
export LESS='-R --mouse --incsearch'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;32m'

# Editor configuration
export EDITOR=nano
export VISUAL=code

# =============================================================================
# Completions System
# =============================================================================

# Load compinit with smart caching (only regenerate if .zshrc changed)
if [[ ! -f ~/.config/zsh/.zcompdump || \
      ~/.config/zsh/.zcompdump -ot ~/.zshrc ]]; then
    autoload -Uz compinit
    compinit -d ~/.config/zsh/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.config/zsh/.zcompdump
fi

# =============================================================================
# Completion Styling
# =============================================================================

# Basic completion behavior
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' file-sort modification

# Completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/.zcompcache

# Completion UI
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' list-separator '#'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Kill command completion
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Manual pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true

# Directory navigation
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# Functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# History search
zstyle ':completion:*:history-search-multi-word:*' history-search-multi-word true
zstyle ':completion:*:history-search-multi-word:*' max-entries 50

# =============================================================================
# FZF-Tab Styling, Preview and Configuration
# =============================================================================

# FZF-Tab preview window
zstyle ':fzf-tab:*' fzf-flags --preview-window=right:50% --height=80%

# FZF-Tab color scheme (Dracula)
zstyle ':fzf-tab:*' fzf-colors 'fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# FZF-Tab command
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# FZF-Tab group switching
zstyle ':fzf-tab:*' switch-group ',' '.'

# FZF-Tab continuous trigger
zstyle ':fzf-tab:*' continuous-trigger '/'

# FZF-Tab directory previews with eza
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'

# FZF-Tab file previews with bat
zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [[ -f $realpath ]]; then bat --color=always --style=numbers --line-range=:500 $realpath 2>/dev/null; elif [[ -d $realpath ]]; then eza -1 --color=always --icons=always $realpath; fi'

# FZF-Tab git previews
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $word'

# FZF-Tab process previews
zstyle ':fzf-tab:complete:kill:*' fzf-preview 'ps -f -p $word'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# FZF-Tab environment variable previews
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# FZF-Tab command previews
zstyle ':fzf-tab:complete:(-command-|command):*' fzf-preview 'if [[ -n "$(command -v $word)" ]]; then (command -v $word; which $word; whence -v $word) 2>/dev/null; fi'

# FZF-Tab man page previews
zstyle ':fzf-tab:complete:(man|info):*' fzf-preview 'man $word 2>/dev/null | bat --plain --language=man'

# FZF-Tab package manager previews (pacman/yay)
zstyle ':fzf-tab:complete:pacman:*' fzf-preview 'pacman -Si $word 2>/dev/null || pacman -Qi $word 2>/dev/null'
zstyle ':fzf-tab:complete:yay:*' fzf-preview 'yay -Si $word 2>/dev/null || yay -Qi $word 2>/dev/null'

# FZF Configuration
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
        --color=fg:#cad3f5,bg:#24273a,hl:#ed8796
        --color=fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796
        --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6
        --color=marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4
    "

    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

# =============================================================================
# Development Tools
# =============================================================================

# Rust/Cargo configuration
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

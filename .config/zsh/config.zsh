# ZSH Configuration

# History Settings
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# History Options
setopt BANG_HIST                 # ! works in expansion
setopt EXTENDED_HISTORY          # Saves timestamps
setopt HIST_VERIFY               # Confirms before executing !command
setopt SHARE_HISTORY             # Shares history across sessions
# Cleaning Options
setopt HIST_EXPIRE_DUPS_FIRST    # Expires duplicates first
setopt HIST_IGNORE_SPACE         # Ignores if starts with space
setopt HIST_IGNORE_ALL_DUPS      # Removes all duplicates in history
setopt HIST_REDUCE_BLANKS        # Cleans extra spaces
setopt HIST_FIND_NO_DUPS         # Doesn't show duplicates in search
# Navigation Options
setopt AUTOCD                    # cd with directory name only
setopt AUTO_PUSHD                # pushd on cd
setopt PUSHD_IGNORE_DUPS         # No duplicate directories in stack
setopt PUSHD_SILENT              # No output on pushd/popd
# Correction and Globbing Options
unsetopt CORRECT_ALL             # Only correct first word
setopt CORRECT                   # Enables correction
setopt NO_CASE_GLOB              # Case insensitive globbing
setopt EXTENDED_GLOB             # Advanced globbing
setopt NUMERIC_GLOB_SORT         # Sorts files numerically
setopt NO_NOMATCH                # No error if glob finds nothing
setopt BRACE_CCL                 # Advanced brace expansion
# Completion Options
unsetopt MENU_COMPLETE           # Auto-selects first element
setopt AUTO_MENU                 # Lists automatically on ambiguity
setopt COMPLETE_IN_WORD          # Completes from both ends
# Terminal Options
setopt PROMPT_SUBST              # Allows expansion in prompt
setopt NO_BEEP                   # No terminal sound
setopt NO_HUP                    # Doesn't kill jobs on exit
setopt CHECK_JOBS                # Checks jobs on exit
setopt NOTIFY                    # Notifies when job finishes

# Zsh Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/.zcompcache
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# FZF-Tab styling
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' fzf-flags '--preview-window=right:50% --height=80% --header=[Use , / . to switch groups | Ctrl-Space to select multiple]'
# Colors (Catppuccin Macchiato)
zstyle ':fzf-tab:*' fzf-colors 'fg:#cad3f5,bg:#24273a,hl:#ed8796,fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796,info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6,marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4'
# Previews
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview 'file "$realpath"; whence -a "$word"'
zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word | bat --color=always --language=man --plain'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-variant-):*' fzf-preview 'echo ${(P)word}'

# FZF Configuration
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --color=fg:#cad3f5,bg:#24273a,hl:#ed8796,fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796
        --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6,marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4
    "
    # Use fd for listing files if available
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --strip-cwd-prefix'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    # Generate fzf.zsh if it doesn't exist
    [[ ! -f ~/.config/zsh/fzf.zsh ]] && fzf --zsh > ~/.config/zsh/fzf.zsh
    source ~/.config/zsh/fzf.zsh

fi

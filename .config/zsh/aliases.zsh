# =============================================================================
# ALIASES
# =============================================================================

# =============================================================================
# Navigation & Listing
# =============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Eza (modern ls)
alias ls='eza -a --icons=always --group-directories-first'
alias ll='eza -al --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias lt='eza -a --tree --level=2 --icons=always --group-directories-first'
alias l='eza -1 --icons=always --group-directories-first'

# =============================================================================
# System Utilities
# =============================================================================
alias cl='clear'
alias c='clear'
alias q='exit'
alias ff='fastfetch'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'

# Sudo
alias root='sudo su'
alias please='sudo'
alias fucking='sudo'

# =============================================================================
# File Operations (with safety)
# =============================================================================
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Trash (safer than rm)
if command -v trash &> /dev/null; then
    alias del='trash'
    alias rmf='trash'
fi

# =============================================================================
# Editor Shortcuts
# =============================================================================
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'
alias nano='$EDITOR'
alias nn='$EDITOR'
alias e='$EDITOR'

# Quick config edits
alias zshconfig='$EDITOR ~/.zshrc'
alias aliasconfig='$EDITOR ~/.config/zsh/aliases.zsh'

# =============================================================================
# Development
# =============================================================================

# VSCode
alias code='code .'
alias code_extensions='code --list-extensions'
alias code_disable_extension='code --disable-extensions'

# Diff-so-fancy integration
if command -v diff-so-fancy &> /dev/null; then
    alias gd='git diff --color | diff-so-fancy | less --tabs=4 -RFX'
    alias gds='git diff --staged --color | diff-so-fancy | less --tabs=4 -RFX'
fi

# =============================================================================
# Search & Find
# =============================================================================

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Find shortcuts
alias fd='fd --hidden --follow'
alias fdf='fd --type f --hidden --follow'
alias fdd='fd --type d --hidden --follow'

# =============================================================================
# Quick Utilities
# =============================================================================

# Cat with syntax highlighting
if command -v bat &> /dev/null; then
    alias cat='bat --style=plain'
    alias ccat='bat --style=full'
    alias catn='/bin/cat'  # Original cat
fi

# Quick directory access
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dev='cd ~/Development'
alias dots='cd ~/.config'

# =============================================================================
# Fun Aliases
# =============================================================================
alias wtf='dmesg | tail -n 50'
alias wtfg='dmesg | grep -i'
alias pls='sudo'
alias fuck='sudo $(fc -ln -1)'

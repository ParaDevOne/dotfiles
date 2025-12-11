# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias cl='clear'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'
alias nn='$EDITOR'
alias code='code .'
alias cd='zi'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias root='sudo su'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Security
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Diff-so-fancy Git integration
if command -v diff-so-fancy &> /dev/null; then
    alias gd='git diff --color | diff-so-fancy | less --tabs=4 -RFX'
    alias gds='git diff --staged --color | diff-so-fancy | less --tabs=4 -RFX'
fi

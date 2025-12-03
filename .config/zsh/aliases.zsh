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
alias cd='z'
alias cd ..='z ..'

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gfo="git fetch origin"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias upgrade='yay -Syu'
alias update-systemd-boot='bootctl update'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
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

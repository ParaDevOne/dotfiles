# Navigation & Listing (eza - modern ls replacement)
alias ls='eza -a --icons=always --group-directories-first'
alias ll='eza -al --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias lt='eza -a --tree --level=2 --icons=always --group-directories-first'
alias l='eza -1 --icons=always --group-directories-first'
alias lnew='eza -al --sort=modified --icons=always'
alias ldir='eza -aD --icons=always'
alias tree='eza --tree --icons=always --group-directories-first'
alias treea='eza -al --tree --icons --git-ignore'
alias lsd='eza -d */ --icons=always'

# ZSH Configuration
alias zshconf='cd ~/.config/zsh && ls'
alias reload='source $ZDOTDIR/.zshrc && echo "✓ ZSH config reloaded"'
alias zshconfig='$EDITOR $ZDOTDIR/.zshrc'
alias aliasconfig='$EDITOR $ZDOTDIR/aliases.zsh'
alias zshplugins='$EDITOR $ZDOTDIR/.zsh_plugins.txt'
alias v='$EDITOR'

# System & File Operations
alias cl='clear'
alias c='clear'
alias q='exit'
alias ff='fastfetch'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias root='sudo su'

# Safe file operations (with confirmation)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Search & Find
alias grep='grep --color=auto'
alias fd='fd --hidden --follow'
alias fdf='fd --type f --hidden --follow'
alias fdd='fd --type d --hidden --follow'

# Viewing (bat - modern cat)
if command -v bat &> /dev/null; then
    alias bat='bat --style=plain'
    alias bcat='bat --style=full'
fi

# Quick Directory Access
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dev='cd ~/Dev'
alias dots='cd ~/dotfiles'

# Fun & Utilities
alias wtf='dmesg | tail -n 50'
alias wtfg='dmesg | grep -i'
alias pls='sudo'
alias fuck='sudo $(fc -ln -1)'
alias lg='lazygit'

# FZF Integration
alias fv='v $(fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")'
alias fkill='ps -ef | fzf --header="Select process to kill" | awk "{print \$2}" | xargs -r kill -15'
alias fh='history | fzf +s --tac | sed "s/ *[0-9]* *//" | wl-copy'

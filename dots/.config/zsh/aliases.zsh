# Navigation & Listing

# Eza (modern ls)
alias ls='eza -a --icons=always --group-directories-first'
alias ll='eza -al --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias lt='eza -a --tree --level=2 --icons=always --group-directories-first'
alias l='eza -1 --icons=always --group-directories-first'
alias lnew='eza -al --sort=modified --icons=always'
alias ldir='eza -aD --icons=always'
alias tree='eza --tree --icons=always --group-directories-first'
alias treea='eza -al --tree --icons --git-ignore'  # tree all + git

# List only directories
alias lsd='eza -d */ --icons=always'

# Shortcut for your modular config folder
alias zshconf='cd ~/.config/zsh && ls'

# Fast way to reload your zsh config after changes
alias reload='source $ZDOTDIR/.zshrc && echo "ZSH Config Reloaded!"'

# System Utilities
alias cl='clear'
alias c='clear'
alias q='exit'
alias ff='fastfetch'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'

# Sudo
alias root='sudo su'

# File Operations (with safety)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Quick config edits
alias zshconfig='$EDITOR $ZDOTDIR/.zshrc'
alias aliasconfig='$EDITOR $ZDOTDIR/aliases.zsh'
alias zshplugins='$EDITOR $ZDOTDIR/.zsh_plugins.txt'

alias v='$EDITOR'

# Search & Find

# Grep with color
alias grep='grep --color=auto'

# Find shortcuts
alias fd='fd --hidden --follow'
alias fdf='fd --type f --hidden --follow'
alias fdd='fd --type d --hidden --follow'

# Quick Utilities

# Cat with syntax highlighting
if command -v bat &> /dev/null; then
    alias bat='bat --style=plain'
    alias bcat='bat --style=full'
fi

# Quick directory access
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dev='cd ~/Dev'
alias dots='cd ~/dotfiles'

# Fun Aliases
alias wtf='dmesg | tail -n 50'
alias wtfg='dmesg | grep -i'
alias pls='sudo'
alias fuck='sudo $(fc -ln -1)'


# Search files and open with your editor (v)
alias fv='v $(fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")'

# Search through processes and kill one
alias fkill='ps -ef | fzf --header="Select process to kill (Ctrl-C to cancel)" | awk "{print \$2}" | xargs -r kill -15'

# Search through your Zsh history (if you want to bypass Atuin for a second)
alias fh='history | fzf +s --tac | sed "s/ *[0-9]* *//" | wl-copy'

alias lg='lazygit'

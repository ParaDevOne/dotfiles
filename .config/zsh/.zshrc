#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|


# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors and load color
autoload -U colors && colors
# Command completion system
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# External Tools Initialization

# FZF (fuzzy finder)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)" 2>/dev/null
fi

# Modular Configuration

source ~/.config/zsh/config.zsh               # 1. Config

autoload -Uz compinit
compinit -d ~/.config/zsh/.zcompdump          # 2. Compinit with cache

source ~/.config/zsh/plugin.zsh               # 3. Plugins
source ~/.config/zsh/aliases.zsh              # 4. Aliases
source ~/.config/zsh/functions.zsh            # 5. Functions
source ~/.config/zsh/keybinds.zsh             # 6. keybinds

[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

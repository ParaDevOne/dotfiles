# -----------------------------------------------------
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#
# -----------------------------------------------------

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Modular Configuration
# =============================================================================

# 1. Config
source ~/.config/zsh/config.zsh

# 2. Plugins
source ~/.config/zsh/zinit.zsh

# 3. Aliases
source ~/.config/zsh/aliases.zsh

# 4. Keybindings
source ~/.config/zsh/keybinds.zsh

# =============================================================================
# External Tools Initialization
# =============================================================================

# FZF (fuzzy finder)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)" 2>/dev/null
fi

# Zoxide (navigate directories faster)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"  2>/dev/null
fi

# Atuin (enhanced shell history)
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)" 2>/dev/null
fi

# =============================================================================
# Powerlevel10k Configuration
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# Custom Functions
# =============================================================================

# Functions customizes
source ~/.config/zsh/functions.zsh

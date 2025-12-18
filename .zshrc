# -----------------------------------------------------
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#
# Performance: ~62ms startup (482 líneas modulares)
# Last benchmark: 2025-12-03
# -----------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Modular Configuration
# =============================================================================
source ~/.config/zsh/init.zsh

# =============================================================================
# External Tools Initialization
# =============================================================================

# FZF (fuzzy finder)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# Zoxide (navigate directories faster)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Atuin (enhanced shell history)
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

# =============================================================================
# Powerlevel10k Configuration
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

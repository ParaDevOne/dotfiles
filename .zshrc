# -----------------------------------------------------
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#
# Performance: ~150ms startup (529 líneas modulares)
# Last benchmark: 2025-11-29
# -----------------------------------------------------
# Load modular configuration
# -----------------------------------------------------

# 1. Init (PATH y críticos - PRIMERO)
source ~/.config/zsh/init.zsh

# 2. Config (opciones generales)
source ~/.config/zsh/config.zsh

# 3. Plugins
source ~/.config/zsh/znap.zsh

# 4. Aliases
source ~/.config/zsh/aliases.zsh

# 5. Keybindings
source ~/.config/zsh/keybindings.zsh

# -----------------------------------------------------
# External tools
# -----------------------------------------------------

eval "$(starship init zsh)"

# =============================================================================
# Keybindings Configuration - Modular Structure
# =============================================================================
# This file sources keybinding modules organized by functionality.
# Modules are sourced in order to maintain compatibility and performance.
#
# Module Load Order (Critical for ZSH):
#   1. history.zsh    - History navigation and search
#   2. navigation.zsh - Word-level navigation
#   3. editing.zsh    - Line editing commands
#   4. system.zsh     - System utilities and special functions
#
# Performance Impact: ~150ms shell startup time (cached after first load)
# =============================================================================

# Source keybinding modules from keybinds/ subdirectory
# Use absolute path via $HOME for compatibility across different load contexts
KEYBINDS_DIR="$HOME/.config/zsh/keybinds"

source "$KEYBINDS_DIR/history.zsh"    || echo "Warning: history.zsh not found at $KEYBINDS_DIR"
source "$KEYBINDS_DIR/navigation.zsh" || echo "Warning: navigation.zsh not found at $KEYBINDS_DIR"
source "$KEYBINDS_DIR/editing.zsh"    || echo "Warning: editing.zsh not found at $KEYBINDS_DIR"
source "$KEYBINDS_DIR/system.zsh"     || echo "Warning: system.zsh not found at $KEYBINDS_DIR"

# Verification: Uncomment below to debug keybinding loading
# bindkey  # List all active keybindings

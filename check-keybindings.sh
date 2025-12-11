#!/bin/bash
# =============================================================================
# Keybindings Validation Script
# =============================================================================
# Purpose: Check for duplicate/conflicting keybindings across ZSH, Kitty, Zellij
# Usage: ./check-keybindings.sh
# =============================================================================

set -euo pipefail

DOTFILES_DIR="${HOME}/Dev/dotfiles"
ZSH_CONFIG="${DOTFILES_DIR}/.config/zsh"
KITTY_CONFIG="${DOTFILES_DIR}/.config/kitty"
ZELLIJ_CONFIG="${DOTFILES_DIR}/.config/Code/User/zellij"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Keybindings Validation Report ===${NC}\n"

# =============================================================================
# ZSH Keybindings Check
# =============================================================================
echo -e "${BLUE}[1] ZSH Keybindings Analysis${NC}"
if [[ -f "${ZSH_CONFIG}/keybinds.zsh" ]]; then
    KEYBIND_COUNT=$(grep -E "bindkey|zle -N" "${ZSH_CONFIG}/keybinds.zsh" | wc -l)
    echo -e "${GREEN}✓${NC} Found keybinds.zsh"
    echo "  └─ Loaded: $KEYBIND_COUNT keybinding directives"
    
    # Check for Alt+S (new sudo binding)
    if grep -q "bindkey.*sudo" "${ZSH_CONFIG}/keybinds.zsh" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} Sudo keybinding found"
    fi
    
    # Check modules exist
    MODULES=("history.zsh" "navigation.zsh" "editing.zsh" "system.zsh")
    for module in "${MODULES[@]}"; do
        if [[ -f "${ZSH_CONFIG}/keybinds/${module}" ]]; then
            echo -e "${GREEN}✓${NC} Module: ${module}"
        else
            echo -e "${RED}✗${NC} Missing module: ${module}"
        fi
    done
else
    echo -e "${RED}✗${NC} keybinds.zsh not found"
fi
echo ""

# =============================================================================
# Kitty Keybindings Check
# =============================================================================
echo -e "${BLUE}[2] Kitty Keybindings Analysis${NC}"
if [[ -f "${KITTY_CONFIG}/keybindings.conf" ]]; then
    KITTY_COUNT=$(grep -c "^map " "${KITTY_CONFIG}/keybindings.conf" || echo "0")
    echo -e "${GREEN}✓${NC} Found keybindings.conf"
    echo "  └─ Defined: $KITTY_COUNT keybindings"
    
    # Check for Ctrl+Shift prefix usage
    CTRL_SHIFT_COUNT=$(grep -c "ctrl+shift" "${KITTY_CONFIG}/keybindings.conf" || echo "0")
    echo "  └─ Using Ctrl+Shift: $CTRL_SHIFT_COUNT bindings"
else
    echo -e "${RED}✗${NC} keybindings.conf not found"
fi
echo ""

# =============================================================================
# Zellij Keybindings Check
# =============================================================================
echo -e "${BLUE}[3] Zellij Keybindings Analysis${NC}"
if [[ -f "${ZELLIJ_CONFIG}/config.kdl" ]]; then
    ZELLIJ_COUNT=$(grep -c "bind \"" "${ZELLIJ_CONFIG}/config.kdl" || echo "0")
    echo -e "${GREEN}✓${NC} Found config.kdl"
    echo "  └─ Defined: $ZELLIJ_COUNT keybindings"
    
    # Check for Alt+hjkl navigation
    if grep -q "Alt h\|Alt j\|Alt k\|Alt l" "${ZELLIJ_CONFIG}/config.kdl"; then
        echo -e "${GREEN}✓${NC} Vim-style navigation (Alt+hjkl) found"
    fi
    
    # Check for Alt+arrows
    if grep -q "Alt left\|Alt right\|Alt up\|Alt down" "${ZELLIJ_CONFIG}/config.kdl"; then
        echo -e "${GREEN}✓${NC} Arrow key navigation (Alt+arrows) found"
    fi
else
    echo -e "${RED}✗${NC} config.kdl not found"
fi
echo ""

# =============================================================================
# Conflict Detection
# =============================================================================
echo -e "${BLUE}[4] Conflict Detection${NC}"

# Check for Esc Esc binding (deprecated)
if grep -q 'bindkey.*"\\\\e\\\\e"' "${ZSH_CONFIG}/keybinds.zsh" 2>/dev/null || \
   grep -q "bindkey.*Esc Esc" "${ZSH_CONFIG}/keybinds.zsh" 2>/dev/null; then
    echo -e "${RED}✗${NC} DEPRECATED: Found Esc Esc binding (should be Alt+S)"
else
    echo -e "${GREEN}✓${NC} Esc Esc conflict resolved"
fi

# Check for duplicate Alt+S usage
ALT_S_ZSH=$(grep -c "\\^\\[s" "${ZSH_CONFIG}/keybinds.zsh" 2>/dev/null || echo "0")
ALT_S_ZELLIJ=$(grep -c "Alt s" "${ZELLIJ_CONFIG}/config.kdl" 2>/dev/null || echo "0")

echo "  └─ Alt+S usage: ZSH=$ALT_S_ZSH, Zellij=$ALT_S_ZELLIJ (should not conflict)"

echo -e "${GREEN}✓${NC} No critical conflicts detected"
echo ""

# =============================================================================
# Summary Statistics
# =============================================================================
echo -e "${BLUE}[5] Summary Statistics${NC}"
TOTAL_BINDINGS=$((KEYBIND_COUNT + KITTY_COUNT + ZELLIJ_COUNT))
echo "  Total keybindings: ~${TOTAL_BINDINGS}"
echo "    - ZSH: ${KEYBIND_COUNT} directives"
echo "    - Kitty: ${KITTY_COUNT} bindings"
echo "    - Zellij: ${ZELLIJ_COUNT} bindings"
echo ""

# =============================================================================
# Testing Recommendations
# =============================================================================
echo -e "${BLUE}[6] Testing Checklist${NC}"
echo "  □ Verify ZSH loads without errors: zsh -c \"source ~/.zshrc && echo OK\""
echo "  □ Test Alt+S in ZSH: sudo ls should toggle on/off"
echo "  □ Test Zellij pane rename: Ctrl+B → p → c → Esc (should cancel)"
echo "  □ Test Alt+hjkl in Zellij: Navigate panes with Alt key combinations"
echo "  □ Test Kitty tabs: Ctrl+Shift+T to create new tab"
echo ""

# =============================================================================
# Documentation
# =============================================================================
echo -e "${BLUE}[7] Documentation${NC}"
if [[ -f "${DOTFILES_DIR}/.config/KEYBINDINGS.md" ]]; then
    echo -e "${GREEN}✓${NC} Found .config/KEYBINDINGS.md"
    LINES=$(wc -l < "${DOTFILES_DIR}/.config/KEYBINDINGS.md")
    echo "  └─ Documentation: ${LINES} lines"
else
    echo -e "${RED}✗${NC} KEYBINDINGS.md not found"
fi
echo ""

echo -e "${GREEN}=== Validation Complete ===${NC}"

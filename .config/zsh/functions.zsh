# Override the 'zi' function to avoid conflicts with any existing aliases or functions.

unalias zi 2>/dev/null

unset -f zi 2>/dev/null

function zi() {
    __zoxide_zi "$@"
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

h() {
    eval $(history | fzf --tac | sed 's/^ *[0-9]* *//')
}

doc() {
    local cmd="$1"
    if [ -z "$cmd" ]; then
        echo "Usage: doc <command>"
        return 1
    fi

    # Try TLDR first
    if command -v tldr &> /dev/null; then
        echo "╔════════════════════════════════════════╗"
        echo "║ TLDR: Practical Examples               ║"
        echo "╚════════════════════════════════════════╝"
        tldr "$cmd" 2>/dev/null

        if [ $? -eq 0 ]; then
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            # Zsh syntax for read. If using Bash, use: read -p "View full manual? (y/N): " reply
            read "reply?View full manual? (y/N): "

            if [[ "$reply" =~ ^[Yy]$ ]]; then
                echo ""
                echo "╔════════════════════════════════════════╗"
                echo "║ Full MAN PAGE                          ║"
                echo "╚════════════════════════════════════════╝"
                man "$cmd"
            fi
        else
            echo " No TLDR found, showing MAN page..."
            man "$cmd"
        fi
    else
        # Installation removed. Fallback directly to man.
        echo " TLDR not installed. Showing MAN page..."
        man "$cmd"
    fi
}

fman() {
    man -k . | fzf --preview 'man {1}' --preview-window=right:70% | awk '{print $1}' | xargs -r man
}

cheat() {
    local cmd="$1"
    [ -z "$cmd" ] && { echo "Use: cheat <command>"; return 1; }
    command -v tldr &> /dev/null && tldr "$cmd" 2>/dev/null && return
    curl -sf "cheat.sh/$cmd?style=native&T" || man "$cmd"
}

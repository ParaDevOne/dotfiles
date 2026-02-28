# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick backup of a file
bak() {
    cp "$1" "$1.bak"
}

# Navigate up multiple directory levels
# Usage: up 3 (go up 3 levels)
up() {
    local d=""
    local limit=${1:-1}
    for ((i=1 ; i <= limit ; i++)); do
        d="${d}../"
    done
    cd "$d"
}

# Navigate down using fzf (requires fd and fzf)
down() {
    if ! command -v fd &> /dev/null || ! command -v fzf &> /dev/null; then
        echo "down: requires 'fd' and 'fzf'" >&2
        return 1
    fi

    local depth=${1:-1}
    local target=$(fd --type d --max-depth "$depth" . | fzf)
    [[ -n "$target" ]] && cd "$target"
}

# -----------------------------------------------------
# Source file of scripts and functions for general use
# -----------------------------------------------------

# Add functions here of general use or scripts you frequently use.



# -----------------------------------------------------
# General Purpose Functions
# -----------------------------------------------------

# Enhanced cd command: change directory and list contents with eza
cd() {
    z "$@" && eza -a --icons=always
}

# Extract archives with automatic format detection
extract() {
    if [[ ! -f "$1" ]]; then
        echo "Error: File not found - $1"
        return 1
    fi

    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.tar.xz) tar xJf "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.rar) unrar x "$1" ;;
        *) echo "Unsupported format: $1" && return 1 ;;
    esac
}

# Create directory and change into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Search in files recursively (respects .gitignore)
search() {
    if [[ -z "$1" ]]; then
        echo "Usage: search <pattern> [path]"
        return 1
    fi
    grep -r --include="*.{js,ts,jsx,tsx,py,sh,zsh,json,md}" "$1" "${2:-.}"
}

# Quick file finder
ff() {
    find . -type f -name "*$1*" 2>/dev/null
}

# Quick directory finder
fd() {
    find . -type d -name "*$1*" 2>/dev/null
}

# Show file size in human-readable format
fs() {
    if [[ -z "$1" ]]; then
        echo "Usage: fs <file|directory>"
        return 1
    fi
    du -sh "$1"
}

# Show size of all items in current directory
sizes() {
    eza -lah --icons=always | grep -v "^total"
}

# Quick git status shortcut with prettier output
gst() {
    git status --short
}

# Backup a file with timestamp
bak() {
    if [[ ! -f "$1" ]]; then
        echo "Error: File not found - $1"
        return 1
    fi
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: $1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Open file or directory in editor (respects $EDITOR)
edit() {
    if [[ -z "$1" ]]; then
        echo "Usage: edit <file|directory>"
        return 1
    fi
    ${EDITOR:-nano} "$1"
}

# Show process info by name
pinfo() {
    if [[ -z "$1" ]]; then
        echo "Usage: pinfo <process_name>"
        return 1
    fi
    ps aux | grep "$1" | grep -v grep
}

# Kill process by name
pkill_name() {
    if [[ -z "$1" ]]; then
        echo "Usage: pkill_name <process_name>"
        return 1
    fi
    pkill -f "$1"
    echo "Killed processes matching: $1"
}

# Performance: Time shell startup
profile_shell() {
    time zsh -i -c exit
}

# Reload shell configuration without restarting
reload() {
    exec zsh
}

# Show available functions
flist() {
    declare -F | awk '{print $3}' | sort
}

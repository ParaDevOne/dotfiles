# =============================================================================
# Zellij Autostart Configuration
# =============================================================================
# Launches Zellij automatically on shell startup if not already inside a session

# Check if we're NOT already inside Zellij and NOT in a non-interactive shell
if [[ -z "$ZELLIJ" ]] && [[ -o interactive ]]; then
    # Check if zellij is installed
    if command -v zellij &>/dev/null; then
        # Launch Zellij and attach to default session, or create one
        exec zellij attach -c default
    fi
fi

# =============================================================================
# Zellij Helper Functions
# =============================================================================

# Function to create a new named Zellij session
zj-new() {
    if [[ -z "$1" ]]; then
        echo "Usage: zj-new <session-name>"
        return 1
    fi
    zellij attach -c "$1"
}

# Function to list all Zellij sessions
zj-list() {
    zellij list-sessions
}

# Function to kill a Zellij session
zj-kill() {
    if [[ -z "$1" ]]; then
        echo "Usage: zj-kill <session-name>"
        return 1
    fi
    zellij delete-session "$1"
}

# Function to detach from current session
zj-detach() {
    zellij action detach
}

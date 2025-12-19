# =============================================================================
# ZSH Profile Configuration
# Loaded once at login, before .zshrc
# =============================================================================

# =============================================================================
# Locale Configuration
# =============================================================================
export LANG=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8
export LC_CTYPE=es_ES.UTF-8

# =============================================================================
# Font Rendering
# =============================================================================
# Disable stem darkening for better font rendering
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

# =============================================================================
# XDG Base Directory Specification
# =============================================================================
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# =============================================================================
# Wayland Configuration
# =============================================================================
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    # Core Wayland flags
    export WAYLAND=1
    export XDG_SESSION_TYPE=wayland

    # Qt applications
    export QT_QPA_PLATFORM='wayland;xcb'
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt6ct

    # GTK applications
    export GDK_BACKEND='wayland,x11'
    export GDK_DPI_SCALE=1

    # Mozilla applications (Firefox, Thunderbird)
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_DBUS_REMOTE=1
    export MOZ_WEBRENDER=1

    # Electron applications
    export ELECTRON_OZONE_PLATFORM_HINT=wayland

    # Java applications
    export _JAVA_AWT_WM_NONREPARENTING=1
    export AWT_TOOLKIT=MToolkit

    # SDL (games/media)
    export SDL_VIDEODRIVER=wayland

    # Clutter/EFL (legacy toolkits)
    export CLUTTER_BACKEND=wayland
    export ECORE_EVAS_ENGINE=wayland_egl
    export ELM_ENGINE=wayland_egl

    # Other tools
    export BEMENU_BACKEND=wayland
    export WINIT_UNIX_BACKEND=wayland
fi

# =============================================================================
# Hardware Acceleration
# =============================================================================
# Enable VA-API for video acceleration
export LIBVA_DRIVER_NAME=radeonsi  # Change to 'nvidia' or 'intel' if needed
export VDPAU_DRIVER=radeonsi       # Change accordingly

# =============================================================================
# Default Applications
# =============================================================================
export BROWSER=firefox
export TERMINAL=kitty
export PAGER=less
export MANPAGER='less -R'

# Use bat as man pager if available
if command -v bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# =============================================================================
# Development Tools
# =============================================================================
# Rust/Cargo
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# Go
export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# Python
export PYTHONUSERBASE="$HOME/.local"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"

# =============================================================================
# PATH Configuration
# =============================================================================
# Add user binaries to PATH
typeset -U path  # Ensure unique entries
path=(
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
    "$GOBIN"
    "$HOME/.npm-global/bin"
    "/usr/lib/ccache/bin"
    $path
)
export PATH

# =============================================================================
# Performance & Behavior
# =============================================================================
# Reduce key repeat delay
export KEYTIMEOUT=1

# Less options (colors already in config.zsh, but set pager behavior)
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Skip global compinit (we handle it in .zshrc)
skip_global_compinit=1

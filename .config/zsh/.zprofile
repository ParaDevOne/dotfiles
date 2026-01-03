# Profile file. Runs on login. Environmental variables are set here.

# Disable stem darkening for better font rendering
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

# Other programs settings:
# Color support & locale
export TERM="xterm-256color"
export COLORTERM="truecolor"
# Less with colors
export LESS='-R --mouse --incsearch'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;32m'

# Enable VA-API for video acceleration
export LIBVA_DRIVER_NAME=nvidia           # Change to 'nvidia' or 'intel' or 'radeonsi' if needed
export VDPAU_DRIVER=nvidia                # Change accordingly
export __GLX_VENDOR_LIBRARY_NAME=nvidia   # For NVIDIA drivers

# Wayland Configuration
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    # Core Wayland flags
    export WAYLAND=1
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm

    # Qt applications
    export QT_QPA_PLATFORM='wayland;xcb'
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt6ct

    # GTK applications
    export GDK_BACKEND='wayland'
    export GDK_DPI_SCALE=1

    # Mozilla applications (Firefox, Thunderbird)
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_DBUS_REMOTE=1
    export MOZ_WEBRENDER=1
    export MOZ_DISABLE_RDD_SANDBOX=1

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
    export EGL_PLATFORM=wayland
fi


# Development Tools

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

# PATH Configuration

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

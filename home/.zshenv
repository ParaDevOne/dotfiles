#!/usr/bin/env zsh

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ZSH configuration directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

# Default programs
export EDITOR=nano
export VISUAL="$EDITOR"
export TERMINAL=kitty
export BROWSER=brave
export MANPAGER='less -R'

# Less pager configuration
export LESS='-R --mouse --incsearch'
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;32m'

# Development tools home directories
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# PATH configuration
typeset -U path
path=(
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
    "$GOBIN"
    "$NPM_CONFIG_PREFIX/bin"
    "$PYTHONUSERBASE/bin"
    "/usr/lib/ccache/bin"
    $path
)
export PATH

# ZSH startup optimization
skip_global_compinit=1

export WLR_NO_HARDWARE_CURSORS=1

# Font rendering
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

# Video acceleration
#export LIBVA_DRIVER_NAME=nvidia
#export VDPAU_DRIVER=nvidia
#export __GLX_VENDOR_LIBRARY_NAME=nvidia

# Wayland configuration (if using Wayland)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export WAYLAND=1
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm
    export QT_QPA_PLATFORM='wayland;xcb'
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt6ct
    export GDK_BACKEND='wayland'
    export GDK_DPI_SCALE=1
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_DBUS_REMOTE=1
    export MOZ_WEBRENDER=1
    export MOZ_DISABLE_RDD_SANDBOX=1
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export AWT_TOOLKIT=MToolkit
    export SDL_VIDEODRIVER=wayland
    export CLUTTER_BACKEND=wayland
    export ECORE_EVAS_ENGINE=wayland_egl
    export ELM_ENGINE=wayland_egl
    export BEMENU_BACKEND=wayland
    export WINIT_UNIX_BACKEND=wayland
    export EGL_PLATFORM=wayland
fi

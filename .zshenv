#!/usr/bin/env zsh

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# ~/ Clean-up:
# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# Zsh configuration directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

# Defaults programs
export EDITOR=nano
export TERMINAL=kitty # or your preferred terminal emulator (ghostty, alacritty, kitty, konsole, etc.)
export BROWSER=brave # or or firefox
export MANPAGER='less -R'

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

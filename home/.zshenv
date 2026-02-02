#!/usr/bin/env zsh

if [ -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator ]; then
    set -a
    eval $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator 2>/dev/null)
    set +a
fi

# Less pager colors configuration
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;32m'

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
path=($^path(N/))
export PATH

# ZSH startup optimization
skip_global_compinit=1

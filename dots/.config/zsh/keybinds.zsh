# Set Emacs mode explicitly
bindkey -e

# Arrow keys: use default history widgets
# Up arrow
bindkey '^[[A' up-line-or-history
# Down arrow
bindkey '^[[B' down-line-or-history

# Additional keybindings for convenience
# Backspace
bindkey '^?' backward-delete-char
# Delete
bindkey '^[[3~' delete-char

# Ctrl+Space to accept autosuggestion
bindkey '^ ' autosuggest-accept


# Sudo Command Line Prepend

__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }

  # If cursor is inside the $old prefix, replace and reposition cursor after $new
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  # Otherwise replace $old in the left part of buffer (before cursor)
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }

  # If cursor is inside the $old prefix, replace and reposition cursor after $new
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  # Otherwise replace $old only in left part of buffer (before cursor)
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

sudo-command-line() {
  # Get last command from history if buffer is empty
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Preserve leading whitespace
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # Fast path: no editor defined, just toggle sudo
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "" ;;
        sudo\ *) __sudo-replace-buffer "sudo" "" ;;
        *) LBUFFER="sudo $LBUFFER" ;;
      esac
      return
    fi

    # Extract first word of typed command
    local cmd="${${(Az)BUFFER}[1]}"

    # Resolve alias to actual command if exists
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"

    # Extract first word of $EDITOR (may contain arguments)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Check if typed command is literally $EDITOR or matches the editor command
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" 2>/dev/null | command grep -Fx -q "$editorcmd"; then
      __sudo-replace-buffer "$cmd" "sudo -e"
      return
    fi

    # Handle editor commands and sudo toggling
    case "$BUFFER" in
      $editorcmd\ *) __sudo-replace-buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *) __sudo-replace-buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "$EDITOR" ;;
      sudo\ *) __sudo-replace-buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac

  } always {
    # Restore leading whitespace
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay for syntax highlighting compatibility
    zle && zle redisplay
  }
}

zle -N sudo-command-line
# Alt+s to prepend 'sudo' to the command line
bindkey '\e\e' sudo-command-line

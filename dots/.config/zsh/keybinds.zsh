# Set Emacs mode
bindkey -e

# Arrow keys for history navigation
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Delete/Backspace
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char

# Smart sudo toggle (Alt+S)
__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

sudo-command-line() {
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "" ;;
        sudo\ *)     __sudo-replace-buffer "sudo" "" ;;
        *)           LBUFFER="sudo $LBUFFER" ;;
      esac
      return
    fi

    local cmd="${${(Az)BUFFER}[1]}"
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    local editorcmd="${${(Az)EDITOR}[1]}"

    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" 2>/dev/null | command grep -Fx -q "$editorcmd"; then
      __sudo-replace-buffer "$cmd" "sudo -e"
      return
    fi

    case "$BUFFER" in
      $editorcmd\ *)  __sudo-replace-buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *)    __sudo-replace-buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *)    __sudo-replace-buffer "sudo -e" "$EDITOR" ;;
      sudo\ *)        __sudo-replace-buffer "sudo" "" ;;
      *)              LBUFFER="sudo $LBUFFER" ;;
    esac
  } always {
    LBUFFER="${WHITESPACE}${LBUFFER}"
    zle && zle redisplay
  }
}

zle -N sudo-command-line
bindkey '\es' sudo-command-line

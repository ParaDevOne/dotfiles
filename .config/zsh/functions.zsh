# Override the 'zi' function to avoid conflicts with any existing aliases or functions.

unalias zi 2>/dev/null

unset -f zi 2>/dev/null

function zi() {
    __zoxide_zi "$@"
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Up function: Navigate up multiple directory levels
# Use: up 3 (to go up 3 levels)
up() {
  local d=""
  local limit=${1:-1} # Por defecto sube 1 nivel si no pones número
  for ((i=1 ; i <= limit ; i++)); do
    d=$d"../"
  done
  cd $d
}

down() {
    local depth=${1:-1}
    local target=$(fd --type d --max-depth "$depth" . | fzf)
    [[ -n "$target" ]] && cd "$target"
}

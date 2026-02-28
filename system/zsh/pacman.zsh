#!/usr/bin/env zsh

#######################################
#           pacman / paru             #
#######################################

# instalar / desinstalar
alias i='paru -S'
alias un='paru -Rns'

alias fix='sudo pacman -Syu --noconfirm'

# buscar
alias s='paru -Ss'
alias si='paru -Si'

# info local
alias qi='pacman -Qi'
alias qs='pacman -Qs'

# limpiar cache
alias clean='paru -Sc'
alias cleanall='paru -Scc'

# huerfanos
alias orphans='pacman -Qdt'
alias rmorphans='[[ -n $(pacman -Qtdq) ]] && sudo pacman -Rs $(pacman -Qtdq) || echo "No orphans found"'

alias owns='pacman -Qo'                   # qué paquete es dueño de un archivo

# listar paquetes instalados explicitamente
alias lst='pacman -Qe'
alias lst-aur='pacman -Qm'

function upgrade() {
  sudo pacman -Sy
  echo ":: Checking Arch Linux PGP Keyring..."
  local installedver="$(LANG= sudo pacman -Qi archlinux-keyring | grep -Po '(?<=Version         : ).*')"
  local currentver="$(LANG= sudo pacman -Si archlinux-keyring | grep -Po '(?<=Version         : ).*')"
  if [ $installedver != $currentver ]; then
    echo " Arch Linux PGP Keyring is out of date."
    echo " Updating before full system upgrade."
    sudo pacman -S --needed --noconfirm archlinux-keyring
  else
    echo " Arch Linux PGP Keyring is up to date."
    echo " Proceeding with full system upgrade."
  fi
  paru -Su
}

#!/usr/bin/env bash

# ============================================
# INSTALADOR BRUTAL DE DOTFILES
# No te quejes si rompes algo, cabrón
# ============================================

set -euo pipefail

# Colores porque somos fancy
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Rutas - ajusta si usas otra estructura, imbécil
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"
readonly BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Estructura esperada del repo:
# DOTFILES_DIR/
# ├── .config/
# │   ├── kitty/
# │   ├── starship.toml
# │   └── fastfetch/
# └── home/
#     └── .zshrc

# ============================================
# FUNCIONES UTILES
# ============================================

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

die() {
    log_error "$*"
    exit 1
}

# Verifica si un comando existe
check_cmd() {
    command -v "$1" >/dev/null 2>&1
}

# Crea backup si el archivo/directorio existe
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        log_warn "Backup: $target -> $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        cp -rL "$target" "$BACKUP_DIR/" 2>/dev/null || true
        rm -rf "$target"
    fi
}

# Crea symlink con backup automático
create_symlink() {
    local src="$1"
    local dest="$2"
    
    if [[ ! -e "$src" ]]; then
        log_error "Source no existe: $src"
        return 1
    fi
    
    backup_if_exists "$dest"
    
    local dest_dir="$(dirname "$dest")"
    mkdir -p "$dest_dir"
    
    ln -sf "$src" "$dest"
    log_success "Linked: $dest -> $src"
}

# ============================================
# VERIFICACIONES PREVIAS
# ============================================

validate_dotfiles_structure() {
    log_info "Validando estructura de dotfiles en: $DOTFILES_DIR"
    
    local required_files=(
        ".config/kitty/kitty.conf"
        ".config/kitty/current-theme.conf"
        ".config/starship.toml"
        ".config/fastfetch/config.jsonc"
        "home/.zshrc"
    )
    
    local missing=()
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$DOTFILES_DIR/$file" ]]; then
            missing+=("$file")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Faltan estos archivos en tu repo de dotfiles:"
        printf '%s\n' "${missing[@]}" | sed 's/^/  - /'
        die "Estructura de dotfiles incompleta, cabrón"
    fi
    
    log_success "Estructura de dotfiles válida"
}

check_dependencies() {
    log_info "Verificando dependencias..."
    
    local missing=()
    local deps=(
        "zsh"
        "git"
        "eza"
        "fastfetch"
        "starship"
        "nvim"
    )
    
    for cmd in "${deps[@]}"; do
        if ! check_cmd "$cmd"; then
            missing+=("$cmd")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Faltan estas mierdas: ${missing[*]}"
        log_info "Instala con: paru -S ${missing[*]} (o yay, pacman, lo que uses)"
        read -p "¿Continuar de todos modos? [y/N]: " -r
        [[ ! $REPLY =~ ^[Yy]$ ]] && die "Abortado por el usuario"
    else
        log_success "Todas las dependencias presentes"
    fi
}

# ============================================
# INSTALACION DE COMPONENTES
# ============================================

install_oh_my_zsh() {
    log_info "Instalando Oh-My-Zsh..."
    
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_warn "Oh-My-Zsh ya instalado, saltando..."
        return 0
    fi
    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "Oh-My-Zsh instalado"
}

install_zsh_plugins() {
    log_info "Instalando plugins de ZSH..."
    
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # zsh-autosuggestions
    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            "$zsh_custom/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions instalado"
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting \
            "$zsh_custom/plugins/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting instalado"
    fi
    
    # zsh-completions
    if [[ ! -d "$zsh_custom/plugins/zsh-completions" ]]; then
        git clone https://github.com/zsh-users/zsh-completions \
            "$zsh_custom/plugins/zsh-completions"
        log_success "zsh-completions instalado"
    fi
}

install_kitty_config() {
    log_info "Instalando configuración de Kitty..."
    
    local kitty_config_dir="$HOME/.config/kitty"
    
    create_symlink "$DOTFILES_DIR/.config/kitty/kitty.conf" "$kitty_config_dir/kitty.conf"
    create_symlink "$DOTFILES_DIR/.config/kitty/current-theme.conf" "$kitty_config_dir/current-theme.conf"
    create_symlink "$DOTFILES_DIR/.config/kitty/dark-theme.auto.conf" "$kitty_config_dir/dark-theme.auto.conf"
    create_symlink "$DOTFILES_DIR/.config/kitty/kittysession.conf" "$kitty_config_dir/kittysession.conf"
    
    log_success "Configuración de Kitty instalada"
}

install_starship_config() {
    log_info "Instalando configuración de Starship..."
    
    create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
    
    log_success "Configuración de Starship instalada"
}

install_fastfetch_config() {
    log_info "Instalando configuración de Fastfetch..."
    
    create_symlink "$DOTFILES_DIR/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    
    log_success "Configuración de Fastfetch instalada"
}

install_zsh_config() {
    log_info "Instalando configuración de ZSH..."
    
    # Crear directorio para historial
    mkdir -p "$HOME/.config/zsh"
    
    create_symlink "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
    
    log_success "Configuración de ZSH instalada"
}

change_default_shell() {
    log_info "Cambiando shell por defecto a ZSH..."
    
    if [[ "$SHELL" == */zsh ]]; then
        log_warn "ZSH ya es tu shell por defecto"
        return 0
    fi
    
    local zsh_path="$(command -v zsh)"
    
    if ! grep -q "$zsh_path" /etc/shells; then
        log_error "$zsh_path no está en /etc/shells"
        log_info "Añade $zsh_path a /etc/shells manualmente, cabrón"
        return 1
    fi
    
    chsh -s "$zsh_path"
    log_success "Shell cambiado a ZSH (requiere logout/login)"
}

# ============================================
# INSTALACION PRINCIPAL
# ============================================

main() {
    echo -e "${GREEN}"
    cat << 'EOF'
    ____        __  _____ __         
   / __ \____  / /_/ __(_) /__  _____
  / / / / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  ) 
/_____/\____/\__/_/ /_/_/\___/____/  
                                      
    INSTALADOR BRUTAL DE DOTFILES
EOF
    echo -e "${NC}"
    
    log_info "Dotfiles source: $DOTFILES_DIR"
    log_info "Backup dir: $BACKUP_DIR"
    echo
    
    # Validar que los dotfiles existen
    validate_dotfiles_structure
    echo
    
    read -p "¿Proceder con la instalación? [y/N]: " -r
    [[ ! $REPLY =~ ^[Yy]$ ]] && die "Instalación cancelada"
    
    echo
    check_dependencies
    echo
    
    install_oh_my_zsh
    install_zsh_plugins
    echo
    
    install_kitty_config
    install_starship_config
    install_fastfetch_config
    install_zsh_config
    echo
    
    change_default_shell
    echo
    
    log_success "=========================================="
    log_success "INSTALACIÓN COMPLETADA, HIJO DE PUTA"
    log_success "=========================================="
    echo
    log_info "Backups guardados en: $BACKUP_DIR"
    log_info "Cierra sesión y vuelve a entrar para aplicar cambios completos"
    log_info "O ejecuta: exec zsh"
    echo
}

# ============================================
# EJECUCION
# ============================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
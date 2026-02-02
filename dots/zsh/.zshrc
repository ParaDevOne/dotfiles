# Modules loading for zsh features
zmodload zsh/complist
zmodload zsh/zle
zmodload zsh/parameter
zmodload zsh/datetime

# Ensure necessary directories exist
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"
[[ -d ~/.local/share/zsh ]] || mkdir -p ~/.local/share/zsh

export ZSH_CACHE="${XDG_CACHE_HOME}/zsh"
export ZSH_DATA="${XDG_DATA_HOME}/zsh"

# VI mode settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Cursores visuales para cada modo
ZVM_CURSOR_STYLE_ENABLED=true
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM   # Barra parpadeante en INSERT
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK           # Bloque en NORMAL
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE       # Subrayado en OPPEND

ZVM_KEYTIMEOUT=0.01

# Plugin manager - Antidote & Prompt
zsh_plugins="$ZSH_CACHE/.zsh_plugins.zsh"

if [[ ! -f "$zsh_plugins" || "$ZDOTDIR/.zsh_plugins.txt" -nt "$zsh_plugins" ]]; then
  source /usr/share/zsh-antidote/antidote.zsh
  antidote bundle <"$ZDOTDIR/.zsh_plugins.txt" >"$zsh_plugins"
  zcompile "$zsh_plugins"
fi
source "$zsh_plugins"
unset zsh_plugins

# Pure prompt settings & initialization
export PURE_GIT_PULL=1
export PURE_CMD_MAX_EXEC_TIME=2
export PURE_GIT_DELAY_PRECOMMAND_DISPLAY=3

autoload -Uz promptinit
promptinit
prompt pure

# Completion system
_zdump="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -Uz compinit
if [[ -f "${_zdump}.zwc" && "$_zdump" -ot "${_zdump}.zwc" ]]; then
  compinit -C -d "$_zdump"
else
  compinit -i -d "$_zdump"
  zcompile -R "$_zdump" 2>/dev/null
fi
unset _zdump

# Compile configuration files if they are newer than their compiled versions
for conf_file in "$ZDOTDIR"/*.zsh; do
    local cache_file="$ZSH_CACHE/zwc/${conf_file:t}.zwc"

    if [[ ! -f "$cache_file" || "$conf_file" -nt "$cache_file" ]]; then
        zcompile "$conf_file" -o "$cache_file"
    fi
done
# History & Setopt
HISTFILE="$ZSH_DATA/history"
HISTSIZE=50000
SAVEHIST=50000

setopt BANG_HIST EXTENDED_HISTORY HIST_VERIFY SHARE_HISTORY \
       HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS \
       HIST_REDUCE_BLANKS INC_APPEND_HISTORY HIST_FIND_NO_DUPS
setopt AUTOCD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT GLOB_DOTS \
       CORRECT NO_CASE_GLOB EXTENDED_GLOB NUMERIC_GLOB_SORT BRACE_CCL \
       AUTO_MENU COMPLETE_IN_WORD PROMPT_SUBST NO_BEEP NO_HUP \
       CHECK_JOBS NOTIFY INTERACTIVE_COMMENTS RMSTARWAIT NOCLOBBER GLOBSTARSHORT
unsetopt CORRECT_ALL MENU_COMPLETE

# Bracketed paste mode
zle_highlight=(paste:none)
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste-magic

# Man help keybinding
unalias run-help 2>/dev/null
autoload -Uz run-help
bindkey '^[h' run-help

# Pure prompt configuration
zstyle :prompt:pure:git:pre_prompt_delay 0.1
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:dirty check_untracked yes
zstyle :prompt:pure:execution_time threshold 2

zstyle :prompt:pure:prompt:success color "#C6A0F6"
zstyle :prompt:pure:prompt:error color "#ED8796"
zstyle :prompt:pure:path color "#8AADF4"
zstyle :prompt:pure:git:branch color "#91D7E3"
zstyle :prompt:pure:git:dirty color "#EED49F"
zstyle :prompt:pure:git:arrow color "#A6DA95"
zstyle :prompt:pure:virtualenv color "#F5BDE6"
zstyle :prompt:pure:user color "#B8C0E0"
zstyle :prompt:pure:host color "#B8C0E0"
zstyle :prompt:pure:execution_time color "#F5A97F"

# Completion styles & performance
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zcompcache"
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' file-patterns '*(-/):directories' '*:all-files'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,%cpu,cmd'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps auxww | awk "{print \$11}"'
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*' single-ignored show
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Fzf Tab - fuzzy tab completion
zstyle ':fzf-tab:*' fzf-flags \
  --height=50% --layout=reverse --border=rounded --info=inline \
  --prompt='➜ ' --pointer='▶' --marker='✓' \
  '--color=fg:#cad3f5,bg:#24273a,hl:#ed8796' \
  '--color=fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796' \
  '--color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6' \
  '--color=marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4'

zstyle ':fzf-tab:*' fzf-min-height 15
zstyle ':fzf-tab:complete:cd:*' fzf-preview '[[ -d $realpath ]] && eza -1 --color=always $realpath 2>/dev/null || ls -1 --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word 2>/dev/null | col -bx | bat --color=always --language=man --plain 2>/dev/null || man $word 2>/dev/null | col -bx'

# FZF - Fuzzy finder
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info --color=fg:#cad3f5,bg:#24273a,hl:#ed8796,fg+:#cad3f5,bg+:#363a4f,hl+:#ed8796 --color=info:#c6a0f6,prompt:#a6da95,pointer:#f4dbd6,marker:#f4dbd6,spinner:#f5a97f,header:#8aadf4'

  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  local fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-init.zsh"
  if [[ ! -f "$fzf_cache" || =fzf -nt "$fzf_cache" ]]; then
    fzf --zsh > "$fzf_cache" 2>/dev/null
    zcompile "$fzf_cache"
  fi
  zsh-defer source "$fzf_cache"
fi

# Autosuggestions - zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10000
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Alias tips - Show when you have an alias for a command
export ZSH_ALIAS_TIPS_TEXT='Tip: '
export ZSH_ALIAS_TIPS_EXCLUDES='_*'

# Fast syntax highlighting - Extended colors & styles
export FAST_HIGHLIGHT_USE_EXTENDED_STYLES=1

# Enable language-specific highlighting
FAST_HIGHLIGHT[chroma-man]=1
#FAST_HIGHLIGHT[chroma-whatis]=
FAST_HIGHLIGHT[chroma-git]=1
#FAST_HIGHLIGHT[chroma-docker]=
#FAST_HIGHLIGHT[chroma-kubectl]=
#FAST_HIGHLIGHT[chroma-make]=
#FAST_HIGHLIGHT[chroma-npm]=
#FAST_HIGHLIGHT[chroma-node]=
#FAST_HIGHLIGHT[chroma-vim]=
#FAST_HIGHLIGHT[chroma-ssh]=

typeset -gA FAST_HIGHLIGHT_STYLES=(
  # Base
  default 'fg=none,bold=no'
  unknown-token 'fg=#ED8796,bold=1'
  commandseparator 'fg=#F5BDE6,bold=1'
  # Keywords & Reserved
  reserved-word 'fg=#EED49F,bold=1'
  precommand 'fg=#A6DA95,italic=1'
  # Commands
  alias 'fg=#A6DA95,bold=1'
  suffix-alias 'fg=#A6DA95,bold=1,underline=1'
  global-alias 'fg=#A6DA95,bold=1,italic=1'
  builtin 'fg=#A6DA95,bold=1'
  function 'fg=#A6DA95,bold=1'
  command 'fg=#A6DA95'
  hashed-command 'fg=#A6DA95'
  # Paths & Files
  path 'fg=#8BD5CA,bold=1'
  path-pathseparator 'fg=#8BD5CA'
  path_prefix 'fg=#8BD5CA'
  path_prefix_pathseparator 'fg=#8BD5CA'
  # Globbing & Patterns
  globbing 'fg=#F5BDE6,bold=1'
  globbing-ext 'fg=#F5BDE6,bold=1'
  # History
  history-expansion 'fg=#F5BDE6,bold=1'
  # Options
  single-hyphen-option 'fg=#8AADF4'
  double-hyphen-option 'fg=#8AADF4,bold=1'
  # Quotes & Strings
  back-quoted-argument 'fg=#EED49F'
  single-quoted-argument 'fg=#EED49F'
  double-quoted-argument 'fg=#EED49F'
  dollar-quoted-argument 'fg=#C6A0F6'
  # Quote internals
  back-quoted-argument-unclosed 'fg=#ED8796'
  single-quoted-argument-unclosed 'fg=#ED8796'
  double-quoted-argument-unclosed 'fg=#ED8796'
  dollar-quoted-argument-unclosed 'fg=#ED8796'
  rc-quote 'fg=#EED49F'
  dollar-double-quoted-argument 'fg=#C6A0F6,bold=1'
  back-double-quoted-argument 'fg=#EED49F'
  back-dollar-quoted-argument 'fg=#C6A0F6'
  # Assignments
  assign 'fg=#F4DBD6,bold=1'
  assign-array-bracket 'fg=#F5BDE6,bold=1'
  # Redirection
  redirection 'fg=#F5BDE6,bold=1'
  # Comments
  comment 'fg=#6E738D,italic=1'
  # Variables & Expansions
  variable 'fg=#F4DBD6'
  mathvar 'fg=#F4DBD6'
  mathnum 'fg=#F5A97F'
  matherr 'fg=#ED8796'
  assign-varname 'fg=#F4DBD6'
  arrvar 'fg=#F4DBD6'
  arrvarname 'fg=#F4DBD6'
  # Parameter expansion
  named-fd 'fg=#8AADF4'
  numeric-fd 'fg=#F5A97F'
  arg0 'fg=#8AADF4,bold=1'
  # Brackets & Delimiters
  paired-bracket 'fg=#F5BDE6,bold=1'
  bracket-level-1 'fg=#F5BDE6,bold=1'
  bracket-level-2 'fg=#C6A0F6,bold=1'
  bracket-level-3 'fg=#8AADF4,bold=1'
  # Misc
  here-string-tri 'fg=#EED49F'
  here-string-text 'fg=#EED49F'
  here-string-var 'fg=#C6A0F6,bold=1'
  exec-descriptor 'fg=#8AADF4,bold=1'
  # Corrections
  correct-subtle 'fg=#A6DA95,bg=#1E2030'
  incorrect-subtle 'fg=#ED8796,bg=#1E2030'
  # Params
  param-expansion 'fg=#C6A0F6,bold=1'
  # Subshells
  subcommand 'fg=#91D7E3'
  # Process substitution
  process-substitution 'fg=#91D7E3'
  process-substitution-delimiter 'fg=#F5BDE6,bold=1'
  # Command substitution
  command-substitution 'fg=#91D7E3'
  command-substitution-delimiter 'fg=#F5BDE6,bold=1'
  command-substitution-unquoted 'fg=#91D7E3'
  command-substitution-quoted 'fg=#EED49F'
  # Arithmetic
  arithmetic-expansion 'fg=#F5A97F,bold=1'
)

# Load external config files with lazy loading
zsh-defer source "$ZDOTDIR/keybinds.zsh"
zsh-defer source "$ZDOTDIR/aliases.zsh"
zsh-defer source "$ZDOTDIR/git.zsh"
zsh-defer source "$ZDOTDIR/functions.zsh"

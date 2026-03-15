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
FAST_HIGHLIGHT[chroma-git]=1
FAST_HIGHLIGHT[chroma-vim]=1

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


#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#


# General Options


USE_POWERLINE="true"				# Use powerline
HAS_WIDECHARS="true"				# Has weird character width
HISTFILE=~/.config/zsh/.zsh_history	# Location of your shell history file.
HISTSIZE=2000		
SAVEHIST=4000						# In-memory history length and how many entries are saved to disk.
HIST_IGNORE_DUPS="true"				# Avoid storing sequential duplicate commands in your history.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'	# Style for zsh-autosuggestions (ghosted suggestions shown while you type).
COLORTERM="truecolor"
FORCE_256COLORS="true"				# Tell programs your terminal supports 24-bit color or force 256-color mode for better themes.
#SETOPT
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.


# Aliases

alias ez='eza --icons=always --color=always -a'
alias e='eza --icons=always --color=always -la'
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'


# Exports

export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"


# Configs OH-MY-ZSH


plugins=(
	git
	sudo
	archlinux
	zsh-autosuggestions 
	zsh-syntax-highlighting 
	zsh-completions 
)

source $ZSH/oh-my-zsh.sh

# Init Starship

eval "$(starship init zsh)"

# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"

export ZSH="$HOME/.oh-my-zsh"

plugins=(
	kitty
	starship
	fancy-ctrl-z
	encode64
	emoji
	tldr
	git
	gitignore
	github
	zsh-interactive-cd
	zsh-autosuggestions 
	zsh-syntax-highlighting 
	zsh-completions 
	zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

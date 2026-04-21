#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias nigger='sudo pacman -Syu'

alias ff='fastfetch'

alias whatdoyoucallablackman='momoisay nigger'

PS1='\w -> '

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

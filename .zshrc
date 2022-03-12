# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=999999999999
SAVEHIST=999999999999
# bindkey -v # This enables vim like keybindings
bindkey -e # This enables emacs like keybindings.
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/array/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall
#

#  Load prompt ~Sahil
promptinit
# This will set the default prompt to the walters theme ~Sahil
prompt walters
# You can list the prompt available themes by `prompt -l` command.
#

source ~/.bash_functions
source ~/.bash_aliases

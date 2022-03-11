#
# ~/.bashrc, `realpath .bashrc` ouputs `/home/array/.bashrc`.
#sahil: `rc` as suffix of .bashrc file name means `run commands`.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# I have sourced this file in root shell's .bashrc file as well i.e., `/root/.bashrc` ~Sahil. And that file is invoked when we login to root user i.e., `su`. It'll load all your aliases and functions in root shell as well that you enjoy in your non-root shells.

### Variables
# Original from archos.
# export PS1='[\u@\h \W]\$ ' 
# ~Sahil: For colouring the username and hostname in cli: Source: https://askubuntu.com/a/123306/702911 (simply direct copy paste)
# BACKUP # export PS1='\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
ps1_format='\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
# Source of below PS1: https://superuser.com/a/60563/776589
ps1_format_show_current_dir_only='\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$'
export PS1=$ps1_format
# export PS1=$ps1_format_show_current_dir_only
_home=/home/array # Did coz I'll source this file in sudo as well.
export PATH=$PATH:~/.local/bin
export EDITOR=/usr/bin/nvim
export HISTSIZE=5000000 	# Increasing the history saving capacity to 50 lakhs.
export HISTFILESIZE=5000000	# Increasing the history saving capacity to 50 lakhs. Source: https://www.redhat.com/sysadmin/history-command
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll:history:c"
#^^^^^^ Src: https://github.com/jonhoo/configs/blob/master/shell/.bashrc
#force_color_prompt=yes
# XDG_CONFIG_HOME This is to make neovim take the nvim directory path as mentined @ https://wiki.archlinux.org/title/Neovim
export XDG_CONFIG_HOME='/home/array'
#export XDG_CONFIG_HOME='~' #BEWARE: This causes blunder.

# Function to show/hide folder paths in terminal:
function hidepath_in_terminal(){
	# source: https://askubuntu.com/a/1158624/702911
	export PS1='$ '
}
function hidepath_in_terminal2(){
	export PS1='> '
}
function hidepath_in_terminal3(){
	export PS1='\w > '
}
function showpath_in_terminal(){
	export PS1=$ps1_format
}

### Sources:
source $_home/.bash_aliases
source $_home/.bash_functions
# Other sources
. "$_home/.cargo/env" # From cargo docs: . "$HOME/.cargo/env" 
. /usr/share/nvm/init-nvm.sh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh #Making autojump work!

function show_custom_info() {
	echo "SYSTEM		: $(uname -a)"
	echo "HOSTNAME	: $HOSTNAME"
	echo "UPTIME		: $(uptime)"
	echo "DISK		: $(df /home/array | tail -1)"
	echo "HOSTNAMECTL	:"
	hostnamectl
	echo
}
# show_custom_info
# I am using neofetch to display general os info now:
# neofetch

# Running tmux as default shell: Source: https://unix.stackexchange.com/a/113768/504112
function enableTmux() {
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  	  exec tmux
  	  # Config file @ ~/.tmux.conf
  fi
}
enableTmux

# Enable tmux based clear screen with ctrl+l in shell: (This is free from non-tmux errors too).
# Source: https://unix.stackexchange.com/a/29239/504112
bind -x '"\C-l": clear; tmux clear-history'


# I added the FZF_DEFAULT_COMMAND myself by seeing it in the stackoverfow question: https://stackoverflow.com/q/61865932/10012446
# So, it'll ignore the node_modules and .git directories.
# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
# NOTE I CHANGED THE quote mechanism to single quote inside the command and double quote to wrap the whole rg command.
# export FZF_DEFAULT_COMMAND="rg --files -g '!node_modules'"
# export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{node_modules/**,.git/**, **/.yarn.lock}'"
# export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/**,**/.git/**, **/.yarn.lock}'"
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*, **/.yarn.lock}'"
#
# Below command is when we do a ctrl+t in terminal. # src: https://github.com/junegunn/fzf/issues/763#issuecomment-266176437
export FZF_CTRL_T_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*, **/.yarn.lock}'"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /home/array/broot/launcher/bash/br

# Enable vim mode for terminal as well:
# Src: https://dev.to/brandonwallace/how-to-use-vim-mode-on-the-command-line-in-bash-fnn
# set -o vi
#

# Enable case-insensitive approach when doing tab complete in bash: src: https://askubuntu.com/a/1081444/702911
bind "set completion-ignore-case on"

# bash-git-prompt
# source(AUR): https://aur.archlinux.org/packages/bash-git-prompt
enable_bash_git_prompt(){
	# NOTE: To use bash-git-prompt, you should add the following to your
	#       /etc/bash.bashrc or ~/.bashrc:

	if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
	   # To only show the git prompt in or under a repository directory
	   # GIT_PROMPT_ONLY_IN_REPO=1
	   # To use upstream's default theme
	   # GIT_PROMPT_THEME=Default
	   # To use upstream's default theme, modified by arch maintainer
	   GIT_PROMPT_THEME=Default_Arch
	   source /usr/lib/bash-git-prompt/gitprompt.sh
	fi

	# NOTE: To have the colors shown by 'git status' match the Default_Arch theme,
	#       add the following to your ~/.gitconfig:

	[color "status"]
	   branch = magenta
	   untracked = cyan
	   unmerged = yellow
		# And if you want boilerplate to be less prominent, also:
	   header = bold black
}
# UNCOMMENT BELOW LINE TOGLLE ENABLE/DISABLE BASH-GIT-PROMPT
# enable_bash_git_prompt


# autocd was introduced into bash with version 4. So, a general cross-platform solution should be: src: https://unix.stackexchange.com/a/124432/504112
# This enabled to cd to folders without cd command:
[ "${BASH_VERSINFO[0]}" -ge 4 ] && shopt -s autocd

# To supress cd verbose command i can do like:
exec {BASH_XTRACEFD}>/dev/null
# src: https://www.reddit.com/r/linuxquestions/comments/cn1i20/suppressing_output_from_autocd_on_bash/?utm_source=share&utm_medium=web2x&context=3

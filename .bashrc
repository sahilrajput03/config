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
ps1_format_show_current_dir_only='\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\$ '

#This is pretty good though
# export PS1=$ps1_format 

export PS1=$ps1_format_show_current_dir_only
_home=/home/array # Did coz I'll source this file in sudo as well.

# TIP: Move any executable file to `~/.local/bin/` directory, we can use it as a cli tool.
export PATH=$PATH:~/.local/bin
export EDITOR=/usr/bin/nvim
export HISTSIZE=5000000 	# Increasing the history saving capacity to 50 lakhs.
export HISTFILESIZE=5000000	# Increasing the history saving capacity to 50 lakhs. Source: https://www.redhat.com/sysadmin/history-command
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll:history:c"
# Write every command to $HISTFILE on every run of command (don't loose your command history):
# DEFAULT $HISTFILE is `~/.bash_history`.
### Append command history to $HISTFILE after each command:
PROMPT_COMMAND="${PROMPT_COMMAND:-:} ; history -a"
### Append command hisotry to $HISTFILE after each command and also clean and reload history in current shell: src: https://askubuntu.com/a/339925/702911
# HELP: This helps in sharing command history across different shell (i.e., pressing up/ctrl+p to see previous command will show command from different shell, FYI:IMPORTANT: You need to make a command to reload from the history file which was modified by other shell at latest, so you can simply press ENTER key to fetch history file again for that sake. YIKES! )::
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
################ TIP: echo $PROMPT_COMMAND to know its value in bash.##############
### Avoid duplicates in $HISTFILE: (works good, but it helps to see repeated command to see the chronological order):
# export HISTCONTROL=ignoredups:erasedups
### Appent to $HISTFILE as soon any command is run:
shopt -s histappend
# src(histappend, prompt_command): https://askubuntu.com/a/339925/702911

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

function showpath_last_folder_only(){
	# export PS1='\W > '
	# Using colored one now: src: https://linuxhostsupport.com/blog/how-to-change-the-color-of-your-linux-prompt/
	export PS1="\e[0;33;1m[\u@\h \W]\$ \e[m"
	# ^^ issue i.e., command text rolls over same line when command text is too large, so its yucky!
}

function showpath_in_terminal(){
	export PS1=$ps1_format
}
# showpath_last_folder_only

### Sources:
# source: https://unix.stackexchange.com/a/1498/504112
# shopt -s expand_aliases source ~/.bash_aliases
# shopt -s expand_aliases
# so shopt will expand your aliases in any shell script as well.
[[ -f $_home/.bash_aliases ]] && source $_home/.bash_aliases
[[ -f $_home/.bash_functions ]] && source $_home/.bash_functions
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
	echo "Architecture	:" $(getconf LONG_BIT) BIT
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
#


thought(){
	get_thought(){
		shuf $_home/Documents/github_repos/sahilrajput03/thoughts-principles.md -n1 | grep '.'
		# With grep '.' I am implying don't empty line output if the output is empty.
		# print something in cyan color: 
		# tput setaf 6; echo hell; tput sgr0
	}
	echo -ne $CYAN$BOLD
	# ce "Thought:" 6
	echo -n "Thought - "
	while ! get_thought ; do true; done
}


booz(){
	WHITE='\e[97m'
	BOLD='\e[1m'
	CYAN='\033[0;36m'
	RESET_ALL_FORMATTING='\e[0m'

	###### TASK:: GET A RANDOM THOUGHT:
	thought

	###### TASK:: GET LIST OF ALL WHAT I CAM CURRENTLY FOCUSSING ON:
	echo -ne $WHITE
	echo -n "Focussing "
	# Any thing that starts with `- !` in todo list and SHOW ONLY ONE OF THEM.
	grep '\- !' $_home/scripts-in-use/td/must-can | shuf -n1

	###### TASK:: GET TODO LIST:
	echo # Need emtpy line space: INTENTIONAL:
	$_home/scripts-in-use/td/s.sh
}
# Toggle comment/uncommment to enable/disable booz
booz

##### Enable autocomplete for kubectl alias
# complete -F _complete_alias kc # Using something like this we can autocomplete for aliases as well. src: https://unix.stackexchange.com/a/332522/504112
source <(kubectl completion bash)
complete -F __start_kubectl kc # src: https://stackoverflow.com/a/52907262/10012446
# src: WOW! OFFICIAL DOCS: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

####TETSING WITH EXEC ALIASING!!
# ko() {
# 	kubectl exec $@
# }
# complete -F ko kp
# complete -F _kubectl_exec ke
#####


###### Mapping docker bash-completion to dk as well: (using TAB):
[[ -f /usr/share/bash-completion/completions/docker ]] && source /usr/share/bash-completion/completions/docker
complete -F _docker dk
# src: https://brbsix.github.io/2015/11/23/perform-tab-completion-for-aliases-in-bash/


# Read todo.txt file if present in directory:
if [ -f "todo.txt" ] ; then
	# display its contents
	cat todo.txt
fi


# cd /home/array/Documents/github_repos/devopswithkubernetes
#

# Read todo.txt file if present in current directory, src: https://superuser.com/a/283365/776589
function cd {
    # actually change the directory with all args passed to the function
    builtin cd "$@"
    # if there's a regular file named "todo.txt"...
    if [ -f "todo.txt" ] ; then
        # display its contents
        cat todo.txt
    fi
}

alias lens='/usr/share/lens/lens'

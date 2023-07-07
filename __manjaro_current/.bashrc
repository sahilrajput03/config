# bashrc
#

# NOTE: This function must be defined above the `return` statement below where we don't execute .bashrc file for interactive shells i.e., when we do `source myFile.sh`
function backupManjaroCurrent() {
	# boom
	BACKUP_DIR="/home/array/Documents/github_repos/config/__manjaro_current/"
	cp /home/array/.profile $BACKUP_DIR
	cp /home/array/.bashrc $BACKUP_DIR
	cp /home/array/.bash_profile $BACKUP_DIR
	cp /home/array/.bash_capacitor $BACKUP_DIR
	cp /home/array/.gitconfig $BACKUP_DIR
	cd $BACKUP_DIR
	# Sync github repository
	git add . && git commit -m "Automatic Backup Via Cron"
	git pull && git push
	# Return to original directory
	cd -
}
##########
########## INTERACTIVE Shell Code ABOVE
##########

# Return simply from here for interactive shells
[[ $- != *i* ]] && return

##########
########## NON-INTERACTIVE Shell Code BELOW
##########

########## Note: Any alias/function defined below will not be accessible to cron even if the .bashrc file is sourced.
########## (Learn - Interactive and Non-Interactive Shells - https://phoenixnap.com/kb/bashrc-vs-bash-profile)

# Set maximum space to 8gb for react server to work for
export NODE_OPTIONS=--max-old-space-size=8192

# This is necessary to make tmux pick ~/.tmux.conf file as configuration file
export XDG_CONFIG_HOME='/home/array'

# Import .bash_capacitor
[ -f /home/array/.bash_capacitor ] && source /home/array/.bash_capacitor

# Running tmux as default shell: Source: https://unix.stackexchange.com/a/113768/504112
function enableTmux() {
	if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] &&
		[ -z "$TMUX" ]; then
		exec tmux
		# Config file @ ~/.tmux.conf
	fi
}
enableTmux
# Enable tmux based clear screen with ctrl+l in shell: (This is free from non-tmux errors too).
# Source: https://unix.stackexchange.com/a/29239/504112
bind -x '"\C-l": clear; tmux clear-history'

# some aliases
alias slasherDEPLOY_CURRENT_BRACH_TO_STAGING='git push --force origin $(git branch --show-current):deploy/staging'
alias fixdocker.sockPermissionIssue='sudo chmod 666 /var/run/docker.sock'
alias cd.slasherfrontend='cd ~/test/slasher/slasher-web-frontend'
alias cd.slasherbackend='cd ~/test/slasher/slasher-web-new'
alias nr='npm run'
alias ...='exec bash'
alias e='exit'
alias vi.timetracking='vi ~/test/slasher/time-tracking-sahil.txt'
alias s='BROWSER=none npm start'
alias c='clear'
alias r='reset'
alias red='redshift -P -O'
alias red='redshift -P -O'
alias cd.battery-alert='cd ~/Documents/github_repos/config/scripts/battery-alert'
alias vi.bashrc='vi ~/.bashrc'
alias cd.apkNativeProject='cd app/build/outputs/apk/debug/'
# Fix the opening of web links in chrome window instead of opening new window of google-chrome it now opens currently running windows. (Time took: 3.5 hours). Src: https://stackoverflow.com/a/50736123/10012446
alias code='i3-msg "exec --no-startup-id code"'

function co() {
	i3-msg "exec --no-startup-id code $PWD"
	# If above throws error then simply use `tmuxkill` to kill the tmux session to fix the error as
	# suggested in below issue of i3
	# https://github.com/i3/i3/issues/3845
}
function cor() {
	i3-msg "exec --no-startup-id code $PWD -r"
}

# Enable case-insensitive approach when doing tab complete in bash: src: https://askubuntu.com/a/1081444/702911
bind "set completion-ignore-case on"

# Disable keyboard clit (fix the autolcicking issue when typing on keyboard):
alias disableKeyboardClit='xinput -set-prop "DELL08B8:00 0488:121F Mouse" "Device Enabled" 0'
# Disable trackpad (in favor of using external mouse)
alias disableTrackpad='xinput -set-prop "DELL08B8:00 0488:121F Touchpad" "Device Enabled" 0'
# Comment/Uncomment below lines to toggle behavior (Tip: You can use same aliases to manually disable them too)
disableKeyboardClit
disableTrackpad

## PLEASE ADD MORE CODE ABOVE THIS LINE ONLY SAHIL

# ------ old manjaro based bash code ----------

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo
		echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | interix | konsole*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
	;;
screen*)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
	;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?} # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] &&
	type -P dircolors >/dev/null &&
	match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color}; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null; then
		if [[ -f ~/.dir_colors ]]; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]]; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]]; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]]; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root >/dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
source /usr/share/nvm/init-nvm.sh

# .bashrc
#

_home=/home/array # Did coz I'll source this file in sudo as well.
backup_dir="/home/array/Documents/github_repos/config/__manjaro_current"
# VSCODE CONFIG FILES
vs_code_config_directory=".config/Code/User"

# NOTE: This function must be defined above the `return` statement below where we don't execute .bashrc file for interactive shells i.e., when we do `source myFile.sh`
function backupManjaroCurrent() {
	cp /home/array/.profile $backup_dir
	cp /home/array/.bashrc $backup_dir
	cp /home/array/.bash_profile $backup_dir
	cp /home/array/.bash_capacitor $backup_dir
	cp /home/array/.gitconfig $backup_dir
	cp -r /home/array/.i3 $backup_dir
	cp /home/array/.i3status.conf $backup_dir

	crontab -l >$backup_dir/crontab_entries.txt
	echo "Backup of crontab entries succeeded."

	# Make sure `$vs_code_config_directory` directory exists in $backup_dir directory
	mkdir -p $backup_dir/$vs_code_config_directory
	#
	\cp $_home/$vs_code_config_directory/keybindings.json $backup_dir/$vs_code_config_directory/
	echo "Backup of ~/$vs_code_config_directory/keybindings.json file succeeded."
	#
	\cp $_home/$vs_code_config_directory/settings.json $backup_dir/$vs_code_config_directory/
	echo "Backup of ~/$vs_code_config_directory/settings.json file succeeded."
	#
	# Backup snippets file
	mkdir -p $backup_dir/$vs_code_config_directory/snippets
	\cp $_home/$vs_code_config_directory/snippets/QuickSnippets.code-snippets $backup_dir/$vs_code_config_directory/snippets
	echo "Backup of ~/$vs_code_config_directory/snippets/QuickSnippets.code-snippets file succeeded."
	#
	# Backup my current vscode extensions list as well. Src: https://stackoverflow.com/a/49398449/10012446
	\code --list-extensions | xargs -L 1 echo code --install-extension >$backup_dir/$vs_code_config_directory/MyExtensionInstaller.sh
	chmod +x $backup_dir/$vs_code_config_directory/MyExtensionInstaller.sh

	cd $backup_dir

	# Sync github repository
	git add . && git commit -m "Automatic Backup Via Cron"
	git pull --no-edit && git push
	# Return to original directory
	cd -
}
##########
########## NON-INTERACTIVE Shell (Sub Shell) Code  ABOVE
##########

# Return simply from here for non-interactive shells
[[ $- != *i* ]] && return

##########
########## INTERACTIVE Shell (Current Sub Shell) Code  BELOW
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
# *LEARN: In slasher project the default deployment on staging and production are without tests.
alias slasherDEPLOY_CURRENT_BRACH_TO_STAGING='git push --force origin $(git branch --show-current):deploy/staging'
# alias slasherDEPLOY_CURRENT_BRACH_TO_STAGING_SKIP_TESTS='git push --force origin $(git branch --show-current):deploy/staging-skiptests'
# alias slasherDEPLOY_CURRENT_BRACH_TO_PRODUCTION='git push --force origin $(git branch --show-current):deploy/prod'
# alias slasherDEPLOY_CURRENT_BRACH_TO_PRODUCTION_SKIP_TESTS='git push --force origin $(git branch --show-current):deploy/prod-skiptests'
alias slasherDEPLOY_CURRENT_BRACH_TO_PRODUCTION="echo Please use with care, and you may enable it from your bash config file now. Happy deployment."
# alias slasherDEPLOY_CURRENT_BRACH_TO_PRODUCTION_SKIP_TESTS='echo Please use with care, and you may enable it from your bash config file now. Happy deployment.'

# No longer needed to fix sock permission on each boot, check: https://github.com/sahilrajput03/sahilrajput03/blob/master/arch-notes.md#setup-softwares-quickly--_please_keep_this_post-_top
# alias fixdocker.sockPermissionIssue='sudo chmod 666 /var/run/docker.sock'

alias cd.slasherfrontend='cd ~/test/slasher/slasher-web-frontend'
alias cd.slasherbackend='cd ~/test/slasher/slasher-web-new'
alias slasher.test-everything='npm run test; npm run test:e2e-core; npm run test:e2e-gateway'

# Usage of below: command <movies.service.spec, movies.service.spec, get-all-movies.e2e-spec, etc
alias slasher.test-service='node --inspect -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --config ./test/jest-config.json --testTimeout 600000 --runInBand --watch'
alias slasher.test-e2e-core='node --inspect -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --config ./test/jest-e2e-core-config.json --testTimeout 600000  --runInBand --watch'
alias slasher.test-e2e-gatewayy='node --inspect -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --config ./test/jest-e2e-gateway-config.json --testTimeout 600000 --runInBand --watch'
alias updateSlasherStagingDbIpAddress='node /home/array/test/slasher/slasher-db-access/service-to-update-ip-slasher-db-access/update-ip-on-staging.js'

alias cd.config='cd ~/Documents/github_repos/config/'
alias gs='git status'
alias listServicesSahil='systemctl --type=service | grep sahil--'
alias listServicesSahilFiles='ls -l /etc/systemd/system/ | grep sahil--'

alias slasherStartDocker='docker compose --file docker-compose.devtest.yml up --build'
alias restartSlasherDockerService='systemctl restart sahil--slasher-mongodb-docker.service'

alias nr='npm run'
alias ..='cd ..'
alias ...='exec bash'
alias e='exit'
alias vi.all_are_moved_to_vscode_via_co.__here__='echo Happy migrating to vscode.'
alias s='BROWSER=none npm start'
alias c='clear'
alias r='reset'
# Usage: red TEMPERATUR, e.g., red 1000, red 25000
alias red='redshift -P -O'
# Use `redReset` to reset
alias redReset='redshift -x'
alias cd.battery-alert='cd ~/Documents/github_repos/config/scripts/battery-alert'
alias cd.apkNativeProject='cd app/build/outputs/apk/debug/'
alias blc='bluetoothctl'

########## Playwright Aliases and Functions ##########
# 1. ❤️ CLI Only
alias pt='npx playwright test --project=chromium'
#   Playwright watch script: source: https://github.com/microsoft/playwright/issues/21960#issuecomment-1483604692
alias ptw='PWTEST_WATCH=1 npx playwright test --project=chromium'
# *ALTERNATE using nodemon
function ptw2() {
	nodemon -e spec.ts -w tests -x "npx playwright test --project=chromium $@"
	# nodemon -e spec.ts -w tests -x "echo $@"
}
# 2. 🤢 PLAYWRIGHT UI MODE: ⚠️⚠️Seems some problem with ui mode at the time⚠️⚠️
# TIP: UI mode does provide watching script out of the box as well using th `eye` icon in GUI
alias ptu='npx playwright test --project=chromium --ui'
#
# 3. ❤️ PLAYWRIGHT HEADED MODE + Using `await page.pause()` #
alias pthOnce='npx playwright test --headed --project=chromium'
# 🚀🚀🚀🚀🚀🚀 Use `pth` all the time because DX with awesome with ❤️ `await page.pause()`
function pth() {
	nodemon -e spec.ts -w tests -x "npx playwright test --headed --project=chromium $@"
	# nodemon -e spec.ts -w tests -x "echo $@"
}
# 4. ❤️ PLAYWRIGHT DEBUG MODE #
# LEARN: Open `Playwright Inspector` ((helpful in debugging & step by step execution))
# *DEPRECATED in favor of watch mode with nodemon
# alias ptd='npx playwright test --project=chromium --debug'
function ptd() {
	nodemon -e spec.ts -w tests -x "npx playwright test --project=chromium --debug $@"
	# nodemon -e spec.ts -w tests -x "echo $@"
}
# 5. ❤️ Playwright Reprot of Last Test #
alias ptr='npx playwright show-report'
# 6. Delete previous test video reording
alias ptremovePrevioustTestVideo='rm -rf test-results/*'
########## ##########

# Connecting to Airdopes 441P: 00:00:AB:CE:16:01
# Use this command in the subshell: `connect 00:00:AB:CE:16:01`

# Fix the opening of web links in chrome window instead of opening new window of google-chrome it now opens currently running windows. (Time took: 3.5 hours). Src: https://stackoverflow.com/a/50736123/10012446
alias code='i3-msg "exec --no-startup-id code"'
function sudoCode() {
	# Does not work
	# i3-msg "exec --no-startup-id sudo \code --no-sandbox --user-data-dir=/home/array/.config/Code/ $1"

	# Below works (23 July, 2023) (Note: I also added additional extensions directory as well)
	sudo \code $1 --no-sandbox --user-data-dir=/home/array/.config/Code/ --extensions-dir=/home/array/.vscode/extensions
}

# Helpful to get useful info for i3 to make them floatable:
alias xprop2i3='/home/array/Documents/github_repos/config/scripts/xprop2i3.sh'

alias co.bashrc='co ~/.bashrc'
alias co.timetracking='co ~/test/slasher/time-tracking-sahil.txt'
alias co.i3config='co ~/.i3/config'
alias xo='xournalpp'

function co() {
	if [ -z "$1" ]; then
		echo hello world

		i3-msg "exec --no-startup-id code $PWD"
		return
	fi
	i3-msg "exec --no-startup-id code $@"
	# If above throws error then simply use `tmuxkill` to kill the tmux session to fix the error as
	# suggested in below issue of i3
	# https://github.com/i3/i3/issues/3845
}
function cor() {
	i3-msg "exec --no-startup-id code -r $1"
}

# Enable case-insensitive approach when doing tab complete in bash: src: https://askubuntu.com/a/1081444/702911
bind "set completion-ignore-case on"

# Disable keyboard clit (fix the autolcicking issue when typing on keyboard):
alias disableKeyboardClit='xinput -set-prop "DELL08B8:00 0488:121F Mouse" "Device Enabled" 0'
# Disable trackpad (in favor of using external mouse)
alias disableTrackpad='xinput -set-prop "DELL08B8:00 0488:121F Touchpad" "Device Enabled" 0'

function enableAllTrackpadAndKeyboardClit() {
	echo
	# echo Please get a habit of using the external mouse only. It would be much better.
	echo
	xinput -set-prop "DELL08B8:00 0488:121F Mouse" "Device Enabled" 1
	xinput -set-prop "DELL08B8:00 0488:121F Touchpad" "Device Enabled" 1
	echo Please disable this ASAP because using trackpad is not good for health. LOL!!
}

function disableAllTrackpadAndKeyboardClit() {
	xinput -set-prop "DELL08B8:00 0488:121F Mouse" "Device Enabled" 0
	xinput -set-prop "DELL08B8:00 0488:121F Touchpad" "Device Enabled" 0
}

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

PATH=~/.console-ninja/.bin:$PATH
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# deno
export DENO_INSTALL="/home/array/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

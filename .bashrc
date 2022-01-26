#
# ~/.bashrc, `realpath .bashrc` ouputs `/home/array/.bashrc`.
#sahil: `rc` as suffix of .bashrc file name means `run commands`.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# I have sourced this file in root shell's .bashrc file as well i.e., `/root/.bashrc` ~Sahil. And that file is invoked when we login to root user i.e., `su`. It'll load all your aliases and functions in root shell as well that you enjoy in your non-root shells.

### Variables
# Original from archos.
# PS1='[\u@\h \W]\$ ' 
# ~Sahil: For colouring the username and hostname in cli: Source: https://askubuntu.com/a/123306/702911 (simply direct copy paste)
PS1='\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
_home=/home/array # Did coz I'll source this file in sudo as well.
export PATH=$PATH:~/.local/bin
export EDITOR=/usr/bin/nvim
export HISTSIZE=5000000 	# Increasing the history saving capacity to 50 lakhs.
export HISTFILESIZE=5000000	# Increasing the history saving capacity to 50 lakhs. Source: https://www.redhat.com/sysadmin/history-command
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll:history:c"
#^^^^^^ Src: https://github.com/jonhoo/configs/blob/master/shell/.bashrc
#force_color_prompt=yes


### Aliases:
alias ls='ls --color=auto'
alias inw='inotifywait'
alias dc='docker-compose'
alias l='ls'
alias c='clear'
alias e='exit'
alias C='clear'
alias sus='systemctl suspend'
alias hib='systemctl hibernate'
alias md='mkdir'
alias rd='rmdir'
alias wifi='nmtui'
alias lsmnt='ls /mnt/*'
alias rmrf='rm -rf'
alias ..='cd ..'
alias ...='source $_home/.bashrc'
alias gr='cd $_home/Documents/github_repos'
alias grpg='cd $_home/Documents/github_repos/docker-pgadmin4'
alias gra='cd $_home/Documents/github_repos/arch_os'
alias grr='cd $_home/Documents/github_repos/learning_rust/programming-rust-by-example'
alias ~='cd ~'
alias mb='cd /mnt/sda3/home/array/my_bin'
alias cdreact-fetch2='cd /mnt/sda5/githubrepos/npmjs_packages/react-fetch2'
alias vi='nvim'
# Since vi is aliased, all below will refer to nvim for vi.
alias vi.bashrc='vi $_home/.bashrc'
alias vi.profile='vi $_home/.profile'
alias vi.fstab='sudo vi /etc/fstab'
alias vi.pomodoro='vi $_home/scripts-in-use/pomodoro/pomodoro.sh'
alias vi.i3old='vi /mnt/sda3/home/array/.config/i3/config'
alias vi.i3='vi $_home/.config/i3/config'
alias vi.archos_notes='vi /home/array/Documents/github_repos/arch_os/archos_notes_sahil.txt'
alias mountPortableDrive='sudo mount /dev/sdc2 /mnt/sdc2'
alias umountPortableDrive='sudo umount /dev/sdc2'
alias rxmodmap='setxkbmap -layout us' #src: https://askubuntu.com/a/29609
alias cw='cargo watch -q -c -x "run -q"'
#cargo watch --quiet --clear --exec 'run --quiet'
alias co='code .'
alias s='npm start'
alias nr='npm run'
alias myip='ip address show'
alias nm='nodemon'
alias nrd='npm run dev'
alias pomodoro='/home/array/scripts-in-use/pomodoro/pomodoro.sh'
alias xrandr.default='xrandr -s 0'
alias jn='jupyter notebook'
alias d='npm run dev'
alias bp='paplay ~/scripts-in-use/beep-sound-8333.wav'
alias open='xdg-open'
alias tmuxsource='tmux source-file ~/.tmux.conf'
alias tmuxkill='pkill tmux' # Use -f to force kill though. Src: https://askubuntu.com/a/868187/702911
# official way of killing tmux: https://www.codegrepper.com/code-examples/shell/kill+all+tmux+sessions



### Sources:
. $_home/functions_bash_sahil.sh
. "$_home/.cargo/env" # From cargo docs: . "$HOME/.cargo/env" 
. /usr/share/nvm/init-nvm.sh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh #Making autojump work!

echo "SYSTEM		: $(uname -a)"
echo "HOSTNAME	: $HOSTNAME"
echo "UPTIME		: $(uptime)"
echo "DISK		: $(df /home/array | tail -1)"
echo "HOSTNAMECTL	:"
hostnamectl
echo

# Running tmux as default shell: Source: https://unix.stackexchange.com/a/113768/504112
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	  exec tmux
	  # Config file @ ~/.tmux.conf
fi

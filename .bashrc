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
#force_color_prompt=yes

### Sources:
. $_home/functions_bash_sahil.sh
. "$_home/.cargo/env" # From cargo docs: . "$HOME/.cargo/env" 
. /usr/share/nvm/init-nvm.sh


### Aliases:
alias ls='ls --color=auto'
alias l='ls'
alias vi='vim'
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
alias cw='cargo watch -x run'
alias co='code .'
alias s='npm start'
alias nr='npm run'
alias myip='ip address show'
alias nm='nodemon'
alias nrd='npm run dev'
alias pomodoro='/home/array/scripts-in-use/pomodoro/pomodoro.sh'
alias xrandr.default='xrandr -s 0'
alias jn='jupyter notebook'

#
# ~/.bashrc, `realpath .bashrc` ouputs `/home/array/.bashrc`.
#sahil: `rc` as suffix of .bashrc file name means `run commands`.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# I have sourced this file in root shell's .bashrc file as well i.e., `/root/.bashrc` ~Sahil. And that file is invoked when we login to root user i.e., `su`. It'll load all your aliases and functions in root shell as well that you enjoy in your non-root shells.

### Variables
PS1='[\u@\h \W]\$ '
_home=/home/array # Did coz I'll source this file in sudo as well.


### Sources:
. $_home/functions_bash_sahil.sh
. "$_home/.cargo/env" # From cargo docs: . "$HOME/.cargo/env" 
. /usr/share/nvm/init-nvm.sh


### Aliases:
alias ls='ls --color=auto'
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
alias grr='cd $_home/Documents/github_repos/learning_rust/programming-rust-by-example'
alias ~='cd ~'
alias vi.bashrc='vi $_home/.bashrc'
alias vi.i3old='vi /mnt/sda3/home/array/.config/i3/config'
alias vi.i3='vi $_home/.config/i3/config'
alias vi.archos_notes='vi /home/array/Documents/github_repos/arch_os/archos_notes_sahil.txt'
alias mountPortableDrive='sudo mount /dev/sdc2 /mnt/sdc2'
alias umountPortableDrive='sudo umount /dev/sdc2'
alias rxmodmap='setxkbmap -layout us' #src: https://askubuntu.com/a/29609
alias cw='cargo watch -x run'
alias co='code .'
alias s='npm start'

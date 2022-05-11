### Aliases:

alias p3='python3'
# shopt -s expand_aliases

##### THIS ALIAS IS HELPFUL TO MAKE OTHER ALIASES ACCESSIBLE VIA SUDO TOO, YIKES.
# alias sudo='sudo '


# alias yi='yarn init -y && create.gitignore && create.prettierrc.yaml'
# alias ni='npm init -y && create.gitignore && create.prettierrc.yaml'
# Refer ~/.gitconfig for understanding `git hubCreate`


#SHOW SIZES OF DRIVES IN gigabytes
alias df='df -BG'

alias loginasroot='sudo -i'
# source: Diff b/w su and sudo: https://tinyurl.com/ybdz9n9y
alias pretty='prettier --write'
# Usage: pretty myFile

# ------------------------ >>>> cloud aliases >>>>> --------------
alias watchFluxLogs='flux logs -f'
# ---
# manual yaml checking
yqDeploymentContainerNames() {
	echo .spec.template.spec.containers[].name
	yq .spec.template.spec.containers[].name $@


	echo .spec.selector.matchLabels.app
	yq .spec.selector.matchLabels.app $@
	
	echo .spec.template.spec.volumes[].name
	yq .spec.template.spec.containers[].name $@

	echo .spec.template.spec.volumes[].persistentVolumeClaim.claimName
	yq .spec.template.spec.volumes[].persistentVolumeClaim.claimName $@
}
# Usage: yq .spec.template.spec.containers[].name deployment-persistent.yaml

# ---
alias kns='kubens'

alias bz='booz'
alias bzc='clear; booz'
alias mc='vi $_home/scripts/td/must-can'

alias kc='kubectl'
# ---
alias ka='kc apply -f'
alias kam='kc apply -f manifests/'

alias kd='kc delete -f'
alias kdm='kc delete -f manifests/'
alias kdel='kc delete'

# src: https://stackoverflow.com/a/55914480 (Msc. Paskula did recommended this to pull the same image tag again, yikes!!). So this helps to avoid killing deployment and applying it again. Yikes!!
alias krd='kc rollout restart deploy'
alias krs='kc rollout restart statefulset'
# ---
kr(){
	####  hack to restart, :LOL:
	# FYI: YOU should ideally use, krd or krs aliases to redeploy the same image tag so as to pull that.
	# This is also ^^^ also a production best practises to roll a image with same tag so the till the new deployment is the older deployment is still up. Thanks to `readinessProbe` feature via the READY flag, yikes!
	kd $@
	ka $@
}
krm(){
	kdm $@
	kam $@
}

alias kResetCluster='k3d cluster delete; k3d cluster create --port 8082:30080@agent:0 -p 8081:80@loadbalancer --agents 2; docker exec k3d-k3s-default-agent-0 mkdir -p /tmp/kube'

alias pd='kc get po,deploy'
alias pds='kc get po,deploy,svc'
alias pdsi='kc get po,deploy,svc,ing'
alias pdsic='kc get po,deploy,svc,ing,ingressclass'
alias kcwatch='watch kc get all'
# FYI: kc get deploy,po --watch # >>  throws error i.e., `error: you may only specify a single resource type`

alias keinfo='echo -e "You can use -n option to point to specific container i.e.,\nkc exec -it my-pod -c containerName -- sh"'
alias ke='kc exec -it'
kes(){
	if [[ -z "$2" ]]; then
		# kes is autocompleted with my custom made autocompletion script.
		echo +kc exec -it $1 -- sh
		kc exec -it $1 -- sh
	else
		echo +kc exec -it $1 -c $2 -- sh
		kc exec -it $1 -c $2 -- sh
	fi
}

alias kgp='kc get po'
alias kl='kc logs -f'

# port-forward
alias kp='kc port-forward'
# syntax:`kp POD_NAME port` or `kp POD_NAME hostPort:containerPort`.

### PROMETHEUS
# NOTE: PREFER prometheus from prometheus-stack coz fso uses same iteration for its course so its easy to reference from there at any time.
prometheusPod=$(kubectl -n prometheus get po 2> /dev/null | grep prometheus-0 | awk '{print $1}')
# I am calling it managed coz I get the prometheusPod name dynamically, yikes!
alias startPrometheusManaged="kp -n prometheus $prometheusPod 9090"
# fyi: lens-metrics namespace is managed by lens and is created at the time when you chose ot install prometheus from lens itself.
alias startPrometheusFromLensMetrics="kp -n lens-metrics prometheus-0 9090"
### NATS
alias startNats='kp my-nats-0 7777'
### GRAFANA
# STATIC: alias startGrafana='kubectl -n prometheus port-forward kube-prometheus-stack-1648576649-grafana-6c4c68c495-6n4m8 3000'
alias startGrafana="kubectl -n prometheus port-forward $(kubectl -n prometheus get po 2> /dev/null | grep grafana | awk '{print $1}') 3000"
# default login credentials: admin:prom-operator
# 
### 
#  To get the image used by the deployment.
# Usage: `kds my-deployment-name | grep Image`
alias kds='kubectl describe deployment'
alias kge='kubectl get events'
alias ken='ke -n default my-nats-box-d6bd784b-txccl -- sh -l'
# Auto complete any alias now: src: https://github.com/sahilrajput03/sahilrajput03/blob/master/arch-notes.md#autocomplete-any-alias-now

# Since complete is throwing errors when this file in sourced, I am using condition check to disable them in zsh:
# echo $0 => bash, or zsh depending upon the version.
# https://unix.stackexchange.com/a/3647/504112

autoCompleteScripts(){
	complete -F _complete_alias ke
	complete -F _complete_alias kgp
	complete -F _complete_alias kl
	complete -F _complete_alias kp
	complete -F _complete_alias kds
	complete -F _complete_alias kge
	complete -F _complete_alias kdel
	complete -F _complete_alias krd
	complete -F _complete_alias krs

	# My custom made autocomplete script
	# complete -W "$(kc get po | tail -n+2 | awk '{print $1}')" kes
	# ^^ this is actually faulty coz it doesn't fetch pods dynamically but caches at the time of start of the bash session.
	# source /home/array/Documents/github_repos/config/autocomplte-tut/eg-kes-dynamic/kesCompletion.sh
	source /home/array/scripts/autocomplte-tut/eg-kes-dynamic/kesCompletion.sh
}

# Debug only:
# echo $0
if  [[ $0 = bash ]] || [[ $0 = -bash ]] ; then
	# The reason i am using bash and -bash text coz when the terminal is fist launched it is launched with -bash but if you run `exec bash` then $0 becomes simply bash, idk why though.
	# Learn bash: https://sahilrajput03.ml/learn-bash.html
	autoCompleteScripts
fi

alias dk='docker'
# ^^^ newly added, on testing...
# ------------------------ ^^^^ cloud aliases ^^^ --------------

# Get rid of all sideeffects in current shell (i.e, any aliases, any sourced files, etc):
# src: https://stackoverflow.com/a/8760728/10012446
alias fresh='exec bash'
alias vi.hosts='sudo nvim /etc/hosts'
alias vi.git='nvim ~/.bash_git'
alias h='history'
# Reload history from $HISTFILE, i.e., `hr` will load all the commands that were made by all other shells running/closed at current moment: FYI: See `history --help`
alias hr='history -r'
alias lcat='lolcat'
# Make watch command to recognise all aliases:
# src: https://unix.stackexchange.com/a/25329/504112
alias watch='watch '

# ----------- kvm  ------------
# ----------- qemu ------------
# TAGS: #libvirt, #kvm, #qemu
alias virsh='sudo virsh'

alias startUbuntu='virsh start ubuntu20.04'
alias startDebian='virsh start debian11'

alias shutdownDebian='virsh shutdown debian11'
alias shutdownUbuntu='virsh shutdown ubuntu20.04'

alias virtManager='sudo virt-manager'
# ssh to my machines (using ssh profiles)
alias sshDeb='ssh deb'
alias sshUbu='ssh ubu'
kvminfo(){
	type virtManager

	type startUbuntu
	type startDebian

	type shutdownDebian
	type shutdownUbuntu

	type sshDeb
	type sshUbu
}
#----------------------------
#----------------------------

alias vi.aliases='vi ~/.bash_aliases'
alias vi.tmux='vi $_home/.tmux.conf'
alias sha='sha1sum'
# Usage: use y for overwrite and n for not do it.
alias mv='mv -i'
alias cp='cp -i'
# I accidentally important files :( once, so its important to use -i for me now on!
# This allows me know whenever I am accidentally overwriting any existing file, so it'll prompt me before actually doing that. Yo! ~ Missing semester!
alias visudo='sudo EDITOR=nvim visudo'
# FYI: Use exa instead of l and ls.
alias tree='tree -I node_modules'
alias explorer='pcmanfm'
alias fm='air pcmanfm'

# CLIPBOARD HACKS
alias copyFileToClipboard='xclip -sel clip'
alias pasteFromClipboard='xsel'
alias pasteFromClipboard2='xclip -o'
alias paste_png_image='xclip -selection clipboard -t image/png -o > "image-$(date +%c).png"'
# Source: https://unix.stackexchange.com/a/145134/504112

####NERDY##NOTES####	COPY TO CLIPBOARD WITH: 
######### WAY 0 (via piping)	######
# echo SomeText | xclip -sel clip
######### WAY 1
# xclip pathToFile				######
######### WAY 2					######
# xclip -sel clip pathToFile 
# WAY2: With Way2 be able to paste via ctrl+shift+v and right-click context
# menus as well, src: https://opensource.com/article/19/7/xclip

alias open-pdf='llpp'
alias l='exa -lh' # ^^ -h is for showing column headers in the long listing format. Source: https://stackoverflow.com/a/46471147/10012446
alias lsa='ls -a'
alias ls='exa --color=auto'
alias inw='inotifywait'
alias dc='docker-compose'
alias e='exit'
# alias q='exit' # This isn't any good IMO ~Sahil
alias ca='cargo'
# alias r='ranger'
# coz i need to use r for r language now.
alias sus='systemctl suspend'
alias hib='systemctl hibernate'
alias md='mkdir'
alias rd='rmdir'
alias wifi='nmtui'
alias lsmnt='ls /mnt/*'
alias rmrf='rm -rf'
alias ..='cd ..'
alias up='cd ..'
# alias ...='source $_home/.bashrc'
alias ...='exec bash'
# alias ...c='exec bash'
alias gr='cd $_home/Documents/github_repos'
gr="$_home/Documents/github_repos"
# Usage: echo $gr, ls $gr
alias grpg='cd $_home/Documents/github_repos/docker-pgadmin4'
alias grc='cd $_home/Documents/github_repos/config'
alias grr='cd $_home/Documents/github_repos/learning_rust/programming-rust-by-example'
alias ~='cd ~'
alias cdreact-fetch2='cd /mnt/sda5/githubrepos/npmjs_packages/react-fetch2'
alias resume='cd /mnt/sda3/home/array/my_bin/resume'
alias v='nvim'
alias vi='nvim'
# Load nvim with on config: Source: https://vi.stackexchange.com/a/16981
alias vifresh='vim --clean'
# Since vi is aliased, all below will refer to nvim for vi.
alias visahil='vi -u nvim-sahil/init.vim' #Loading nvim-sahil folder as config folder for testing my original configs.
alias vi.environment='sudo nvim /etc/environment'
alias vi.bashrc='vi $_home/.bashrc'
alias vi.history='vi $_home/.bash_history'
alias vi.functions='vi $_home/.bash_functions'
alias vi.profile='vi $_home/.profile'
alias vi.nvim='vi $_home/nvim/init.vim'
alias vi.thoughts='vi $_home/Documents/github_repos/sahilrajput03/thoughts-principles.md'
alias vi.fstab='sudo vi /etc/fstab'
alias vi.pomodoro='vi $_home/scripts/pomodoro/pomodoro.sh'
alias vi.i3old='vi /mnt/sda3/home/array/.config/i3/config'
alias vi.i3='vi $_home/.config/i3/config'
alias vi.cleanAllSwap='rm ~/.local/share/nvim/swap/*' 
alias vi.qm='vi ~/.config/qutebrowser/quickmarks'
alias mountPortableDrive='sudo mount /dev/sdc2 /mnt/sdc2'
alias umountPortableDrive='sudo umount /dev/sdc2'
alias rxmodmap='setxkbmap -layout us' #src: https://askubuntu.com/a/29609
alias cw='cargo watch -q -c -x "run -q"'
alias cwn='cargo watch -c -x run'
alias ct='cargo watch -c -x test'
#cargo watch --quiet --clear --exec 'run --quiet'
alias co='code .'
alias cor='code -r'
alias s='npm start'
alias nr='npm run'
# autocomplete `nr`
complete -F _complete_alias nr
alias myip='ip address show'
alias nm='nodemon'
# nma: This is useful when you want to use debugger (i.e., runtime code control with vscode).
alias nma='nodemon --inspect'
# nmas: This is useful when you want to use debugger from the very first line of execution (i.e., runtime code control with vscode).
alias nmas='nodemon --inspect-brk'
alias nrd='npm run dev'
alias pomodoro='/home/array/scripts/pomodoro/pomodoro.sh'
alias xrandr.default='xrandr -s 0'
alias jn='jupyter notebook'
alias d='npm run dev'
alias bp='paplay ~/scripts/beep-sound-8333.wav'
alias open='xdg-open'
alias o='xdg-open'
alias tx='tmux'
alias tmuxsource='tmux source-file ~/.tmux.conf'
alias tmuxkill='pkill tmux' # Use -f to force kill though. Src: https://askubuntu.com/a/868187/702911
# official way of killing tmux: https://www.codegrepper.com/code-examples/shell/kill+all+tmux+sessions
alias vi.nvim='vi ~/nvim/init.vim'
alias cl='clear && l'
alias restartadb='sudo adb kill-server; sudo adb start-server'
alias listInstalledPacmanPackages='pacman -Q'
alias kernelname='uname -r'
alias generatesshkeypair='ssh-keygen'
alias nf='neofetch'
# Below aliases helps in searching current directory. -a means to include hidden files as well.
alias lsg='ls -a | grep -i'
alias adbinfo="echo adb push 'pathToHostFile' 'pathToTargetDeviceDirectory'
echo adb shell # To execute shell in mobile.
"
# haven't tried it yet though!
adbPush(){
	adb push "$@" /storage/self/primary/DCIM/
}
alias c='clear'
alias C='clear'
if [[ $TMUX ]]; then
	# ^^^^^^ Source: https://stackoverflow.com/a/70177699/10012446
	alias c='clear; tmux clear-history'
	alias C='clear; tmux clear-history'
	alias clear='clear; tmux clear-history'
	# alias clear='clear && tmux clear-history'
fi


# amazing: https://stackoverflow.com/a/43561012/10012446
alias findNodeModules='sudo find . -name 'node_modules' -type d -prune'
alias deleteNestedNodeModules="sudo find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

alias findNextCache="sudo find . -name '.next' -type d -prune"
alias deleteNestedNextCache="sudo find . -name '.next' -type d -prune -exec rm -rf '{}' +"


alias findCache="sudo find . -name '.cache' -type d -prune"
alias deleteNestedCache="sudo find . -name '.cache' -type d -prune -exec rm -rf '{}' +"

# asterisk usage:
alias asteriskrv='sudo asterisk -rvvvv'

alias cat.xmodPossibilities='cat /usr/share/X11/xkb/rules/base.lst'
alias vi.xmod='sudo nvim /etc/X11/xorg.conf.d/00-keyboard.conf'
alias vi.notes='vi /tmp/notes'
alias vi.wi='vi ~/scripts/wi'
alias pw='pwd'
alias cpw='pwd | xclip -sel clip'

# FROM POPOS'S OLD (TO BE RENEWED/RECYCLED)
# alias fishbashrc_vi='vi ~/.config/fish/config.fish'
# alias fishbashrc_cat='cat ~/.config/fish/config.fish'
#
# FYI (FOR FISH): . ~/.config/fish/config.fish

# alias n='run_nautilus' # This does work fine now!!
# alias sp='cd /c/Users/chetan/AppData/Roaming/code/User/snippets/' #vscode snipeets folder for windows :Todo: to bereplaced by linux's path.
#

alias rustbook='rustup doc --book'
# I am not using nano editor for now
# alias backupNanorc='cp ~/.nanorc ~/my_bin/files/.nanorc'

alias sshMyPc='ssh localhost'

# Snippy (Use mod+. to launch snippy anytime, configured with i3)
alias cd.snips='cd ~/Documents/github_repos/config/snips'
alias cd.sr='cd ~/Documents/github_repos/sahilrajput03/'
alias cd.wi='cd ~/Documents/github_repos/sahilrajput03/wi/'
alias cd.config='~/Documents/github_repos/config'
alias cd.flash='cd /home/array/Documents/github_repos/flash'
alias cd.my_bin='cd /mnt/sda3/home/array/i-backup-popos/my_bin'
alias cd.portableHardDisk='cd /mnt/sdc2'


# Setup second display
alias setupSecondDisplay="xrandr --output HDMI1 --auto --left-of eDP1"

alias sc='sudo systemctl'
complete -F _complete_alias sc

alias vi.chan_mobile='sudo nvim /etc/asterisk/chan_mobile.conf'

# src: https://stackoverflow.com/a/2990533/10012446
echoerr() { echo "$@" 1>&2; }

# Generate ssl certificate
alias certbotGenerate='sudo certbot certonly --standalone'

alias vi.ssh='vi ~/.ssh/config'

alias cra='npx create-react-app'
# Usage: `cra my-react-app`
## FYI: If above command fails then try executing `sudo npm i -g create-react-app` first (it solved my issue~Sahil). Src: https://stackoverflow.com/a/55566960/10012446

alias cna='npx create-next-app@latest'
alias cna_with_typescript='npx create-next-app@latest --ts'

##### Jest ####
alias t='npm run test --'
alias tw='npm run test:watch --'
alias twa='npm run test:watchAll --'

# For debugging
alias twd='npm run test:watch:debug --'

alias ni='npm init -y'

alias diskUsage='df -h'

alias zipalign=/opt/android-sdk/build-tools/29.0.3/zipalign
alias apksigner=/opt/android-sdk/build-tools/29.0.3/apksigner

alias adb.log='adb logcat | grep -e OriginVerifier -e digital_asset_links'


alias playRawFile='ffplay -f s16le -ar 44.1k -ac 1'
# Usage: playRawFile myFile.raw


# FYI; This is not directly usage though:
function clearnTmuxHistoryOfActivePane () {
	 tmux clear-history -t $(tmux display -pt "${TMUX_PANE:?}" "#{pane_index}")
		# for implementation usage: checkout: 
	# src: https://unix.stackexchange.com/a/212315/504112
	# and got help from `man tmux` directly for `clear-history` option to have pane parameter using `-t` flag, yo!
 }


# amazing
alias watchSystemDService='journalctl -fu'
# Usage: watchSystemDService lemon

# Usage(using bare ls command): You may add -l flag to get long list format as well.
# alias lsAccessed='\ls -t'

# Using exa (although ls is aliased as exa)
# Usage: ls- -l  to list in long format:
alias ls-='exa --sort modified --across -r'
# -r means reverse order, to see more options of sorting use: `exa --sort` command


#### Clear cace of pacman
## Cleared 10G of disk space for my usage of less than 6 months ~ 10 May, 2022. ~ Sahil
alias removeAllPacmanCache='sudo pacman -Sc'

## Clear user cache
alias removeUserCache='rm -rf ~/.cache/*'

# SRC: https://averagelinuxuser.com/clean-arch-linux/#8-clean-systemd-journal
## Limit journalctl logs size: ``
alias getJournalctlLogsSize='journalctl --disk-usage'
alias cleanAndKeepLatestJournalctlLogs='sudo journalctl --vacuum-size=50M'
alias cleanAndKeepLast4WeeksLogs='sudo journalctl --vacuum-time=4weeks'
### LEARN: HEYYY, I don't need to above to clean logs manually coz I have set limit of logs in file conf file of journalctl daemon. Src: https://averagelinuxuser.com/clean-arch-linux/#8-clean-systemd-journal
# sudo nvim /etc/systemd/journald.conf; and putting below line in it!!
# ADD BELOW LINE TO THE FILE.
# SystemMaxUse=50M


# Sizes of currently used in /home disk: (check via `diskUsage` alias to `du h`)
# 1.8G    blulabs
# 15G     Documents
# 58G     Downloads

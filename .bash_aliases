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
alias r='reset'
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

alias sha='sha1sum'
# Usage: use y for overwrite and n for not do it.
alias mv='mv -i'
alias cp='cp -i'
# I accidentally important files :( once, so its important to use -i for me now on!
# This allows me know whenever I am accidentally overwriting any existing file, so it'll prompt me before actually doing that. Yo! ~ Missing semester!
alias visudo='sudo EDITOR=nvim visudo'
alias tree='tree -I node_modules'
alias explorer='pcmanfm'
alias fm='air pcmanfm'

# CLIPBOARD HACKS
alias copyFileToClipboard='xclip -sel clip'
alias pasteFromClipboard='xsel'
alias pasteFromClipboard2='xclip -o'

# ppng stands for Paste PNG
alias ppng_image='xclip -selection clipboard -t image/png -o > "image-$(date +%c).png"'

# USAGE: ppng_image0 ss/ss-address-looks-like
function ppng_image0() {
	xclip -selection clipboard -t image/png -o > "$1.png"
}
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

# ls
# FYI: Use exa instead of l and ls.
alias l='exa -lh' # ^^ -h is for showing column headers in the long listing format. Source: https://stackoverflow.com/a/46471147/10012446
alias ls='exa --color=auto'
alias lsa='ls -a'
alias lsmnt='ls /mnt/*'
alias lsg='ls -a | grep -i'
##### USAGE (using bare ls command): You may add -l flag to get long list format as well. # alias lsAccessed='\ls -t'
##### Using exa (although ls is aliased as exa)
# USAGE: ls- -l  to list in long format:
alias ls-='exa --sort modified --across -r'
# -r means reverse order, to see more options of sorting use: `exa --sort` command

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
alias rmrf='rm -rf'
alias ..='cd ..'
alias up='cd ..'
# alias ...='source $_home/.bashrc'
alias ...='exec bash'
alias cd.gr='cd $_home/Documents/github_repos'
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

# LEARN: Since vi is aliased, all below will refer to nvim for vi.
alias vi.aliases='vi ~/.bash_aliases'
alias vi.bashrc='vi $_home/.bashrc'
alias vi.chan_mobile='sudo nvim /etc/asterisk/chan_mobile.conf'
alias vi.cleanAllSwap='rm ~/.local/share/nvim/swap/*'
alias vi.docker='vi $_home/.bash_docker'
alias vi.environment='sudo nvim /etc/environment'
alias vi.fstab='sudo vi /etc/fstab'
alias vi.functions='vi $_home/.bash_functions'
alias vi.git='nvim ~/.bash_git'
alias vi.history='vi $_home/.bash_history'
alias vi.hosts='sudo nvim /etc/hosts'
alias vi.i3old='vi /mnt/sda3/home/array/.config/i3/config'
alias vi.i3='vi $_home/.config/i3/config'
alias vi.notes='vi /tmp/notes'
alias vi.nvimsahil='vi -u nvim-sahil/init.vim' #Loading nvim-sahil folder as config folder for testing my original configs.
alias vi.nvim='vi $_home/nvim/init.vim'
alias vi.pomodoro='vi $_home/scripts/pomodoro/pomodoro.sh'
alias vi.profile='vi $_home/.profile'
alias vi.qm='vi ~/.config/qutebrowser/quickmarks'
alias vi.ssh='vi ~/.ssh/config'
alias vi.thoughts='vi $_home/Documents/github_repos/sahilrajput03/thoughts-principles.md'
alias vi.tmux='vi $_home/.tmux.conf'
alias vi.wi='vi ~/scripts/wi'
# Customize windows transparency and radius
alias vi.picom='sudo vim /etc/xdg/picom.conf'
# Customizing the system notification
# Tip: Use restart.dunst to reload dunstrc file and use win+g to send a test notification.
alias vi.dunst='vi .config/dunst/dunstrc'
alias vi.python='vi ~/.bash_python'
alias vi.heroku='vi ~/.bash_heroku'
alias vi.ranger='vi ~/ranger/rifle.conf'
alias mt='mutt'

# https://github.com/dunst-project/dunst/issues/63#issuecomment-35873908
alias restart.dunst='killall dunst'

alias mountPortableDrive='sudo mount /dev/sdc2 /mnt/sdc2'
alias umountPortableDrive='sudo umount /dev/sdc2'
alias rxmodmap='setxkbmap -layout us' #src: https://askubuntu.com/a/29609
alias cw='cargo watch -q -c -x "run -q"'
alias cwn='cargo watch -c -x run'
alias ct='cargo watch -c -x test'
#cargo watch --quiet --clear --exec 'run --quiet'

# Fixed the long time vscode inconsistent settings issue, ~ Sahil
# user-data-dir has to be by default ~/.cofig/Code but for some reasong when i launch from cli vscode assumes ~/Code which causes inconsistency i.e., saving multiple settings at different files, FYI: When i launch `code` from dmenu it launches with its settings as ~/.config/Code folder only.
# alias code="code --user-data-dir=/home/array/.config/Code/"
# alias co='code .'
# alias cor='code . -r'

# Fix the opening of web links in chrome window instead of opening new window of google-chrome it now opens currently running windows. (Time took: 3.5 hours). Src: https://stackoverflow.com/a/50736123/10012446
alias code='i3-msg "exec --no-startup-id code"'
function co(){
	i3-msg "exec --no-startup-id code $PWD"
	# If above throws error then simply use `tmuxkill` to kill the tmux session to fix the error as suggested in below issue of i3
	# https://github.com/i3/i3/issues/3845
}
function cor(){
	i3-msg "exec --no-startup-id code $PWD -r"
}

# alias co='echo Please use dmenu to open vscode'
# alias cor='echo Please use demnu to open vscode and files'

function s () {
	if [ -f package.json ]; then
		npm start
	else
		echo Nothing to do here.
	fi
}
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
alias cl='clear && l'
alias kernelname='uname -r'
alias generatesshkeypair='ssh-keygen'
alias nf='neofetch'
# Below aliases helps in searching current directory. -a means to include hidden files as well.
adbInfo(){
	echo Some adb commands and aliases ~Sahil
	echo adb push 'pathToHostFile' 'pathToTargetDeviceDirectory'
	echo adb shell # To execute shell in mobile.
	echo adb.restart # Fix error of "no permission" issue in `adb devices` command.
	echo adb.devices # Get Devices
	echo adbDebug # 
}
alias adb.restart='sudo adb kill-server; sudo adb start-server'
alias adb.devices='adb devices'

adbPush(){
	adb push "$@" /storage/self/primary/DCIM/
}
# Debug over air. LEARN: You would need to install Wifi ADB from playstore to connect to device probably ~Sahil
adbDebug='adb connect 192.168.18.4:5555'
alias c='clear'
alias C='clear'
if [[ $TMUX ]]; then
	# ^^^^^^ Source: https://stackoverflow.com/a/70177699/10012446
	alias c='clear; tmux clear-history'
	alias C='clear; tmux clear-history'
	alias clear='clear; tmux clear-history'
	# alias clear='clear && tmux clear-history'
fi


# IMAGES
alias findImages="find . -regextype egrep -regex '(.)+\.(jpg|jpeg|png)'"
alias deleteNestedImages="find . -regextype egrep -regex '(.)+\.(jpg|jpeg|png)' -exec rm {} +"
# src: https://stackoverflow.com/a/6845117

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
alias cd.additionalPath='cd ~/Documents/github_repos/additionalPath/'
alias cd.test='cd ~/test'
alias cd.backgrounds='/usr/share/backgrounds/archlinux'
alias cd.obsRecorded='cd /mnt/sda2/obs-recorded/'
alias cd.macos='cd /Documents/macOS-Simple-KVM'
alias cd.rootDocuments='/Documents/'
alias cd.6figure='/mnt/sda2/COURSES_COURSES_COURSES/BLOCKCHAIN-6-figures-blockchain-developer/10-99'
alias cd.6figurecode='/home/array/test/dapp-6fig-eattheblocks/'

# Setup second display
alias setupSecondDisplay="xrandr --output HDMI1 --auto --left-of eDP1"

alias sc='sudo systemctl'
complete -F _complete_alias sc


# src: https://stackoverflow.com/a/2990533/10012446
echoerr() { echo "$@" 1>&2; }

# Generate ssl certificate
alias certbotGenerate='sudo certbot certonly --standalone'


# Usage: `cra my-react-app`
## FYI: If above command fails then try executing `sudo npm i -g create-react-app` first (it solved my issue~Sahil). Src: https://stackoverflow.com/a/55566960/10012446
# Favouring typescript over javascript from now on:
# alias cna='npx create-next-app@latest'
# alias cna_with_typescript='npx create-next-app@latest --ts'
alias cna='npx create-next-app@latest --ts'
alias cea='npx create-expo-app'
# Favouring typescript over javascript from now on:
# alias cra='npx create-react-app@latest'
alias craForce='npx create-react-app my-app --template typescript'
alias cra=cna

alias cnal='cp -r /home/array/test/PROJECT_POPULATED_BOILERS/cna-ts-2022-9-25/'

##### Jest ####
alias t='npm run test --'
alias tw='npm run test-watch --'
alias tw2='npm run test-watch2 --'
alias tw3='npm run test-watch3 --'
alias twa='npm run test-watchAll --'

# For debugging
alias twd='npm run test:watch:debug --'

alias ni='npm init -y'

alias diskUsage='df -h'
# alias diskUsageMain="diskUsage | grep 'sdb[4,3]'"
diskUsageMain() {
	df -h | head -n1
	diskUsage | grep 'sdb[4,3]'
}


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


##### PACMAN #####

alias listInstalledPacmanPackages='pacman -Q'

#### Clear cache of pacman
## Cleared 10G of disk space for my usage of less than 6 months ~ 10 May, 2022. ~ Sahil
alias cleanAllPacmanCache='sudo pacman -Sc'

## Clear user cache
alias cleanUserCache='rm -rf ~/.cache/*'

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

# AWS ec commands: From my old windows's additionalPath repo
alias sshInstance1='ssh -i /e/mysshkeys/aws-instance1-indialife123.pem ubuntu@3.139.35.20'
alias startInstance1='aws ec2 start-instances --instance-ids i-0634f170159defdc4'
alias stopIinstance1='aws ec2 stop-instances --instance-ids i-0634f170159defdc4'

alias showWifiNetworks='nmcli dev wifi'

# Updating ip @ cloudns.net
# LEARN: Updating dns address @ cloudns.net
# wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background https://ipv4.cloudns.net/api/dynamicURL/?q=MzE2MTk0ODoyMjUxMzk2MTI6MDcwNTZkNDViNjE2MmZmOTY5ZTE5YWViYjY0YmRlMDJhMzg4NzBhYjFlOTRlODA0ZjUyMWQxZDBjZjBkZGFkNQ -O /c/tempLogs/1.txt
# wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background https://ipv4.cloudns.net/api/dynamicURL/?q=MzE2MTk0ODoyMjUxMzk2MjI6OTY4MWQyMTRmMzY1NWI4YmFjZTJmMTNjYTA1NWI3ZDQ3ZTNjM2U4YTI4ZTgwNWNiMjVhMTQyYWYzNzFkMmIyZg -O /c/tempLogs/2.txt


alias yd='youtube-dl'
alias yp='yarn pub'
alias ys='yarn --silent start'

alias npmls='npm ls -g --depth 0'
alias nodeNoWarning='node.exe --no-warnings %*'
alias esm='node -r esm $*'
alias getNodePathPrefix='npm config get prefix'


# file paths to be fixed
alias createNodemon.json='cp /c/additionalPath/nodemon.json .'
alias create.gitignore='cp /c/additionalPath/.gitignore .'
alias create.prettierrc.yaml='cp /c/additionalPath/.prettierrc.yaml .'
alias eslintfix='echo SKIP_PREFLIGHT_CHECK=true >> .env'

alias fg='figlet'
# Usage: fg I am sahil

alias simpleTerminal='st'

# Check for graphics card drivers, src: https://bbs.archlinux.org/viewtopic.php?id=136535
# and search for `amd` in the output:
alias checkGraphicsCard='lspci -v'

alias UE4Editor='air ~/Documents/UnrealEngine-4.23.1-release/Engine/Binaries/Linux/UE4Editor'

# bluetoothctl
alias blc='bluetoothctl'
# CONNECT TO MY AIRDOPES 441 PRO
# Try connecting one time:
alias blco='blc connect 00:00:AB:CE:16:01'
alias blcd='blc disconnect'
alias blcr='blcd; blcc'

# Try connecting until connected
blcc () {
	# src: https://stackoverflow.com/a/21982743
	until blco ;
	do
		echo
		echo TRYING AGAIN...
		sleep 1 #Intented to give a time-break
	done
}

alias restartVsftpd='systemctl restart vsftpd.service'
alias vi.vsftpd='sudo nvim /etc/vsftpd.conf'

alias handbrake='ghb'

alias flameshot=/home/array/binaries/Flameshot-12.0.rc1.x86_64.AppImage

# alias pd='parcel index.html --open'
alias pd='parcel index.html'

# src: https://www.cyberciti.biz/faq/linux-get-number-of-cpus-core-command/
# nproc --all (gives same input as `nproc` though in my case)
alias getNumberOfCores='nproc'


alias network_speed_live='vnstat --live'

alias startMacos='cd /Documents/macOS-Simple-KVM; sudo ./basic.sh'

alias ls.kvmImages='ls /var/lib/libvirt/images'
alias cd.kvmImages='cd /var/lib/libvirt/images'
alias so.kvmImages='so /var/lib/libvirt/images'

# alias vi.grub='vi /etc/default/grub'
# alias cat.kernelParams='cat /proc/cmdline'

vi.grub () {
	echo +vi /etc/default/grub
	vi /etc/default/grub
}

cat.kernelParams () {
	echo +cat /proc/cmdline 
	cat /proc/cmdline
}

lspci.vgaAudio() {
	echo '+lspci -nn | grep "VGA\|Audio"'
	lspci -nn | grep "VGA\|Audio"
}

# Source: https://wiki.archlinux.org/title/laptop
battery-status(){
	acpi -b | awk -F'[,:%]' '{print $2, $3}'
}


# src: https://www.freecodecamp.org/news/how-to-set-up-the-debugger-for-chrome-extension-in-visual-studio-code-c0b3e5937c01/
# Very useful to debug react apps coz we can use `Chrome:Attach` debug configuration to open debug in this window only instead of creating new chrome debugging windows on each debug session start from vscode. Yikes!! Also documented on `learn-react` github repo as well.
alias chrome-debug='air google-chrome-stable --remote-debugging-port=9222'


function startApiTesting(){
	while true; do
		# echo -e "\nRequest @ "; date +"%r";
		# Not possible to print time bcoz `date` cli is taking time so subsequent requests in next few milliseconds are dropped off.
		echo -e "HTTP/1.1 200 OK\n" | nc -Nl 8005; echo -e "\n---";
	done
}

# Shows full program and the path of the program
alias pgrep-a='pgrep -a'


# USAGE: live-server --port=3001
alias live-server='live-server --no-browser'

alias cd.jimmy_chae='cd ~/Documents/jimmy-chae/'

alias fes='firebase emulators:start'
alias fesf='firebase emulators:start --only firestore'

alias pgrep='pgrep -a'

alias ngrokinfo='echo ngrok http PORT_HERE'

alias twc='nr test-watch-compiler'

forgetfulApps(){
	echo "mpv for playing video, awesome!, alias mp"
	echo "qbittorrent for using torrent"
	echo "pacmanfm for gui filemanager, alias fm"
	echo "ranger for cli filemanager, alias rr"
	echo "sxiv - image viewer, alias sx"
	echo "feh - image viewer, alias fe"
	echo
	# src: https://github.com/xournalpp/xournalpp/
	# stackoverflow ans: https://askubuntu.com/a/1288079/702911
	echo "xournal - pdf - amazing annotater, alias xo"
	echo "llpp - pdf viewer, alias llp"
	echo "mupdf - pdf viewer, alias mu"
}


alias rr=ranger
alias sx=sxiv
alias fe=feh
alias llp=llpp
alias mu=mupdf
alias xo=xournalpp

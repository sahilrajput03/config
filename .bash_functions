# 
alias bm=bashmon
alias bmon=bashmon

bashmon(){
	nodemon -q -e sh -x "bash $@ || exit 0"
	# nodemon -q -e sh -x "./$@|| exit 0"

	# From popos's OLD:
	# nodemon -q -e sh -x "bash $*"
}

mdcd(){
	mkdir $@
	cd $@
}
# BELOW ALIAS throws error for zsh, that is alias can't refer to functions.
# SO AS A HACK I AM MAKING ANOTHER FUNCTION WHICH CALLS mdcd internally and not it works for both bash and zsh.
# alias mdc='mdcd'
mdc(){
	mdcd "$@"
}

# Watch over fortran program:
# conflict with fm coz I have same alias for filemanager, i.e., pcmanfm
fmon(){
	nodemon -e "f90" -x "gfortran $@ -o binary && ./binary"
}

rmon(){
	rustmon $*
}

rustmon(){
	/usr/bin/nodemon -q -e rs -x "rustc $* -o .binary && ./.binary"
}

alias so='sizeof'
sizeof (){
	echo + du -sh $@
	du -sh "$@"
}

#source: https://unix.stackexchange.com/a/438712
#sahil_notes: I am using this function as in alternate for ```alias sudo='sudo '```.
#and above alias doesn't work good for `sudo myCustomFunction`.
#below function works good enough!

function Sudo {
        local firstArg=$1
        if [ $(type -t $firstArg) = function ]
        then
                shift && command sudo bash -c "$(declare -f $firstArg);$firstArg $*"
        elif [ $(type -t $firstArg) = alias ]
        then
                alias sudo='\sudo '
                eval "sudo $@"
        else
                command sudo "$@"
        fi
}

backup_dir=/home/array/Documents/github_repos/config
_home=/home/array

# Notice the extra s in the backupConfigFiless <- here.
alias backupConfigFiless='backupConfigFiles 1> /dev/null 2> /dev/null'
function backupConfigFiles {
# LEARN: Never append any comment in the alias comment, it would just SUCK!
# so that `-i` flag is removed in here!
	# unlias cp
	# alias cp='/usr/bin/cp'
	# Using \ before cp to disable alias expansion. src: https://www.cyberciti.biz/faq/bash-shell-temporarily-disable-an-alias/

	crontab -l > $backup_dir/Backup_crontab.txt
	echo "Backup of crontab entries succeeded."

	\cp $_home/nodemon.json $backup_dir/
	echo "Backup of ~/nodemon.json succeeded."

	\cp $_home/.bashrc $backup_dir/
	echo "Backup of ~/.bashrc succeeded."

	\cp $_home/.profile $backup_dir/
	echo "Backup of ~/.profile succeeded."

	\cp $_home/.vimrc $backup_dir/
	echo "Backup of ~/.vimrc file succeeded."

	\cp $_home/.bash_profile $backup_dir/
	echo "Backup of ~/.bash_profile succeeded."

	\cp -r $_home/.config/i3 $backup_dir/.config
	echo "Backup of ~/.config/i3 directory succeeded."

	\cp -r $_home/.config/flameshot $backup_dir/.config
	echo "Backup of ~/.config/flameshot/ directory succeeded."

	\cp $_home/.i3status.conf $backup_dir/
	echo "Backup of ~/.i3status.conf file succeeded."

	\cp $_home/.bash_functions $backup_dir/
	echo "Backup of ~/.bash_functions succeeded."

	\cp $_home/.vim_bash_env $backup_dir/
	echo "Backup of ~/.vim_bash_env succeeded."

	\cp -r $_home/scripts $backup_dir/
	echo "Backup of ~/scripts directory succeeded."

	\cp $_home/.tmux.conf $backup_dir/
	echo "Backup of ~/.tmux.conf file succeeded."

	\cp $_home/.zshrc $backup_dir/
	echo "Backup of ~/.zshrc file succeeded."

	# FOR TESTING COMMAND: I.e., for fail incident for the copying of certian items by cp program:
	# cp -r ~/nvim ~/Documents/github_repos/config/ 2> /dev/null
	# \cp -r $_home/nvim $backup_dir/ 2> /dev/null
	# Now to prevent unnecessary copying of plugged folder I am using below tactic: src: https://stackoverflow.com/a/12968671/10012446
	cd ~/nvim # MOVING TO DIRECTORY IS IMPORTANT.
	\cp -r `\ls -A | grep -v "plugged"` $backup_dir/nvim
	echo "Backup of ~/nvim directory succeeded."
	cd - > /dev/null # MOVING BACK ORIGINAL TO DIRECTORY IS IMPORTANT TOO.

	\cp -r $_home/nvim-sahil $backup_dir/
	echo "Backup of ~/nvim-sahil directory succeeded."

	\cp $_home/Code/User/keybindings.json $backup_dir/Code/User/
	echo "Backup of ~/Code/User/keybindings.json file succeeded."

	\cp $_home/Code/User/settings.json $backup_dir/Code/User/
	echo "Backup of ~/Code/User/settings.json file succeeded."

	\cp $_home/.prettierrc.js $backup_dir/
	echo "Backup of ~/.prettierrc.js file succeeded."

	\cp $_home/.gitconfig $backup_dir/
	echo "Backup of ~/.gitconfig file succeeded."

	\cp $_home/.gitignore_global $backup_dir/
	echo "Backup of ~/.gitignore_global file succeeded."

	\cp $_home/.bash_aliases $backup_dir/
	echo "Backup of ~/.bash_aliases file succeeded."

	\cp $_home/.bash_docker $backup_dir/
	echo "Backup of ~/.bash_docker file succeeded."

	\cp $_home/.bash_git $backup_dir/
	echo "Backup of ~/.bash_git file succeeded."

	\cp $_home/.bash_completion $backup_dir/
	echo "Backup of ~/.bash_completion file succeeded."

	\cp /etc/environment $backup_dir/etc/
	echo "Backup of /etc/environment file succeeded."

	\cp $_home/.config/qutebrowser/autoconfig.yml $backup_dir/.config/qutebrowser/
	\cp $_home/.config/qutebrowser/config.py $backup_dir/.config/qutebrowser/
	\cp $_home/.config/qutebrowser/quickmarks $backup_dir/.config/qutebrowser/
	echo "Backup of ~/.qutebrowser/autoconfig.yml file succeeded."
	echo "Backup of ~/.qutebrowser/config.py file succeeded."
	echo "Backup of ~/.qutebrowser/quickmarks file succeeded."

	echo
	grc 			# Navigate to config repository.

	crontab -l > crontab_entries.txt
	gacp Update. 	# Push changes to github.
	cd - 			# Return to previous directory.
}

# Vscode special
alias backupVSCODESettings='\cp ~/Code/User/settings.json ~/Documents/github_repos/config/Code/User/settings.json'
alias backupVSCODESettingsDryDiff='diff ~/Documents/github_repos/config/Code/User/settings.json ~/Code/User/settings.json '

function bkpfstab {
	cp /etc/fstab $backup_dir
}


function cva {
	npm init vite "$@" -- --template react
}

function air {
	nohup "$@" > /dev/null 2>&1 &
}
function killbatteryservice {
	kill $(pgrep -f battery-status)
}

# todo.sh aliases:
function td(){
	# This is fun...
	#What i want is if no arguments passed then it should act as todo.sh ls, but when arguments passed arguments should be passed to todo.sh like todo.sh $argv.
	# if test "$argv" = "" # I did this in fish in popos.
	if [ $# -eq 0 ]
	then
	 todo.sh ls
	# echo "YOU DIDN'T PASS ARGUMENTS ~ SAHIL"
	else
	#Note: You can use ``td -h`` to execute ``todo.sh -h`` as well.
	# echo DEBUGGING::ARGUMETNS PASSED: SAHIL "$@"
	todo.sh "$@"
		#echo "You passed arguments ~ Sahil"
	fi
}

function tda(){
    todo.sh add "$argv"			# Add task
}

function tds(){ 
		 todo.sh ls				# Show tasks
}

function tdsa(){
		 todo.sh listall		# This command show all tasks (incompleted as well as completed):
}

function tdd(){
	# todo.sh do 4				# This_command_will_mark_task4_as_done.
    todo.sh do $argv			# Works same as above command.
}
alias vi.td='vi .todo/todo.txt'

# ColouredEcho
function cecho(){
	# Usage:
	# coloredEcho "This text is green" green
	# coloredEcho "This text is green" 2
	# colouredEcho "This text is yellow" 3
	# colouredEcho "This text is red" 1

    local exp=$1;
    local color=$2;
    if ! [[ $color =~ ^[0-9]$ ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo "$exp";
    tput sgr0;
}

# Exporting ce functions so I can use it in scripts directly.

# Both of below export causes error when imported with zsh.
# export -f cecho 
# export cecho 

alias ce='cecho'
# Src: https://unix.stackexchange.com/a/22867/504112

# Usage
# coloredEcho "This text is green" green

# Much easier way:
# ce "This text is red" 1
# ce "This text is green" 2
# ce "This text is yellow" 3
# ce "This text is blue" 4
# ce "This text is magenta" 5
# ce "This text is cyan" 6
# ce "This text is white" 7
# ce "Default text will be white as well."


# Another searching utility with simple ls
lss(){
	# Below example is when you are searching for file that has text json in it. I have second entry starting with .* so that i can search in dot files as well(hidden files).
	ls -a -d *$@* .*$@*
	# FYI: -a means list all files(including hidden files), -d means to list the content of current directory(not the contentes of directory supplied as argument).
	# Example of searching json in a directory for files and folders.
	# ls -a -d *json* .*json*
	# FYI: This throw error when there are no files matching with dot files, todo: fix that error. ~Sahil.
}

# Enabling colors for grep by default
alias grep='grep --color=auto'

# Search text in files recursively (src: https://github.com/sahilrajput03/sahilrajput03/blob/master/learn-bash.md)
searchTextInFilesRecursively(){
	grep -r --exclude-dir={node_modules,.idea,.git} --exclude={package-lock.json,yarn.lock,yarn-error.log} "$@" .
}


# heroku
# PLEASE SET APP via `heroku_app=my_app`
alias h_createProcfile='echo "web: npm start" > Procfile'
alias ha='heroku apps'
alias hl='heroku logs -a $heroku_app'
alias hlt='heroku logs --tail'
alias hlo='heroku login'
alias hre='heroku releases -a $heroku_app'
alias hro='heroku rollback $@ -a $heroku_app'

hinfo(){
	# src: https://gist.github.com/sahilrajput03/c44778f281e5f9856827e7c0f264ffa5
	type h_createProcfile
	type ha
	type hl
	type hlt
	echo "# USAGE: hro some-version"
	type hlo
	type hre
	type hro
	echo "
# LEARN: To set nodejs as buildpacks for heroku -
heroku buildpacks:set heroku/nodejs
# FYI: You can set this buildpack setting via 'Setings' tab in you heroku panel as well."
}


# .eslintrc.js
create.eslintrc.jsExpressjs () {
	cp ~/Documents/github_repos/config/files/eslint-config-express/.eslintrc.js .
}

create.eslitrc.jsReactjs () {
	cp ~/Documents/github_repos/config/files/eslint-config-react/.eslintrc.js .
}

# jsconfig.json
createJsconfig.json () {
	cp ~/my_bin/files/jsconfig.json .
}

configSearch () {
	# -i option for case insensitive matches
	# -n for show line numbers
	grep -inH "$@" ~/.bashrc
	grep -inH "$@" ~/.bash_aliases
	grep -inH "$@" ~/.bash_git
	grep -inH "$@" ~/.bash_functions
}

cmon () {
	t=${*%??}
	# nodemon -q -e c -x "gcc $* -o binary; ./binary"
	nodemon -q -e c -x "gcc $* -o binary && ./binary || exit 0" # We exit with zero coz we don't want nodemon to stop even when the program throws a non zero return code(i.e., compiler throws exception).
}


pmon () {
	nodemon -q -e py -x "python $*"
	#Usage: pythonmon filename.py
	#Also, you can use `pmon filename.py` as pmon is subscript of pythonmon.
}


listAllUsers () {
	awk -F: '{ print $1}' /etc/passwd | xargs
	# We can't use pipe thing with aliases, so I have to use it as a function only. ~IMO~ Sahil.
}
# LEARN: Here -F is field separator and we set it to :
# LEARN: With xargs we convert multiple line output to a single line output.

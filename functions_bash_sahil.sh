alias bm=bashmon
alias bmon=bashmon

bashmon(){
/usr/bin/nodemon -q -e sh -x "bash $@ || exit 0"
}

mdcd(){
	mkdir $@
	cd $@
}

# Watch over fortran program:
fm(){
	nodemon -e f90 -x "gfortran $@ -o program && ./program"
}

rmon(){
	rustmon $*
}

rustmon(){
	/usr/bin/nodemon -q -e rs -x "rustc $* -o .binary && ./.binary"
}

alias gl='git log --decorate --graph --oneline -10'
# Usage: `garchive myBackupFile.zip main`, src: https://stackoverflow.com/a/55515739/10012446
alias gsh='git show'
alias garchive='git archive --format zip --output'
# alias gl='git log'
gac (){
    echo + git add .
    git add .

    echo + git commit -m \'$@\'
    git commit -m "$*" # gac life is amazing
}

# Usage: gacp life is super amazing. Usage: `gacps Added life to project.`
gacp (){
    echo + git add .
    git add .

    echo + git commit -m \'$@\'
    git commit -m "$*"

    echo + git push -u
    git push -u

}
# gacp Silent: Tested: Works good: Usage: `gacps Added life to project.`
gacps (){
    git add . 1> /dev/null 2> /dev/null
    git commit -m "$*" 1> /dev/null 2> /dev/null
    git push -u 1> /dev/null 2> /dev/null
}

alias so='sizeof'
sizeof (){
    	echo + du -sh $@
	du -sh $@
}

gs (){
	echo + git status
	git status
}
ga (){
	echo + git add .
	git add .
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

function backupConfigFiles {

	cp $_home/nodemon.json $backup_dir/
	echo "Backup of ~/nodemon.json succeeded."

	cp $_home/.bashrc $backup_dir/
	echo "Backup of ~/.bashrc succeeded."

	cp $_home/.profile $backup_dir/
	echo "Backup of ~/.profile succeeded."

	cp $_home/.vimrc $backup_dir/
	echo "Backup of ~/.vimrc file succeeded."

	cp $_home/.bash_profile $backup_dir/
	echo "Backup of ~/.bash_profile succeeded."

	cp $_home/.config/i3/config $backup_dir/.config_i3_config
	echo "Backup of ~/.config/i3/config file succeeded."

	cp $_home/functions_bash_sahil.sh $backup_dir/
	echo "Backup of ~/functions_bash_sahil.sh succeeded."

	cp -r $_home/scripts-in-use $backup_dir/
	echo "Backup of ~/scripts-in-use directory succeeded."

	cp $_home/.tmux.conf $backup_dir/
	echo "Backup of ~/.tmux.conf file succeeded."


	# FOR TESTING COMMAND: I.e., for fail incident for the copying of certian items by cp program:
	# cp -r ~/nvim ~/Documents/github_repos/config/ 2> /dev/null
	cp -r $_home/nvim $backup_dir/ 2> /dev/null
	echo "Backup of ~/nvim directory succeeded."

	cp -r $_home/nvim-sahil $backup_dir/
	echo "Backup of ~/nvim-sahil directory succeeded."

	cp $_home/Code/User/keybindings.json $backup_dir/Code/User/
	echo "Backup of ~/Code/User/keybindings.json file succeeded."

	cp $_home/Code/User/settings.json $backup_dir/Code/User/
	echo "Backup of ~/Code/User/settings.json file succeeded."

	cp $_home/.prettierrc.js $backup_dir/
	echo "Backup of ~/.prettierrc.js file succeeded."

	cp $_home/.gitconfig $backup_dir/
	echo "Backup of ~/.gitconfig file succeeded."

	cp $_home/.config/qutebrowser/autoconfig.yml $backup_dir/.config/qutebrowser/
	cp $_home/.config/qutebrowser/config.py $backup_dir/.config/qutebrowser/
	cp $_home/.config/qutebrowser/quickmarks $backup_dir/.config/qutebrowser/
	echo "Backup of ~/.qutebrowser/autoconfig.yml file succeeded."
	echo "Backup of ~/.qutebrowser/config.py file succeeded."
	echo "Backup of ~/.qutebrowser/quickmarks file succeeded."

	echo
	grc 			# Navigate to config repository.

	crontab -l > crontab_entries.txt
	gacp Update. 	# Push changes to github.
	cd - 			# Return to previous directory.
}

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
export -f cecho 
alias ce='cecho'
# Src: https://unix.stackexchange.com/a/22867/504112

# Usage
# coloredEcho "This text is green" green

# Much easier way:
# echoc "This text is red" 1
# echoc "This text is green" 2
# echoc "This text is yellow" 3
# echoc "This text is blue" 4
# echoc "This text is magenta" 5
# echoc "This text is cyan" 6
# echoc "This text is white" 7
# echoc "Default text will be white as well."



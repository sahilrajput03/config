alias bm=bashmon
alias bmon=bashmon

bashmon(){
/usr/bin/nodemon -q -e sh -x "bash $@"
}

mdcd(){
	mkdir $@
	cd $@
}

rmon(){
	rustmon $*
}

rustmon(){
	/usr/bin/nodemon -q -e rs -x "rustc $* -o .binary && ./.binary"
}

gac (){
    echo + git add .
    git add .

    echo + git commit -m \'$@\'
    git commit -m "$*" # gac life is amazing
}

# Usage: gacp life is super amazing.
gacp (){
    echo + git add .
    git add .

    echo + git commit -m \'$@\'
    git commit -m "$*"

    echo + git push
    git push

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

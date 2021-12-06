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

function sudo {
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

function backupConfigFiles {
	backup_dir=/home/array/Documents/github_repos/arch_os

	cp ~/.bashrc $backup_dir/
	echo "Backup of ~/.bashrc succeeded."

	cp ~/.profile $backup_dir/
	echo "Backup of ~/.profile succeeded."

	cp ~/.vimrc $backup_dir/
	echo "Backup of ~/.vimrc file succeeded."

	cp ~/.bash_profile $backup_dir/
	echo "Backup of ~/.bash_profile succeeded."

	cp ~/.config/i3/config $backup_dir/.config_i3_config
	echo "Backup of ~/.config/i3/config file succeeded."

	cp ~/functions_bash_sahil.sh $backup_dir/
	echo "Backup of ~/functions_bash_sahil.sh succeeded."

	echo
}

echo ran .profile file
sh /home/array/scripts/battery-alert/service-START.sh &
alias vi='vim'
. "$HOME/.cargo/env"

[[ -f $_home/.bash_functions ]] && source $_home/.bash_functions

# workrave (only if installed and nor running already)
[ "$(type workrave 2> /dev/null)" ] && [ -z "$(pgrep workrave)" ] && (workrave &)

# flameshot (only if installed and nor running already)
flameshot=/home/array/binaries/Flameshot-12.0.rc1.x86_64.AppImage
[ "$(type $flameshot 2> /dev/null)" ] && [ -z "$(pgrep Flameshot)" ] && ($flameshot &)

# copyq (only if installed and nor running already)
[ "$(type copyq 2> /dev/null)" ] && [ -z "$(pgrep copyq)" ] && (copyq &)

# safe program exection on login (should not cause execution error on login event)
[ "$(type bad_program 2> /dev/null)" ] && (bad_program &)

# Learn: UNIT TEST: This is to check if workrave is already running and don't run it again if it is. (in some extreme use cases reloading .profile would rerun workrave, and workrave will then throw warning)
# [ -z "$(pgrep workrave)" ] && echo program is not running

# Using a `AppImage` to run on login
# /home/array/binaries/Flameshot-12.0.rc1.x86_64.AppImage

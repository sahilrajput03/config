echo ran .profile file
sh /home/array/scripts/battery-alert/service-START.sh &
alias vi='vim'
. "$HOME/.cargo/env"

[[ -f $_home/.bash_functions ]] && source $_home/.bash_functions

# Running workrave, flameshot, copyq (only if installed and nor running already)
[ "$(type workrave 2> /dev/null)" ] && [ -z "$(pgrep workrave)" ] && (workrave &)
# [ "$(type flameshot 2> /dev/null)" ] && [ -z "$(pgrep flameshot)" ] && (flameshot &)
flameshot=/home/array/binaries/Flameshot-12.0.rc1.x86_64.AppImage
[ "$(type $flameshot 2> /dev/null)" ] && [ -z "$(pgrep Flameshot)" ] && ($flameshot &)
# /home/array/binaries/Flameshot-12.0.rc1.x86_64.AppImage
[ "$(type copyq 2> /dev/null)" ] && [ -z "$(pgrep copyq)" ] && (copyq &)
# bad_program test (should not cause login execution error)
[ "$(type bad_program 2> /dev/null)" ] && (bad_program &)

# FYI: UNIT TEST: This is to check if workrave is already running and don't run it again if it is. (in some extreme use cases reloading .profile would rerun workrave, and workrave will then throw warning)
# [ -z "$(pgrep workrave)" ] && echo program is not running

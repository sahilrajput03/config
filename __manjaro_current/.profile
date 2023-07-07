# Run battery alert service
sh /home/array/Documents/github_repos/config/scripts/battery-alert/service-START.sh &

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
# export BROWSER=/usr/bin/google-chrome-stable
# export BROWSER='i3-msg "exec --no-startup-id google-chrome-stable"'

# flameshot (only if installed and nor running already)
flameshot=/usr/bin/flameshot
[ "$(type $flameshot 2>/dev/null)" ] && [ -z "$(pgrep Flameshot)" ] && ($flameshot &)

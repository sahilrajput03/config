# Run battery alert service
sh /home/array/Documents/github_repos/config/scripts/battery-alert/service-START.sh &

# Setup extended support for `monitor-extends-laptop` arandr profile
[ -f /home/array/Documents/github_repos/config/arandr-profiles/monitor-extends-laptop.sh ] && source /home/array/Documents/github_repos/config/arandr-profiles/monitor-extends-laptop.sh

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
# export BROWSER=/usr/bin/google-chrome-stable
# export BROWSER='i3-msg "exec --no-startup-id google-chrome-stable"'

# flameshot (only if installed and not running already)
flameshot=/usr/bin/flameshot
[ "$(type $flameshot 2>/dev/null)" ] && [ -z "$(pgrep Flameshot)" ] && ($flameshot &)

# aw-qt (activity watcher) (only if installed and not running already)
pkill aw-server # killing aw-server is necessary otherwise logout and login shows a error and activity watcher does not work as expected. ~ Sahil
awQt=/usr/bin/aw-qt
[ "$(type $awQt 2>/dev/null)" ] && [ -z "$(pgrep aw-qt)" ] && ($awQt &)

date >> ~/logs.txt
# Disable keyboard clit @ LOGIN TIME
# xinput -set-prop "DELL08B8:00 0488:121F Mouse" "Device Enabled" 0
# Disable trackpad (in favor of using external mouse) @ LOGIN TIME
# xinput -set-prop "DELL08B8:00 0488:121F Touchpad" "Device Enabled" 0

{ xrandr-monitor-script, clipboard_daemon, wallpaper, config, pkgs }: ''

#!/bin/sh

xrdb merge ~/.Xresources &
# xbacklight -set 10 & # TODO: not working (idk if essential)
xset r rate 200 50 &
dash ~/.config/chadwm/scripts/bar.sh &
# eww daemon & # start eww daemon for faster widget startup
${clipboard_daemon} &
${xrandr-monitor-script}

# draw our wallpaper only if xinit is not set
if [ ! -f $XDG_CONFIG_HOME/sxmo/xinit ]; then
  DISPLAY=:0 ${pkgs.feh}/bin/feh --bg-fill -z ${wallpaper}
fi

nvidia-settings --load-config-only

while type dwm ; do ${config.services.xserver.windowManager.dwm.package}/bin/dwm && continue || break; done
''

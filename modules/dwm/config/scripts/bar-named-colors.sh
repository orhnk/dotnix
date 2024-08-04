#!/bin/dash

 # FUTURE #
 # - MAILBOX

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/dynamic # use dynamic for system-wide colors or anything under bar_themes folder for a specific one

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$magenta^ C"
	printf "^c$white^ ^b$grey^  $cpu_val"
}

pkg_updates() {
	#updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
	updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
	# updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)
	if [ -z "$updates" ]; then
		printf "  ^c$green^    Fully Updated"
	else
    printf "  ^c$green^    $updates"" updates"
	fi
}

# battery() {
#   get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)" # for laptops (computers which has batteries) uncomment these lines
#   printf "^c$blue^   $get_capacity"
# }

# brightness() {
#   printf "^c$red^   "
#   printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
# }

mem() {
	# 󱘗 -> saved for future use
	printf "^c$grey^ ^b$blue^ M"
	printf "^c$white^ ^b$grey^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
  # WIFI:
  # cat /sys/class/net/wl*/operstate 2>/dev/null
  # ETH:
  # cat /sys/class/net/enp4s0/operstate 2>/dev/null
	case "$(cat /sys/class/net/enp4s0/operstate 2>/dev/null)" in
	up)   printf "^c$grey^ ^b$orange^ W ^d^%s" "^b$grey^ ^c$orange^ Connected" ;;
	down) printf "^c$grey^ ^b$orange^ W ^d^%s" "^b$grey^ ^c$orange^ Disconnected" ;;
	esac
}

dateinfo() {
	printf "^c$black^ ^b$aqua^ D"
	printf "^c$white^ ^b$grey^ $(date '+%d/%m/%y')"
}

timeinfo() {
	printf "^c$grey^ ^b$green^ T"
	printf "^c$grey^^b$green^  $(date '+%R')   "
}

weather() {
	# weather=$(curl -s wttr.in/?format="%t\n")
	# moon=$(curl -s wttr.in/?format=%m)
	# printf "^c$black^ ^b$white^ $moon"
	# printf "^c$white^ ^b$grey^  $weather"
  disk_space=$(df -BG --output=avail / | tail -n 1 | awk '{print $1}')
	disk_icon='S'
	printf "^c$black^ ^b$white^ $disk_icon"
	printf "^c$white^ ^b$grey^  $disk_space"
}

vim()      { printf "^c$green^";                 }
firefox()  { printf "^c$orange^";                }
emacs()    { printf "^c$magenta^";               }
arch()     { printf "^c$blue^";                  }

# uptime | awk -F'[ ,:]+' '{printf "UP: %02d:%02d\n", $6, $7}'

uptime_info() {
	printf "^c$black^ ^b$red^ U"
  uptime_result=$(uptime | awk -F'[ ,:]+' '{printf "%02d:%02d\n", $6, $7}')
	printf "^c$white^ ^b$grey^  $uptime_result"
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
  sleep 1 && xsetroot -name "$updates    $(firefox) $(emacs) $(arch) $(vim)    $(weather) $(cpu) $(mem) $(uptime_info) $(dateinfo) $(wlan) $(timeinfo)"
done

#!/bin/dash

# FUTURE #
# - MAILBOX

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
# . ~/.config/chadwm/scripts/bar_themes/gruvbox
. ~/.config/nix/chadwm/bar/theme

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$magenta^ 󰍛"
	printf "^c$white^ ^b$grey^  $cpu_val"
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
	printf "^c$grey^ ^b$blue^ 󱐖"
	printf "^c$white^ ^b$grey^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	# WIFI:
	# cat /sys/class/net/wl*/operstate 2>/dev/null
	# ETH:
	# cat /sys/class/net/enp4s0/operstate 2>/dev/null
	case "$(cat /sys/class/net/enp4s0/operstate 2>/dev/null)" in
	up) printf "^c$grey^ ^b$orange^ 󰤨 ^d^%s" "^b$grey^ ^c$orange^ Connected" ;;
	down) printf "^c$grey^ ^b$orange^ 󰤭 ^d^%s" "^b$grey^ ^c$orange^ Disconnected" ;;
	esac
}

dateinfo() {
	printf "^c$black^ ^b$aqua^ 󰃵"
	printf "^c$white^ ^b$grey^ $(date '+%d/%m/%y')"
}

timeinfo() {
	printf "^c$grey^ ^b$green_dark^ 󱑆 "
	printf "^c$grey^^b$green^  $(date '+%R')  "
}

disk() {
	# weather=$(curl -s wttr.in/?format="%t\n")
	# moon=$(curl -s wttr.in/?format=%m)
	# printf "^c$black^ ^b$white^ $moon"
	# printf "^c$white^ ^b$grey^  $weather"
	disk_space=$(df -h / | awk '{print $4}' | tail -n 1 | sed 's/G/GB/')
	disk_icon=''
	printf "^c$black^ ^b$white^ $disk_icon"
	printf "^c$white^ ^b$grey^  $disk_space"
}

# uptime | awk -F'[ ,:]+' '{printf "UP: %02d:%02d\n", $6, $7}'

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
	sleep 1 && xsetroot -name "$(disk) $(wlan) $(cpu) $(mem) $(dateinfo) $(timeinfo)"
done

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
	printf "^c$magenta^ ^b$black^ $cpu_val"
}

mem() {
	printf "^c$blue^ ^b$black^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	# WIFI:
	# cat /sys/class/net/wl*/operstate 2>/dev/null
	# ETH:
	# cat /sys/class/net/enp4s0/operstate 2>/dev/null
	case "$(cat /sys/class/net/enp4s0/operstate 2>/dev/null)" in
	up)   printf "^b$black^ ^c$orange^ Connected" ;;
	down) printf "^b$black^ ^c$orange^ Disconnected" ;;
	esac
}

dateinfo() {
	printf "^c$aqua^ ^b$black^ $(date '+%d/%m/%y')"
}

timeinfo() {
	printf "^c$green^ ^b$black^ $(date '+%R')  "
}

disk() {
	disk_space=$(df -h / | awk '{print $4}' | tail -n 1 | sed 's/G/GB/')
	printf "^c$white^ ^b$black^ $disk_space"
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
	sleep 1 && xsetroot -name " $(disk)$(wlan)$(cpu)$(mem)$(dateinfo)$(timeinfo)"
done

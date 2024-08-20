{theme}:
with theme.withHashtag; ''
  #!/bin/dash

  # FUTURE #
  # - MAILBOX

  # ^c$var^ = fg color
  # ^b$var^ = bg color

  time_icon='Time'
  disk_icon='Left'
  cpu_icon='Proc'
  mem_icon='MemL'
  date_icon='Date'
  wlan_icon='Wlan'
  uptime_icon='UpTm'

  interval=0

  cpu() {
  	cpu_val=$(vmstat 1 2 | tail -n 1 | awk '{print 100 - $15"%"}')

  	printf "^c${base00}^ ^b${base0A}^ $cpu_icon"
  	printf "^c${base07}^ ^b${base01}^  $cpu_val"
  }

  pkg_updates() {
  	#updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
  	updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
  	# updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)
  	if [ -z "$updates" ]; then
  		printf "  ^c${base0F}^    Fully Updated"
  	else
      printf "  ^c${base0F}^    $updates"" updates"
  	fi
  }

  # battery() {
  #   get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)" # for laptops (computers which has batteries) uncomment these lines
  #   printf "^c${base0B}^   $get_capacity"
  # }

  # brightness() {
  #   printf "^c${base0C}^   "
  #   printf "^c${base0C}^%.0fn" $(cat /sys/class/backlight/*/brightness)
  # }

  mem() {
  	# 󱘗 -> saved for future use
  	printf "^c${base01}^ ^b${base0B}^ $mem_icon"
  	printf "^c${base07}^ ^b${base01}^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
  }

  wlan() {
    # WIFI:
    # cat /sys/class/net/wl*/operstate 2>/dev/null
    # ETH:
    # cat /sys/class/net/enp4s0/operstate 2>/dev/null
  	case "$(cat /sys/class/net/enp4s0/operstate 2>/dev/null)" in
  	up)   printf "^c${base01}^ ^b${base0E}^ $wlan_icon ^d^%s" "^b${base01}^ ^c${base07}^ Connected" ;;
  	down) printf "^c${base01}^ ^b${base0E}^ $wlan_icon ^d^%s" "^b${base01}^ ^c${base07}^ Disconnected" ;;
  	esac
  }

  dateinfo() {
  	printf "^c${base00}^ ^b${base0D}^ $date_icon"
  	printf "^c${base07}^ ^b${base01}^ $(date '+%d/%m/%y')"
  }

  timeinfo() {
  	printf "^c${base01}^ ^b${base0F}^ $time_icon "
  	printf "^c${base07}^^b${base01}^  $(date '+%R')  "
  }

  disk_space() {
    disk_space=$(df -BG --output=avail / | tail -n 1 | awk '{print $1}')
  	printf "^c${base00}^ ^b${base09}^ $disk_icon"
  	printf "^c${base07}^ ^b${base01}^  $disk_space"
  }

  weather() {
  	weather=$(curl -s wttr.in/?format=%t)
  	weather_icon='Temp'
  	printf "^c${base00}^ ^b${base08}^ $weather_icon"
  	printf "^c${base07}^ ^b${base01}^  $weather"
  }

  vim()      { printf "^c${base0B}^"; }
  firefox()  { printf "^c${base09}^"; }
  emacs()    { printf "^c${base0E}^"; }
  arch()     { printf "^c${base0D}^"; }

  # uptime | awk -F'[ ,:]+' '{printf "UP: %02d:%02dn", $6, $7}'

  uptime_info() {
  	printf "^c${base00}^ ^b${base0C}^ $uptime_icon"
    uptime_result=$(uptime | awk -F'[ ,:]+' '{printf "%02d:%02dn", $6, $7}')
  	printf "^c${base07}^ ^b${base01}^  $uptime_result"
  }

  while true; do
  	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
    sleep 1 && xsetroot -name "$updates    $(firefox) $(emacs) $(arch) $(vim)    $(weather) $(disk_space) $(cpu) $(mem) $(uptime_info) $(dateinfo) $(wlan) $(timeinfo)"
  done
''

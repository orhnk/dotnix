#!/bin/sh

# Configuration
declare -A OPTIONS
OPTIONS=(
  ["Shutdown"]="shutdown_handler"
  ["Reboot"]="reboot_handler"
  ["Sleep"]="sleep_handler"
  ["Logout"]="logout_handler"
)

shutdown_handler() {
  shutdown -h now
}

reboot_handler() {
  reboot
}

sleep_handler() {
  systemctl hibernate
}

logout_handler() {
  pkill dwm
}

# Generate the menu string without a trailing newline
generate_menu() {
  local menu=""
  for key in "${!OPTIONS[@]}"; do
    menu+="$key\n"
  done
  # Remove the trailing newline
  echo -e "${menu::-2}"
}

# Prompt user to select an action
action=$(generate_menu | rofi -dmenu -i)

# Execute the selected action
if [[ -n "${OPTIONS[$action]}" ]]; then
  ${OPTIONS[$action]}
else
  echo "Invalid selection"
fi

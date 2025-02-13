#!/bin/sh

DAEMON="notify-send"

# Configuration
declare -A LANGUAGES
LANGUAGES=(
  ["Arabic"]="ara"
  ["Turkish"]="tr"
)

# Function to switch layout
switch_layout() {
  local layout=$1
  if setxkbmap "$layout"; then
    $DAEMON "Keyboard Layout" "Switched to $layout layout"
  else
    $DAEMON "Keyboard Layout Error" "Failed to switch to $layout layout"
  fi
}

# Generate the menu string without a trailing newline
generate_menu() {
  local menu=""
  for key in "${!LANGUAGES[@]}"; do
    menu+="$key\n"
  done
  # Remove the trailing newline
  echo -e "${menu::-2}"
}

# Prompt user to select a language
selected_language=$(generate_menu | rofi -i -dmenu -theme-str 'window {width: 10em;} listview {lines: 2;}')

# Execute the corresponding layout switch
if [[ -n "${LANGUAGES[$selected_language]}" ]]; then
  switch_layout "${LANGUAGES[$selected_language]}"
else
  echo "Invalid selection"
fi

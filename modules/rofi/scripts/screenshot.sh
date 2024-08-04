#!/bin/sh

DAEMON="notify-send"

# Configuration
declare -A OPTIONS
OPTIONS=(
  ["Screen"]="capture_full_screenshot"
  ["Delayed"]="capture_delayed_screenshot"
  ["Region"]="capture_select_screenshot"
  ["Window"]="capture_active_window_screenshot"
)


countdown() {
  notify-send --app-name="screenshot" "Screenshot" "Capturing in 3" -t 1000
  sleep 1
  notify-send --app-name="screenshot" "Screenshot" "Capturing in 2" -t 1000
  sleep 1
  notify-send --app-name="screenshot" "Screenshot" "Capturing in 1" -t 1000
  sleep 1
}

# Function to capture full screenshot
capture_full_screenshot() {
  RESOLUTION=$(xrandr | grep '*' | awk '{print $1}' | head -n 1)
  ffmpeg -f x11grab -s "$RESOLUTION" -i :0.0 -vframes 1 /tmp/screenshot.png
  xclip -selection clipboard -t image/png -i /tmp/screenshot.png
  rm /tmp/screenshot.png
}

# Function to notify and then capture screenshot
capture_delayed_screenshot() {
  countdown
  capture_full_screenshot
}

# Function to capture screenshot of selected region
capture_select_screenshot() {
  maim -s /tmp/screenshot.png
  xclip -selection clipboard -t image/png -i /tmp/screenshot.png
  rm /tmp/screenshot.png
}

# Function to capture screenshot of the active window
capture_active_window_screenshot() {
  WINDOW_ID=$(xdotool getactivewindow)
  WIN_INFO=$(xwininfo -id "$WINDOW_ID")
  WIN_X=$(echo "$WIN_INFO" | grep "Absolute upper-left X:" | awk '{print $4}')
  WIN_Y=$(echo "$WIN_INFO" | grep "Absolute upper-left Y:" | awk '{print $4}')
  WIN_WIDTH=$(echo "$WIN_INFO" | grep "Width:" | awk '{print $2}')
  WIN_HEIGHT=$(echo "$WIN_INFO" | grep "Height:" | awk '{print $2}')

  if [[ -n "$WIN_X" && -n "$WIN_Y" && -n "$WIN_WIDTH" && -n "$WIN_HEIGHT" ]]; then
    ffmpeg -f x11grab -video_size "${WIN_WIDTH}x${WIN_HEIGHT}" -i :0.0+"$WIN_X,$WIN_Y" -vframes 1 /tmp/screenshot.png
    if [[ -f /tmp/screenshot.png ]]; then
      xclip -selection clipboard -t image/png -i /tmp/screenshot.png
      rm /tmp/screenshot.png
    else
      $DAEMON "Screenshot Error" "Failed to capture the active window screenshot"
    fi
  else
    $DAEMON "Screenshot Error" "Failed to retrieve window geometry"
  fi
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
action=$(generate_menu | rofi -i -dmenu -theme-str 'window {width: 8em;} listview {lines: 6;}')

# Execute the selected action
if [[ -n "${OPTIONS[$action]}" ]]; then
  ${OPTIONS[$action]}
else
  echo "Invalid selection"
fi

$DAEMON "Screenshot" "Screenshot captures succesfully."

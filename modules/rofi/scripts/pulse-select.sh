
#!/bin/bash

# Define the options
OPTIONS="sink\nsource"

# Use rofi to present the options to the user
MODE=$(echo -e $OPTIONS | rofi -dmenu -p "Select Mode: ")

# Check if the user made a selection
if [ -n "$MODE" ]; then
    # Execute rofi-pulse-select with the selected mode
    rofi-pulse-select $MODE
else
    echo "No mode selected."
fi

# main.py

from datetime import datetime
from sys import exit
import config

def is_within_schedule(current_day, current_time, schedule):
    """
    Check if the current time fits within any of the timeframes for the current day.

    :param current_day: The current day as a string (e.g., 'Monday')
    :param current_time: The current time as a time object (e.g., time(15, 30))
    :param schedule: The schedule dictionary containing the allowed timeframes
    :return: True if current time is within any of the timeframes, False otherwise
    """
    # Check if today has any scheduled timeframes
    if current_day not in schedule:
        return False

    # Loop through the timeframes for the current day
    for start_time, end_time in schedule[current_day]:
        if start_time <= current_time <= end_time:
            return True

    # If no valid timeframe was found, return False
    return False

# Example usage
if __name__ == '__main__':
    # Get current time and day
    now = datetime.now()
    current_day = now.strftime('%A')  # E.g., 'Monday', 'Tuesday', etc.
    current_time = now.time()          # Current time

    # Use the is_within_schedule function with inputs
    if is_within_schedule(current_day, current_time, config.schedule):
        print("Access allowed.")
    else:
        print("Access denied.")
        exit(1)

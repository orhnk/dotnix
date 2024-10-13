# config.py

from datetime import time

days = {
    'weekday': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'], 
    'weekend': ['Saturday', 'Sunday'],
    'all': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
}

schedule_config = {
    'week': [
        (time(3,  0),  time(4, 0)),   # Digital Knowledge
    ],

    'weekend': [ ],

    'weekday': [
        (time(4,  15), time(5, 0)),   # Morning Coding
        (time(7,  50), time(16, 30)), # Baba
        (time(17, 15), time(18, 45))  # Study
    ],
}

# Define your weekly schedule: each day has a list of (start_time, end_time) tuples
schedule = {
    # Day specific config

    'Monday':    [ ],
    'Tuesday':   [ ],
    'Wednesday': [ ],
    'Thursday':  [ ],
    'Friday':    [ ],
    'Saturday':  [ ],
    'Sunday':    [ ],

}

# Append Schedules for Entire, Weekday and Weekend
for day in days['all']:
    schedule[day] += schedule_config['week']

for day in days['weekday']:
    schedule[day] += schedule_config['weekday']

for day in days['weekend']:
    schedule[day] += schedule_config['weekend']

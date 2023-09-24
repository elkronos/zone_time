import pytz
from datetime import datetime

def time_difference(tz1_list, tz2_list):
    """
    Calculate Time Difference between Time Zones
    
    This function calculates the absolute time difference in minutes between pairs of time zones.
    The function takes two lists of time zone names as input, and for each pair, it calculates 
    the time difference based on the UTC offset difference of each time zone.
    
    :param tz1_list: List of strings, representing the first set of time zones.
    :param tz2_list: List of strings, representing the second set of time zones.
                    The length of tz2_list should be the same as tz1_list.
    :return: A list of integers representing the time difference in minutes between each pair of time zones.
    """
    if len(tz1_list) != len(tz2_list):
        raise ValueError("Both lists must have the same length.")
    
    result = []
    for tz1, tz2 in zip(tz1_list, tz2_list):
        if tz1 not in pytz.all_timezones or tz2 not in pytz.all_timezones:
            raise ValueError("Invalid time zone provided.")
        
        now = datetime.now(pytz.utc)  # Current time in UTC
        
        time_tz1 = now.astimezone(pytz.timezone(tz1))
        time_tz2 = now.astimezone(pytz.timezone(tz2))
        
        # Calculate the UTC offset difference in minutes
        utc_offset_diff = time_tz1.utcoffset().total_seconds() - time_tz2.utcoffset().total_seconds()
        diff_minutes = round(abs(utc_offset_diff / 60))
        
        result.append(diff_minutes)
    
    return result

# Example usage:
tz1_list = ["America/New_York", "Asia/Tokyo"]
tz2_list = ["Europe/London", "Europe/Berlin"]

# Calculate time difference in minutes and formatted
time_diff_minutes = time_difference(tz1_list, tz2_list)
time_diff_formatted = [f"{mins // 60} hours and {mins % 60} minutes" for mins in time_diff_minutes]

# Print the current time in each time zone for verification
current_time_tz1 = [str(datetime.now(pytz.timezone(tz))) for tz in tz1_list]
current_time_tz2 = [str(datetime.now(pytz.timezone(tz))) for tz in tz2_list]

# Create the resulting dataframe (you need pandas library for this)
import pandas as pd
df = pd.DataFrame({
    'tz1': tz1_list,
    'tz2': tz2_list,
    'time_diff_minutes': time_diff_minutes,
    'time_diff_formatted': time_diff_formatted,
    'current_time_tz1': current_time_tz1,
    'current_time_tz2': current_time_tz2,
})

print(df)

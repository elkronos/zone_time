from datetime import datetime
import pytz

def is_dst(time: str, tz: str) -> bool:
    """
    Check if Daylight Saving Time (DST) is in effect for a given time and time zone.
    
    Parameters:
    time (str): A string representing the time in 'YYYY-MM-DD HH:MM:SS' format.
    tz (str): A string representing the time zone.
    
    Returns:
    bool: True if DST is in effect, False otherwise.
    
    Raises:
    ValueError: If the input time string format or time zone is invalid.
    """
    
    # Check if the provided time zone is valid
    if tz not in pytz.all_timezones:
        raise ValueError("Error: Invalid time zone. Please provide a valid time zone.")
    
    # Try to convert the time string to a datetime object with the specified time zone
    try:
        time_dt = datetime.strptime(time, '%Y-%m-%d %H:%M:%S')
    except ValueError:
        raise ValueError("Error: Invalid time string format. Please provide time in 'YYYY-MM-DD HH:MM:SS' format.")
    
    # Localize the time to the given time zone
    timezone = pytz.timezone(tz)
    time_localized = timezone.localize(time_dt)
    
    # Return whether Daylight Saving Time (DST) is in effect
    return time_localized.dst() != timedelta(seconds=0)

# Example Usage:
# Check if DST is in effect on '2023-07-01 12:00:00' in 'America/New_York' time zone
result = is_dst('2023-07-01 12:00:00', 'America/New_York')

# Print the result
if result:
    print("Daylight Saving Time is in effect.")
else:
    print("Daylight Saving Time is not in effect.")

import pytz
from datetime import datetime

def time_zone_offset(tz_list, datetime_list=None):
    """
    Calculate Time Zone Offset
    
    This function calculates the offset in hours and minutes of a given time zone or list of time zones from UTC.
    It returns None for invalid time zones and prints a warning.
    
    Parameters:
        tz_list (list): A list of strings representing the time zone(s) for which to calculate the offset.
        datetime_list (list, optional): A list of datetime objects representing the datetime(s) for which to calculate the offset.
                                         Default is the current system time for each time zone in tz_list.
                                         
    Returns:
        list: A list of strings representing the offset(s) from UTC in the format "HH:MM".
        
    Examples:
        >>> time_zone_offset(["America/New_York", "Europe/London", "Asia/Tokyo"])
    """
    if datetime_list is None:
        datetime_list = [datetime.now(pytz.timezone(tz)) for tz in tz_list]
    
    if len(datetime_list) != len(tz_list):
        raise ValueError("Length of datetime_list and tz_list must be the same.")
    
    offsets = []
    for tz, dt in zip(tz_list, datetime_list):
        if tz not in pytz.all_timezones:
            print(f"Warning: Invalid time zone detected: {tz}. Returning None for this entry.")
            offsets.append(None)
            continue
        
        localized_dt = pytz.timezone(tz).localize(dt)
        offset_minutes = localized_dt.utcoffset().total_seconds() / 60
        offset_hours = int(offset_minutes // 60)
        offset_minutes = int(offset_minutes % 60)
        offsets.append(f"{offset_hours:+03d}:{offset_minutes:02d}")
        
    return offsets

# Example usage:
tz_list = ["America/New_York", "Europe/London", "Asia/Tokyo", "Invalid/TimeZone"]
datetime_list = [datetime.now() for _ in tz_list]
offsets = time_zone_offset(tz_list, datetime_list)
print(offsets)

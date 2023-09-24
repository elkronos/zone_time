from datetime import datetime
import pytz

def get_local_time(tz="UTC", format_output=False, include_tz_abbreviation=False, custom_format="%Y-%m-%d %H:%M:%S.%f"):
    """
    Get Local Time in Specified Time Zone

    This function retrieves the current time and adjusts it to the specified time zone.
    The user can also choose to format the output and include the time zone abbreviation.

    Parameters:
    tz (str): String representing the time zone to which the current time will be adjusted. Default is "UTC".
    format_output (bool): Boolean, indicating whether to format the output as a string. Default is False.
    include_tz_abbreviation (bool): Boolean, indicating whether to include the time zone abbreviation in the output. Default is False.
    custom_format (str): String representing the custom format string to be used if format_output is True. Default is "%Y-%m-%d %H:%M:%S.%f".

    Returns:
    datetime or str: A datetime object representing the local time in the specified time zone, optionally formatted as a string.

    Examples:
    >>> get_local_time("America/New_York", format_output=True, include_tz_abbreviation=True)
    """
    
    # Validate the input time zone
    if tz not in pytz.all_timezones:
        raise ValueError("Invalid time zone provided. Use pytz.all_timezones to view available time zones.")
    
    # Retrieve the current time with microseconds
    current_time = datetime.now(pytz.timezone(tz))
    
    # Optionally include the time zone abbreviation
    if include_tz_abbreviation:
        tz_abbreviation = current_time.strftime("%Z")
        local_time_str = current_time.strftime(custom_format) + " " + tz_abbreviation
    else:
        local_time_str = current_time.strftime(custom_format)
    
    # Optionally format the output as a string
    if format_output:
        return local_time_str
    else:
        return current_time

# Example usage:
tz = "America/New_York"
local_time = get_local_time(tz, format_output=True, include_tz_abbreviation=True)
print(local_time)

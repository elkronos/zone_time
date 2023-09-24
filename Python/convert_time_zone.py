from datetime import datetime
import pytz

def convert_time_zone(time, from_tz="UTC", to_tz="UTC"):
    """
    Convert Time Between Time Zones

    This function converts time from one time zone to another. 
    It takes a time input (either a character string or a datetime object), 
    and the time zones from and to which the time needs to be converted.

    Parameters:
        time (str or datetime): A string or a datetime object representing the input time.
        from_tz (str): A string representing the time zone of the input time. Default is "UTC".
        to_tz (str): A string representing the target time zone to which the time will be converted. Default is "UTC".

    Returns:
        str or datetime: The time converted to the target time zone, formatted as a string if the input was string, 
                         otherwise as a datetime object.

    Examples:
        convert_time_zone("2023-09-23 12:00:00", "America/New_York", "Europe/London")
        convert_time_zone(datetime(2023, 9, 23, 12, 0, 0, tzinfo=pytz.timezone("America/New_York")), to_tz="Europe/London")
    """
    if from_tz not in pytz.all_timezones or to_tz not in pytz.all_timezones:
        raise ValueError("Invalid time zone provided. Use pytz.all_timezones to view available time zones.")
    
    input_is_string = isinstance(time, str)
    
    if input_is_string:
        try:
            dt = datetime.strptime(time, '%Y-%m-%d %H:%M:%S')
            time = pytz.timezone(from_tz).localize(dt)
        except ValueError:
            raise ValueError("Invalid time format. Please provide time as a recognizable string or a datetime object.")
    
    converted_time = time.astimezone(pytz.timezone(to_tz))
    output = converted_time.strftime('%Y-%m-%d %H:%M:%S') + " " + converted_time.tzname()

    return output


time_char = "2023-09-23 12:00:00"
from_tz = "America/New_York"
to_tz = "Europe/London"

converted_time_char = convert_time_zone(time_char, from_tz, to_tz)
print(f"Final Output (string input): {converted_time_char}")

time_dt = datetime(2023, 9, 23, 12, 0, 0)
time_dt = pytz.timezone("America/New_York").localize(time_dt)
converted_time_dt = convert_time_zone(time_dt, to_tz="Europe/London")
print(f"Final Output (datetime input): {converted_time_dt}")

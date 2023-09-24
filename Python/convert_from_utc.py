from datetime import datetime, timedelta
import pytz

def convert_from_utc(time_list, tz_list):
    """
    Converts a list of time in UTC to a given list of time zones.

    This function takes a list of time input in UTC (as strings) and converts it to the specified target time zones.

    Parameters:
    time_list (List[str]): List of strings representing the input time(s) in UTC.
    tz_list (List[str]): List of strings representing the target time zone(s).

    Returns:
    List[str]: List of strings representing the formatted time(s) in the target time zone(s).

    Example:
    convert_from_utc(["2023-09-23 12:00:00", "2023-09-24 14:00:00"], ["America/New_York", "Asia/Tokyo"])
    Output:
    ['2023-09-23 08:00:00 EDT', '2023-09-25 23:00:00 JST']
    """

    if len(tz_list) != 1 and len(time_list) != len(tz_list):
        raise ValueError("Length of tz_list must be either 1 or equal to the length of time_list.")

    converted_time = []
    for i in range(max(len(time_list), len(tz_list))):
        current_tz = tz_list[i] if len(tz_list) > 1 else tz_list[0]
        try:
            tz = pytz.timezone(current_tz)
        except pytz.UnknownTimeZoneError:
            raise ValueError(f"Invalid time zone provided: {current_tz}")

        dt = datetime.strptime(time_list[i], "%Y-%m-%d %H:%M:%S")
        dt = pytz.utc.localize(dt)
        dt_in_tz = dt.astimezone(tz)
        converted_time.append(dt_in_tz.strftime("%Y-%m-%d %H:%M:%S %Z"))

    return converted_time


# Example usage:
time_utc = ["2023-09-23 12:00:00", "2023-09-24 14:00:00"]
tz_target = ["America/New_York", "Asia/Tokyo"]
converted_time = convert_from_utc(time_utc, tz_target)
print(converted_time)

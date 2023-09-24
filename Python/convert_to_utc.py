import pandas as pd
from datetime import datetime
import pytz

def convert_to_utc(times, timezones):
    """
    Convert a list of local times to UTC times based on the given timezones.
    
    Parameters:
    times (List[str]): A list of strings representing local times in the "YYYY-MM-DD HH:mm:ss" format.
    timezones (List[str]): A list of strings representing the corresponding timezones for the local times.
    
    Returns:
    List[str]: A list of strings representing the converted UTC times in the "YYYY-MM-DD HH:mm:ss+00:00" format.
    
    Raises:
    ValueError: If the length of times and timezones is not the same.
    """
    if len(times) != len(timezones):
        raise ValueError("Length of times and timezones must be the same")
    
    utc_times = []
    for time, timezone in zip(times, timezones):
        try:
            local_time = datetime.strptime(time, '%Y-%m-%d %H:%M:%S')
            local_tz = pytz.timezone(timezone)
            local_time = local_tz.localize(local_time)
            utc_time = local_time.astimezone(pytz.UTC)
            utc_times.append(utc_time.strftime('%Y-%m-%d %H:%M:%S%z'))
        except Exception as e:
            print(f"Invalid time or timezone provided: {e}")
            utc_times.append(None)
    
    return utc_times

# Create a data frame with a column of time values and a corresponding timezone column
df = pd.DataFrame({
    'time': ["2023-09-23 12:00:00", "2023-09-23 14:00:00", "2023-09-23 16:00:00"],
    'tz': ["America/New_York", "Europe/London", "Asia/Tokyo"]
})

# Apply the convert_to_utc function to the entire columns
df['utc_time'] = convert_to_utc(df['time'].tolist(), df['tz'].tolist())

# Print the resulting data frame
print(df)

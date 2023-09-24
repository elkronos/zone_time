import pandas as pd
from datetime import datetime
import pytz

def format_with_timezone(time, format_str="%Y-%m-%d %H:%M:%S %Z", to_tz=None):
    """
    Format a datetime object or a Series of datetime objects with time zone information.
    
    This function takes a datetime object or a pandas Series of datetime objects 
    and optionally converts them to a specified time zone before formatting them 
    according to the provided format string.
    
    Parameters:
        time (datetime or pd.Series): A datetime object or a pandas Series of datetime objects.
        format_str (str): A string specifying the desired format. Default is "%Y-%m-%d %H:%M:%S %Z".
        to_tz (str): A string specifying the target time zone. If provided,
                     the datetime object(s) are converted to this time zone before formatting.
                     Default is None (no conversion).
                     
    Returns:
        str or pd.Series: A string or a Series representing the formatted datetime object(s) 
                          with time zone information.
    
    Raises:
        ValueError: If any 'time' object is naive or if 'to_tz' is not a valid time zone.
    """
    
    def format_single_datetime(dt):
        # Check if the time object is naive (i.e., without timezone info)
        if dt.tzinfo is None:
            raise ValueError("The time object is naive. Please provide a datetime object with time zone information.")
        
        # If a target time zone is specified, validate and convert the time object to that time zone
        if to_tz:
            try:
                target_tz = pytz.timezone(to_tz)
            except pytz.UnknownTimeZoneError:
                raise ValueError(f"The to_tz '{to_tz}' is not a valid time zone.")
            
            # Convert the time object to the target time zone
            dt = dt.astimezone(target_tz)
        
        # Format the datetime object using the provided format string
        return dt.strftime(format_str)

    if isinstance(time, pd.Series):
        return time.map(format_single_datetime)
    else:
        return format_single_datetime(time)

# Example usage with DataFrame
df = pd.DataFrame({
    'time': [
        "2023-09-23 12:34:56",
        "2023-09-24 13:45:57"
    ]
})

df['time'] = pd.to_datetime(df['time']).dt.tz_localize('UTC')
df['formatted_time'] = format_with_timezone(df['time'], to_tz="America/New_York")

print(df)

import pandas as pd
import pytz

def add_time_zone(datetime_series, tz_series):
    """
    Add Time Zone to Datetime Objects.
    
    This function takes a pandas Series of datetime objects and a corresponding Series of time zone strings,
    and returns a new datetime Series where each datetime object has been assigned the corresponding time zone.
    
    :param datetime_series: pd.Series of pd.Timestamp, representing the datetime objects to which the time zones will be added.
    :param tz_series: pd.Series of str, representing the time zones to be assigned to the datetime objects.
                     The length of tz_series should be the same as the length of datetime_series.
    :return: A pd.Series of pd.Timestamp with the same length as the input, where each datetime object has the assigned time zone.
    :raise ValueError: If the length of datetime_series and tz_series are not the same.
    """
    
    if len(datetime_series) != len(tz_series):
        raise ValueError("Length of datetime_series and tz_series must be the same.")
    
    # Initializing the new_datetime series
    new_datetime = pd.Series(index=datetime_series.index, dtype='datetime64[ns]')
    
    for i in range(len(datetime_series)):
        tz = pytz.timezone(tz_series.iloc[i])
        new_datetime.iloc[i] = datetime_series.iloc[i].tz_convert(tz)
    
    return new_datetime

# Define a DataFrame
df = pd.DataFrame({
    'datetime': pd.to_datetime(["2023-09-23 12:00:00", "2023-09-24 12:00:00", "2023-09-25 12:00:00"], utc=True)
})

# Define a Series of time zones
tz_series = pd.Series(["America/New_York", "Europe/London", "Asia/Tokyo"])

# Apply the add_timezone function to the datetime column with different time zones for each element
df['new_datetime'] = add_time_zone(df['datetime'], tz_series)

# Print the resulting DataFrame
print(df)

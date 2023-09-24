from datetime import datetime
import pytz

def remove_time_zone(datetime_obj):
    """
    Remove the timezone attribute from a datetime object.

    Args:
    datetime_obj (datetime): a datetime object with or without a timezone attribute.

    Returns:
    datetime: a datetime object without a timezone attribute.
    """
    # Convert datetime to string and then back to a datetime object
    # without specifying the timezone, effectively removing the timezone attribute
    datetime_str = datetime_obj.strftime("%Y-%m-%d %H:%M:%S")
    datetime_without_tz = datetime.strptime(datetime_str, "%Y-%m-%d %H:%M:%S")
    return datetime_without_tz

# Create a single datetime object with a timezone
datetime_with_tz = datetime(2023, 9, 23, 12, 0, 0, tzinfo=pytz.timezone("America/New_York"))

# Print the datetime object with timezone and its timezone attribute
print("Datetime with Timezone:")
print(datetime_with_tz)
print("Timezone attribute of datetime_with_tz:", datetime_with_tz.tzinfo, "\n")

# Apply the remove_time_zone function
datetime_without_tz = remove_time_zone(datetime_with_tz)

# Print the resulting datetime object without timezone and check its timezone attribute
print("Datetime without Timezone:")
print(datetime_without_tz)
print("Timezone attribute of datetime_without_tz:", datetime_without_tz.tzinfo, "\n")

# Example usage:
# List first 5 available timezones with 'America' in their name
available_time_zones = [tz for tz in pytz.all_timezones if 'America' in tz][:5]
print("Available time zones:")
print(available_time_zones)

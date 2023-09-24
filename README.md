# Zone Time

This repository contains several R and Python functions for handling and converting time zones. Below is a summary of each function available in this repository along with their dependencies.

## Functions

| Function Name             | Description                                                                                                                  
|---------------------------|------------------------------------------------------------------------------------------------------------------------------|
| `add_time_zone`           | Takes a vector of datetime objects and a corresponding vector of time zone strings, and assigns each datetime object the corresponding time zone. |
| `convert_from_utc`        | Converts a given time in UTC to a specified target time zone. The function can handle both character strings and POSIXct objects as input. |
| `convert_time_zone`       | Converts time from one time zone to another. The function can handle both character strings and POSIXct objects as input. |
| `convert_to_utc`          | Takes vectors of local times and their corresponding timezones, and converts each local time to UTC format.                 |
| `format_with_timezone`    | Formats a datetime object or a column of datetime objects with time zone information. Optionally converts them to a specified time zone before formatting. | `lubridate`    |
| `get_local_time`          | Retrieves the current time and adjusts it to the specified time zone. The output can optionally be formatted as a string with time zone abbreviation. |
| `is_dst`                  | Check if Daylight Saving Time (DST) is in effect for a given time and time zone.                                            |
| `list_time_zones`         | List available time zones with optional query filtering, result limiting, and additional details like abbreviations and current offsets. |
| `remove_time_zone`        | Remove the timezone attribute from a POSIXct object.                                                                         |
| `time_difference`         | Calculate the absolute time difference in minutes between two time zones based on the current time in each time zone.     |
| `time_zone_offset`        | Calculate the offset in hours and minutes of a given time zone or vector of time zones from UTC.                           |

## Usage

To utilize these functions, clone the repository and source the required function file in your R/Python scripts or consoles.

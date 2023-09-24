# Load the necessary library
library(lubridate)

# Define the function
convert_time_zone <- function(time, from_tz = "UTC", to_tz = "UTC") {
  #' Convert Time Between Time Zones
  #'
  #' This function converts time from one time zone to another. 
  #' It takes a time input (either a character string or a POSIXct object), 
  #' and the time zones from and to which the time needs to be converted.
  #'
  #' @param time A character string or a POSIXct object representing the input time.
  #' @param from_tz Character, representing the time zone of the input time. Default is "UTC".
  #' @param to_tz Character, representing the target time zone to which the time will be converted. Default is "UTC".
  #' @return The time converted to the target time zone, formatted as a character string if the input was character, otherwise as a POSIXct object.
  #' @examples
  #' convert_time_zone("2023-09-23 12:00:00", "America/New_York", "Europe/London")
  #' convert_time_zone(as.POSIXct("2023-09-23 12:00:00", tz = "America/New_York"), to_tz = "Europe/London")
  
  # Validate input time zones
  if (!from_tz %in% OlsonNames() || !to_tz %in% OlsonNames()) {
    stop("Invalid time zone provided. Use OlsonNames() to view available time zones.")
  }
  
  # Detect input type
  input_is_character <- is.character(time)
  
  # Try to parse time if it is a character
  if (input_is_character) {
    time <- parse_date_time(time, orders = "ymd HMS", tz = from_tz)
    if (is.na(time)) {
      stop("Invalid time format. Please provide time as a recognizable character string or a POSIXct object.")
    }
  }
  
  # Convert the time object to the target time zone
  converted_time <- with_tz(time, to_tz)
  
  # Format output with time zone abbreviation
  tz_abbreviation <- attr(converted_time, "tzone")[1]
  
  # If the input was character, return character; otherwise return POSIXct
  if (input_is_character) {
    return(paste(format(converted_time), tz_abbreviation))
  } else {
    attr(converted_time, "tzone") <- tz_abbreviation
    return(converted_time)
  }
}

# Example usage:
time_char <- "2023-09-23 12:00:00"
from_tz <- "America/New_York"
to_tz <- "Europe/London"

converted_time_char <- convert_time_zone(time_char, from_tz, to_tz)
print(converted_time_char)

# Example usage with POSIXct input:
time_posix <- as.POSIXct("2023-09-23 12:00:00", tz = "America/New_York")

converted_time_posix <- convert_time_zone(time_posix, to_tz = "Europe/London")
print(converted_time_posix)

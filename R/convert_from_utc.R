# Load the necessary library
library(lubridate)

# Define the convert_from_utc function
convert_from_utc <- function(time, tz) {
  #' Converts a time in UTC to a given time zone.
  #'
  #' This function takes a time input in UTC (either as a character string 
  #' or a POSIXct object) and converts it to the specified target time zone.
  #'
  #' @param time Vector of character or POSIXct, representing the input time(s) in UTC.
  #' @param tz Vector of character, representing the target time zone(s).
  #' @return Vector of character representing the formatted time(s) in the target time zone(s).
  #' @examples
  #' convert_from_utc(c("2023-09-23 12:00:00", "2023-09-24 14:00:00"), c("America/New_York", "Asia/Tokyo"))
  
  # Validate the input time zones
  if (!all(tz %in% OlsonNames())) {
    stop("Invalid time zone provided. Use OlsonNames() to view available time zones.")
  }
  
  # If input is vectorized, ensure the lengths of time and tz are the same, or tz has length 1
  if (length(tz) != 1 && length(time) != length(tz)) {
    stop("Length of tz vector must be either 1 or equal to the length of time vector.")
  }
  
  # Detect input type and try to parse time if it is a character
  input_is_character <- is.character(time)
  if (any(input_is_character)) {
    time <- parse_date_time(time, orders = "ymd HMS", tz = "UTC")
    if (any(is.na(time))) {
      stop("Invalid time format. Please provide time as a recognizable character string or a POSIXct object.")
    }
  }
  
  # Ensure the input time is in UTC
  if (!all(attr(time, "tzone") == "UTC")) {
    stop("Input time must be in UTC.")
  }
  
  # Vectorized conversion of the UTC time object to the target time zone(s)
  converted_time <- vector("list", length = max(length(time), length(tz)))
  for (i in seq_along(converted_time)) {
    current_tz <- ifelse(length(tz) == 1, tz, tz[i])
    converted_time[[i]] <- with_tz(time[i], current_tz)
    # Format output with time zone abbreviation
    converted_time[[i]] <- format(converted_time[[i]], "%Y-%m-%d %H:%M:%S %Z")
  }
  return(do.call(c, converted_time))
}

# Example usage:
time_utc <- c("2023-09-23 12:00:00", "2023-09-24 14:00:00")
tz_target <- c("America/New_York", "Asia/Tokyo")
converted_time <- convert_from_utc(time_utc, tz_target)
print(converted_time)

# Load the necessary library
library(lubridate)

# Define the function
get_local_time <- function(tz = "UTC", format_output = FALSE, include_tz_abbreviation = FALSE, custom_format = "%Y-%m-%d %H:%M:%S") {
  #' Get Local Time in Specified Time Zone
  #'
  #' This function retrieves the current time and adjusts it to the specified time zone.
  #' The user can also choose to format the output and include the time zone abbreviation.
  #'
  #' @param tz Character, representing the time zone to which the current time will be adjusted. Default is "UTC".
  #' @param format_output Logical, indicating whether to format the output as a string. Default is FALSE.
  #' @param include_tz_abbreviation Logical, indicating whether to include the time zone abbreviation in the output. Default is FALSE.
  #' @param custom_format Character, representing the custom format string to be used if format_output is TRUE. Default is "%Y-%m-%d %H:%M:%S".
  #' @return A POSIXct object representing the local time in the specified time zone, optionally formatted as a string.
  #' @examples
  #' get_local_time("America/New_York", format_output = TRUE, include_tz_abbreviation = TRUE)
  
  # Validate the input time zone
  if (!tz %in% OlsonNames()) {
    stop("Invalid time zone provided. Use OlsonNames() to view available time zones.")
  }
  
  # Retrieve the current time
  current_time <- Sys.time()
  
  # Adjust the time zone
  local_time <- with_tz(current_time, tz)
  
  # Optionally include the time zone abbreviation
  if (include_tz_abbreviation) {
    tz_abbreviation <- format(local_time, "%Z")
    local_time <- paste(local_time, tz_abbreviation)
  }
  
  # Optionally format the output as a string
  if (format_output) {
    local_time <- format(local_time, format = custom_format)
  }
  
  # Return the local time in the specified time zone
  return(local_time)
}

# Example usage:
tz <- "America/New_York"
local_time <- get_local_time(tz, format_output = TRUE, include_tz_abbreviation = TRUE)
print(local_time)

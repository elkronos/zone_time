# Load the necessary library
library(lubridate)

# Define the enhanced time_zone_offset function
time_zone_offset <- function(tz, datetime = Sys.time()) {
  #' Calculate Time Zone Offset
  #'
  #' This function calculates the offset in hours and minutes of a given time zone or vector of time zones from UTC.
  #' It returns NA for invalid time zones and emits a warning.
  #'
  #' @param tz A character vector representing the time zone(s) for which to calculate the offset.
  #' @param datetime A POSIXct object or vector representing the datetime(s) for which to calculate the offset. Default is the current system time.
  #' @return A character vector representing the offset(s) from UTC in the format "HH:MM".
  #' @examples
  #' time_zone_offset(c("America/New_York", "Europe/London", "Asia/Tokyo"))
  
  # If tz is not a character vector, or if it has zero length, return an error
  if (!is.character(tz) || length(tz) == 0) {
    stop("Invalid time zone provided. tz should be a non-empty character vector.")
  }
  
  # Handle vectorized datetime input
  if (length(datetime) != length(tz) && length(datetime) > 1) {
    stop("Length of datetime vector and tz vector must be the same.")
  }
  
  # Validate each time zone and give a warning for invalid ones
  valid_tz <- tz %in% OlsonNames()
  if (any(!valid_tz)) {
    warning("Invalid time zones detected. Returning NA for these entries.")
  }
  
  # Vectorized computation of time zone offset
  offsets <- sapply(seq_along(tz), function(i) {
    zone <- tz[i]
    
    # If the time zone is not valid, return NA
    if (!valid_tz[i]) {
      return(NA_character_)
    }
    
    # Handle NA datetime
    if (is.na(datetime[i])) {
      return(NA_character_)
    }
    
    # Get the time in the specified time zone
    current_time <- with_tz(datetime[i], zone)
    
    # Calculate the offset in minutes
    offset_minutes <- as.numeric(format(current_time, "%z"))
    
    # Convert the offset to hours and minutes
    offset_hours <- offset_minutes %/% 100
    offset_minutes <- offset_minutes %% 100
    
    # Return the offset as a string in the format "HH:MM"
    return(sprintf("%+03d:%02d", offset_hours, offset_minutes))
  })
  
  return(offsets)
}

# Example usage:
tz_vector <- c("America/New_York", "Europe/London", "Asia/Tokyo", "Invalid/TimeZone")
datetime_vector <- c(Sys.time(), Sys.time(), Sys.time(), Sys.time())
offsets <- time_zone_offset(tz_vector, datetime_vector)
print(offsets)

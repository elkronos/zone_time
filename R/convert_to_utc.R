convert_to_utc <- function(times, timezones) {
  #' Convert local times to UTC format.
  #'
  #' This function takes vectors of local times and their corresponding timezones,
  #' and converts each local time to UTC format.
  #'
  #' @param times A character vector representing local times.
  #' @param timezones A character vector representing the timezones corresponding to each local time.
  #'
  #' @return A character vector representing the local times converted to UTC format.
  #'
  #' @details If the length of times and timezones are not the same, an error is raised.
  #'   If an invalid time or timezone is provided, a warning is issued for that index and NA is returned for that entry.
  
  # Validate lengths of input vectors
  if(length(times) != length(timezones)) stop("Length of times and timezones must be the same")
  
  # Initialize an empty vector to store the results
  utc_times <- character(length(times))
  
  # Loop over each element and convert to UTC
  for(i in seq_along(times)) {
    # Convert the local time to a POSIXct object with the specified timezone
    local_time <- as.POSIXct(times[i], tz = timezones[i])
    
    # Check if the conversion was successful
    if (is.na(local_time)) {
      # Issue a warning if the local time or timezone is invalid
      warning(paste("Invalid time or timezone provided at index", i))
      # Set the result for this index to NA
      utc_times[i] <- NA
    } else {
      # Format the POSIXct object in UTC timezone and store the result
      utc_times[i] <- format(local_time, tz = "UTC", usetz = TRUE)
    }
  }
  
  # Return the vector of UTC times
  return(utc_times)
}

# Example usage:
# Create a data frame with a column of time values and a corresponding timezone column
df <- data.frame(
  time = c("2023-09-23 12:00:00", "2023-09-23 14:00:00", "2023-09-23 16:00:00"),
  tz = c("America/New_York", "Europe/London", "Asia/Tokyo")
)

# Apply the convert_to_utc function to the entire columns
df$utc_time <- convert_to_utc(df$time, df$tz)

# Print the resulting data frame
print(df)

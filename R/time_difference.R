# Load library
library(lubridate)

# Define the time_difference function to calculate the difference in minutes between two time zones
time_difference <- function(tz1_vec, tz2_vec) {
  #' Calculate Time Difference between Time Zones
  #'
  #' This function calculates the absolute time difference in minutes between pairs of time zones.
  #' The function takes two vectors of time zone names as input, and for each pair, it calculates 
  #' the time difference based on the current time in each time zone.
  #'
  #' @param tz1_vec Character vector, representing the first set of time zones.
  #' @param tz2_vec Character vector, representing the second set of time zones.
  #'                The length of tz2_vec should be the same as tz1_vec.
  #' @return A numeric vector representing the time difference in minutes between each pair of time zones.
  #' @examples
  #' time_difference(c("America/New_York", "Asia/Tokyo"), c("Europe/London", "Europe/Berlin"))
  
  sapply(seq_along(tz1_vec), function(i) {
    tz1 <- tz1_vec[i]
    tz2 <- tz2_vec[i]
    
    # Validate the input time zones
    if (!tz1 %in% OlsonNames() || !tz2 %in% OlsonNames()) {
      stop("Invalid time zone provided. Use OlsonNames() to view available time zones.")
    }
    
    # Get the current time in both time zones
    time_tz1 <- force_tz(Sys.time(), tz1)
    time_tz2 <- force_tz(Sys.time(), tz2)
    
    # Calculate the absolute difference in minutes and round to the nearest minute
    diff_minutes <- round(abs(as.numeric(difftime(time_tz1, time_tz2, units = "mins"))))
    
    return(diff_minutes)
  })
}

# Example usage:
df <- data.frame(
  tz1 = c("America/New_York", "Asia/Tokyo"),
  tz2 = c("Europe/London", "Europe/Berlin")
)

# Calculate time difference in minutes and formatted
df$time_diff_minutes <- time_difference(df$tz1, df$tz2)
df$time_diff_formatted <- sprintf("%d hours and %d minutes", df$time_diff_minutes %/% 60, df$time_diff_minutes %% 60)

# Print the current time in each time zone for verification
df$current_time_tz1 <- sapply(df$tz1, function(tz) as.character(force_tz(Sys.time(), tz)))
df$current_time_tz2 <- sapply(df$tz2, function(tz) as.character(force_tz(Sys.time(), tz)))

# Print the resulting dataframe
print(df)

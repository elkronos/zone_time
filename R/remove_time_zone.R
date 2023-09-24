# Define the remove_time_zone function
remove_time_zone <- function(datetime) {
  # Function Documentation:
  #' Remove the timezone attribute from a POSIXct object
  #'
  #' @param datetime POSIXct, a datetime object with or without a timezone attribute.
  #' @return POSIXct, a datetime object without a timezone attribute.
  # Convert datetime to character string and then back to a POSIXct object
  # without specifying the timezone, effectively removing the timezone attribute
  datetime <- as.POSIXct(format(datetime), format="%Y-%m-%d %H:%M:%S")
  return(datetime)
}

# Create a single datetime object with a timezone
datetime_with_tz <- as.POSIXct("2023-09-23 12:00:00", tz = "America/New_York")

# Print the datetime object with timezone and its timezone attribute
cat("Datetime with Timezone:\n")
print(datetime_with_tz)
cat("Timezone attribute of datetime_with_tz:", attr(datetime_with_tz, "tzone"), "\n\n")

# Apply the remove_time_zone function
datetime_without_tz <- remove_time_zone(datetime_with_tz)

# Print the resulting datetime object without timezone and check its timezone attribute
cat("Datetime without Timezone:\n")
print(datetime_without_tz)
cat("Timezone attribute of datetime_without_tz:", attr(datetime_without_tz, "tzone"), "\n")

# Define the enhanced add_time_zone function
add_time_zone <- function(datetime, tz) {
  #' Add Time Zone to Datetime Objects
  #'
  #' This function takes a vector of datetime objects and a corresponding vector of time zone strings,
  #' and returns a new datetime vector where each datetime object has been assigned the corresponding time zone.
  #'
  #' @param datetime POSIXct vector, representing the datetime objects to which the time zones will be added.
  #' @param tz Character vector, representing the time zones to be assigned to the datetime objects.
  #'           The length of tz should be the same as the length of datetime.
  #' @return A POSIXct vector with the same length as the input, where each datetime object has the assigned time zone.
  if(length(datetime) != length(tz)) {
    stop("Length of datetime vector and tz vector must be the same.")
  }
  
  # Loop over each element of the datetime vector and assign the corresponding timezone
  new_datetime <- vector("list", length(datetime))
  for(i in seq_along(datetime)) {
    new_datetime[[i]] <- as.POSIXct(format(datetime[i], tz = tz[i]))
  }
  
  # Convert the list to a POSIXct object
  new_datetime <- do.call(c, new_datetime)
  return(new_datetime)
}

# Define a dataframe
df <- data.frame(
  datetime = as.POSIXct(c("2023-09-23 12:00:00", "2023-09-24 12:00:00", "2023-09-25 12:00:00"), tz = "UTC")
)

# Define a vector of time zones
tz_vector <- c("America/New_York", "Europe/London", "Asia/Tokyo")

# Apply the add_time_zone function to the datetime column with different time zones for each element
df$new_datetime <- add_time_zone(df$datetime, tz_vector)

# Print the resulting dataframe
print(df)

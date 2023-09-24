# Define the function is_dst
is_dst <- function(time, tz) {
  # Function Documentation:
  #' Check if Daylight Saving Time (DST) is in effect for a given time and time zone
  #'
  #' @param time Character, a string representing the time in 'YYYY-MM-DD HH:MM:SS' format.
  #' @param tz Character, a string representing the time zone.
  #' @return Logical, TRUE if DST is in effect, FALSE otherwise.
  
  # Check if the input parameters are of the correct type
  if(!is.character(time) || !is.character(tz)){
    stop("Error: Both time and tz need to be of type character.")
  }
  
  # Check if the provided time zone is valid
  if(!tz %in% OlsonNames()){
    stop("Error: Invalid time zone. Please provide a valid time zone.")
  }
  
  # Try to convert the time string to a POSIXct object with the specified time zone
  # Stop and display an error message if the conversion fails
  time_posix <- tryCatch(
    as.POSIXct(time, tz = tz),
    error = function(e) stop("Error: Invalid time string format. Please provide time in 'YYYY-MM-DD HH:MM:SS' format.")
  )
  
  # Convert the POSIXct object to a POSIXlt object to access the isdst attribute
  time_posixlt <- as.POSIXlt(time_posix)
  
  # Return whether Daylight Saving Time (DST) is in effect
  return(as.logical(time_posixlt$isdst))
}

# Example Usage:
# Check if DST is in effect on '2023-07-01 12:00:00' in 'America/New_York' time zone
result <- is_dst('2023-07-01 12:00:00', 'America/New_York')

# Print the result
if(result){
  cat("Daylight Saving Time is in effect.\n")
} else {
  cat("Daylight Saving Time is not in effect.\n")
}

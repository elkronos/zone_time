library(lubridate)

format_with_timezone <- function(time, format_str = "%Y-%m-%d %H:%M:%S %Z", to_tz = NULL) {
  #' Format a datetime object or a column of datetime objects with time zone information.
  #'
  #' This function takes a datetime object or a column of datetime objects and
  #' optionally converts them to a specified time zone before formatting them
  #' according to the provided format string.
  #'
  #' @param time A POSIXct object or a vector of POSIXct objects.
  #' @param format_str A character string specifying the desired format.
  #'   Default is "%Y-%m-%d %H:%M:%S %Z".
  #' @param to_tz A character string specifying the target time zone. If provided,
  #'   the datetime object is converted to this time zone before formatting.
  #'   Default is NULL (no conversion).
  #'
  #' @return A character string or a character vector representing the formatted datetime object(s)
  #'   with time zone information.
  
  # Apply the formatting function to each element of the time object if it is a vector
  formatted_time <- vapply(time, function(t) {
    # Check if the time object is NA
    if (is.na(t)) {
      stop("The time object is NA. Please provide a valid POSIXct or POSIXlt object.")
    }
    
    # Check if the time object is of class POSIXct or POSIXlt
    if (!inherits(t, "POSIXt")) {
      stop("The time object must be of class POSIXct or POSIXlt.")
    }
    
    # Check if format_str is a character string
    if (!is.character(format_str) || length(format_str) != 1) {
      stop("The format_str must be a single character string.")
    }
    
    # If a target time zone is specified, validate and convert the time object to that time zone
    if (!is.null(to_tz)) {
      if (!is.character(to_tz) || length(to_tz) != 1) {
        stop("The to_tz must be a single character string representing a valid time zone.")
      }
      if (!to_tz %in% OlsonNames()) {
        stop("The to_tz is not a valid time zone.")
      }
      t <- with_tz(t, tzone = to_tz)
    }
    
    # Check if time zone information is available
    if (is.na(attr(t, "tzone"))) {
      warning("Time zone information is not available. The time object may be printed without time zone information.")
    }
    
    # Format the datetime object using the provided format string
    format(t, format_str)
  }, character(1))
  
  return(formatted_time)
}

# Example usage with a vector of POSIXct objects
time_vector <- as.POSIXct(c("2023-09-23 12:34:56", "2023-09-24 13:45:57"), tz = "UTC")
format_str <- "%Y-%m-%d %H:%M:%S %Z"
formatted_time_vector <- format_with_timezone(time_vector, format_str, to_tz = "America/New_York")
print(formatted_time_vector)
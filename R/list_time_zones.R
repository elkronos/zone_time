# Define the function list_time_zones
list_time_zones <- function(query = NULL, limit = Inf, details = FALSE) {
  #' List available time zones
  #'
  #' This function returns a vector of time zone names that are available in R.
  #' The user can filter the list based on a query, limit the number of results, 
  #' and request additional details like abbreviations and current offsets.
  #'
  #' @param query Character, optional query string to filter the time zone names.
  #'              Default is NULL, which means no filtering.
  #' @param limit Numeric, the maximum number of time zones to return. 
  #'              Default is Inf, which means return all available time zones.
  #' @param details Logical, whether to include time zone abbreviations and current offsets.
  #'                Default is FALSE.
  #' @return A character vector of time zone names, optionally including abbreviations and offsets.
  
  # Retrieve all available time zones
  time_zones <- OlsonNames()
  
  # Filter time zones based on the query string if provided
  if (!is.null(query)) {
    time_zones <- time_zones[grep(query, time_zones, ignore.case = TRUE)]
  }
  
  # Sort the time zones alphabetically
  time_zones <- sort(time_zones)
  
  # Limit the number of time zones returned
  time_zones <- head(time_zones, limit)
  
  # Optionally include time zone abbreviations and current offsets
  if (details) {
    abbreviations <- sapply(time_zones, function(tz) {
      format(as.POSIXct(Sys.time(), tz = tz), "%Z")
    })
    offsets <- sapply(time_zones, function(tz) {
      format(as.POSIXct(Sys.time(), tz = tz), "%z")
    })
    time_zones <- paste(time_zones, abbreviations, offsets)
  }
  
  return(time_zones)
}

# Example usage:
available_time_zones <- list_time_zones(query = "America", limit = 5, details = TRUE)
print(available_time_zones)

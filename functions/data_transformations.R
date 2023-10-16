


transform_metadata_to_df <- function(metadata){
  metadata[[1]] %>% 
    map(as_tibble) %>% 
    bind_rows() %>% 
    mutate(latestData = map_chr(latestData, 1, .default = NA_character_)) %>% 
    mutate(latestData = as_datetime(latestData, tz = "UTC")) %>%
    unnest_wider(location) %>% 
    unnest_wider(latLon)
}


to_iso8601 <- function(datetime, offset){
  dt <- datetime + days(offset)
  datestring <- iso8601(dt)
  datestring <- paste(datestring, "Z", sep = "")
  return(datestring)
}




transform_volumes <- function(api_data) {
  volumes_df <- api_data$trafficData$volume$byHour$edges %>%
    map_df(~ {
      node <- .x$node
      list(
        from = as.POSIXct(node$from, tz = "UTC"),
        to = as.POSIXct(node$to, tz = "UTC"),
        volume = node$total$volumeNumbers$volume
      )
    })
  return(volumes_df)
}


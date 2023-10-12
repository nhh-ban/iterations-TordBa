transform_metadata_to_df <- function(metadata){
  metadata[[1]] %>% 
    map(as_tibble) %>% 
    bind_rows() %>% 
    mutate(latestData = map_chr(latestData, 1, .default = NA_character_)) %>% 
    mutate(latestData = as_datetime(latestData, tz = "Europe/Berlin")) %>%
    unnest_wider(location) %>% 
    unnest_wider(latLon)
}
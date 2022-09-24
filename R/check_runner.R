check_runner <- function(x, chex) {
  purrr::map_df(chex, ~ do.call(.x, list(x=x)))
}

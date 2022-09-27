#' Create a Data Quality Check Suite
#'
#' @param ... a list of data quality checks
#'
#' @return a Data Quality Check Suite object
#' @export
#'
dqc_suite <- function(...) {
  checks <- list(...)
  runner <- suite_runner(checks)
  structure(runner, class = "dqc_suite", checks = checks)
}

suite_runner <- function(checks) {
  function(x) dqc_results(purrr::map(checks, ~ do.call(.x, list(x = x))))
}

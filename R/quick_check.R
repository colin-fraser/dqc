#' Quick Checks
#'
#' @param .data a data.frame or similar
#' @param ... data quality checks
#' @param .behavior what to do if checks fail
#' @param .quiet_pass do you want a message if all checks pass?
#'
#' @return .data, unchanged
#' @export
#'
quick_check <- function(.data, ..., .behavior = c('inform', 'warn', 'stop'),
                        .quiet_pass = FALSE) {
  .behavior <- match.arg(.behavior)
  check_suite <- dqc_suite(...)
  result <- check_suite(.data)
  pass <- all_pass(result)
  if (.quiet_pass & pass) {
    return(.data)
  }
  dq_summary(result)
  if (!pass) {
    switch(.behavior,
           'inform' = message('Data quality checks failed'),
           'warn' = warning('Data quality checks failed'),
           'stop' = stop('Data quality checks failed'))
  }
  .data
}

#' Data Quality Check Suite Results
#'
#' @param x a list of data quality check results
#'
#' @return A dqc_results object
#' @export
#'
dqc_results <- function(x) {
  result_tibble <- purrr::map_df(x, tibble::as_tibble)
  structure(list(result_tibble = result_tibble), class = 'dqc_results')
}

all_pass <- function(x) {
  all(x$result_tibble$check_passed)
}

failed_checks <- function(x) {
  x$result_tibble$check_name[!x$result_tibble$check_passed]
}

passed_checks <- function(x) {
  x$result_tibble$check_name[x$result_tibble$check_passed]
}

n_checks <- function(x) {
  nrow(x$result_tibble)
}

n_passed_checks <- function(x) {
  sum(x$result_tibble$check_passed)
}

dqc_suite_check_names <- function(x) {
  x$result_tibble$check_name
}

#' @export
as.logical.dqc_results <- function(x, ...) {
  x$result_tibble$check_passed
}

dq_summary <- function(x) {
  n_checks <- n_checks(x)
  n_passed <- n_passed_checks(x)

  if (n_checks == n_passed) {
    cli::cli_alert_success("All checks passed")
  }

  else {
    cli::cli({
      bullet_types <- ifelse(x, 'v', 'x')
      cli::cli_alert_info("{n_passed} out of {n_checks} passed.")
      cli::cli_rule()
      out  <- dqc_suite_check_names(x)
      names(out) <- bullet_types
      cli::cli_bullets(out)
    })
  }
}

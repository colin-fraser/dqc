#' The result of a Data Quality Check
#'
#' @param check_name the name of the check
#' @param expected_output the expected output of the check
#' @param check_passed did the check pass?
#' @param error_message if an error was thrown, the content of the message
#' @param ... currently unused
#'
#' @return a dqc_result object
#' @export
#'
dqc_result <- function(check_name, expected_output, check_passed,
                       error_message, ...) {
  structure(list(
    check_name = check_name,
    expected_output = expected_output,
    check_passed = check_passed,
    error_message = error_message
  ), class = c('dqc_result', 'list'))
}

dqc_passed <- function(x) {
  x$check_passed
}

dqc_failed <- function(x) {
  !x$dqc_passed
}

dqc_status <- function(x) {
  if (dqc_passed(x)) {
    'Passed'
  } else {
    'Failed'
  }
}

#' @rdname dqc_result
#' @param x a dqc_result object
#' @param ... unused
#' @export
format.dqc_result <- function(x, ...) {
  paste(dqc_status(x), 'data quality check:', x$check_name)
}

#' @rdname dqc_result
#' @export
print.dqc_result <- function(x, ...) {
  cat(paste0(format(x), '\n'))
  invisible(x)
}

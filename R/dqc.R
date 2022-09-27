#' Create a Data Quality Check
#'
#' @param check_name the name of the check
#' @param f the check function
#' @param expected_output expected output of the check
#'
#' @return a dqc object
#' @export
#'
dqc <- function(check_name, f, expected_output = TRUE) {
  checker <- function(x) {
    result <- NULL
    check_passed <- FALSE
    error_message <- tryCatch(
      error = parse_dqc_error,
      {
        result <- f(x)
        check_passed <- result == expected_output
        if (length(check_passed) > 1) {
          cli::cli_abort("Malformed data quality check `{check_name}`: should return a vector of length 1")
        }
        NA
      }
    )
    dqc_result(check_name, expected_output, check_passed, error_message = error_message)
  }
  structure(checker, class = "dqc", name = check_name)
}


parse_dqc_error <- function(cnd) {
  rlang::warn("A data quality check threw an error!")
  if (grepl("\\.chex = ", conditionMessage(cnd))) {
    return(conditionMessage(cnd$parent))
  }
  conditionMessage(cnd)
}


#' @rdname dqc
#' @export
#'
#' @param x a dqc object
#' @param ... unused
#'
format.dqc <- function(x, ...) {
  paste0("Data Quality Check: ", dqc_name(x))
}

#' @rdname dqc
#' @export
print.dqc <- function(x, ...) {
  cat(paste0(format(x), "\n"))
  invisible(x)
}

dqc_name <- function(x) {
  attr(x, "name")
}

dummy_check <- dqc("is data frame", is.data.frame) # for testing

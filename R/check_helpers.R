#' Check that all rows match a condition
#'
#' @param condition a condition
#' @param check_name the name of the check
#'
#' @return a data check
#' @export
#'
#' @examples
#'
#' pass <- check_all(mpg < 34)
#' pass(mtcars)
check_all <- function(condition, check_name = NULL) {
  f <- function(x) {
    result_data <- x %>%
      dplyr::mutate(.chex = {{ condition }})
    all(result_data$.chex)
  }
  if (is.null(check_name)) {
    check_name <- deparse(substitute(condition))
  }
  dqc(check_name, f, TRUE)
}

#' Check that a column is between some values
#'
#' @param col the name of the column, unquoted
#' @param lower lower bound
#' @param upper upper bound
#' @param lower_strict should the lower bound be strict? True by default
#' @param upper_strict should the upper bound be strict? False by default
#' @param check_name what do you want the check name to be called?
#' @param n bound for check_less_than and check_greater_than
#' @param strict strict bound?
#'
#' @return a data check object
#' @export
#'
check_between <- function(col, lower, upper, lower_strict = TRUE, upper_strict = FALSE,
                          check_name = NULL) {
  if (lower_strict) left <- "<" else left <- "<="
  if (upper_strict) right <- "<" else right <- "<="
  if (is.null(check_name)) {
    check_name <- paste(lower, left, deparse(substitute(col)), right, upper)
  }
  check_all(
    methods::getFunction(left)(lower, {{ col }}) & methods::getFunction(right)({{ col }}, upper),
    check_name
  )
}

#' Check that a column is less than a number
#'
#' @param col column to check
#' @param n bound
#' @param strict strict comparison?
#'
#' @describeIn check_between Check that a column is less than a number
#' @export
#'
check_less_than <- function(col, n, strict = TRUE) {
  if (strict) op <- "<" else op <- "<="
  check_name <- paste(deparse(substitute(col)), op, n)
  check_between({{ col }}, lower = -Inf, upper = n, upper_strict = strict, check_name = check_name)
}

#' Check that a column is greater than a number
#'
#' @describeIn check_between Check that a column is greater than a number
#' @export
check_greater_than <- function(col, n, strict = TRUE) {
  if (strict) op <- ">" else op <- ">="
  check_name <- paste(deparse(substitute(col)), op, n)
  check_between({{ col }}, lower = n, upper = Inf, lower_strict = strict, check_name = check_name)
}


#' Check that a column's values are contained in some set
#'
#' @param col an unquoted column
#' @param values values to check against
#'
#' @return a data check object
#' @export
#'
check_values_in <- function(col, values) {
  values_rep <- utils::capture.output(dput(values))
  check_name <- paste(deparse(substitute(col)), "%in%", values_rep)
  check_all({{ col }} %in% values, check_name)
}

#' Check that a column has no NA values
#'
#' @param col column
#'
#' @return a data check object
#' @export
#'
check_no_na <- function(col) {
  check_name <- paste0("!is.na(", deparse(substitute(col)), ")")
  check_all(!is.na({{ col }}), check_name)
}

#' Check names
#'
#' @param expected_names the expected names
#'
#' @return a dqc object
#' @export
#'
check_names <- function(expected_names) {
  dqc("names are expected", function(x) all(names(x) == expected_names))
}

#' Check that a column is not duplicated
#'
#' @param col column to check
#'
#' @return a dqc object
#' @export
#'
check_no_duplicates <- function(col) {
  check_all(!duplicated({{ col }}), paste0("!duplicated(", deparse(substitute(col)), ")"))
}

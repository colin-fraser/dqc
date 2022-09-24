check_all <- function(conditions, check_name = NULL) {
  f <- function(x) {
    result_data <- x %>%
      mutate(.chex = {{ conditions }})
    all(result_data$.chex)
  }
  if (is.null(check_name)) {
    check_name <- deparse(substitute(conditions))
  }
  data_check(check_name, f, TRUE)
}

check_between <- function(col, lower, upper, lower_strict = TRUE, upper_strict = FALSE,
                          check_name = NULL) {
  if (lower_strict) left <- "<" else left <- "<="
  if (upper_strict) right <- "<" else right <- "<="
  if (is.null(check_name)) {
    check_name <- paste(lower, left, deparse(substitute(col)), right, upper)
  }
  check_all(getFunction(left)(lower, {{col}}) & getFunction(right)({{col}}, upper),
            check_name)
}

check_less_than <- function(col, n, strict = TRUE) {
  if (strict) op <- '<' else op <- '<='
  check_name <- paste(deparse(substitute(col)), op, n)
  check_between({{col}}, lower = -Inf, upper = n, upper_strict = strict, check_name = check_name)
}

check_greater_than <- function(col, n, strict = TRUE) {
  if (strict) op <- '>' else op <- '>='
  check_name <- paste(deparse(substitute(col)), op, n)
  check_between({{col}}, lower = n, upper = Inf, lower_strict = strict, check_name = check_name)
}

check_values_in <- function(col, values) {
  values_rep <- capture.output(dput(values))
  check_name <- paste(deparse(substitute(col)), '%in%', values_rep)
  check_all({{ col }} %in% values, check_name)
}

check_no_na <- function(col) {
  check_name <- paste0("!is.na(", deparse(substitute(col)), ")")
  check_all(!is.na({{ col }}), check_name)
}

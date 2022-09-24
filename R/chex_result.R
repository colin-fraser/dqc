all_pass <- function(x) {
  all(x$check_passed)
}

failed_checks <- function(x) {
  x$check_name[!x$check_passed]
}

passed_checks <- function(x) {
  x$check_name[x$check_passed]
}

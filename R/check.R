data_check <- function(check_name, f, expected_output = TRUE) {
  function(x) {
    result <- f(x)
    check_passed <- result == expected_output
    tibble::tibble(check_name = check_name, expected_output = expected_output,
           check_passed = check_passed)
  }
}

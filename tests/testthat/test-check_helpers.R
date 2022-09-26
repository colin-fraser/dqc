run_suite_on_mtcars <- function(...) {
  suite <- dqc_suite(...)
  suite(mtcars)
}

test_that("check_all", {
  pass <- check_all(mpg < 34)
  fail <- check_all(mpg < 33)
  expect_snapshot(pass(mtcars))
  expect_snapshot(fail(mtcars))

  results <- run_suite_on_mtcars(pass, fail)
  expect_false(all_pass(results))
  expect_equal(failed_checks(results), 'mpg < 33')
})

test_that("check_between", {
  pass_1 <- check_between(mpg, 10, 35, lower_strict = FALSE)
  fail_1 <- check_between(mpg, 10, 33.9, upper_strict = TRUE)
  results <- run_suite_on_mtcars(pass_1, fail_1)
  expect_false(all_pass(results))
  expect_equal(failed_checks(results), "10 < mpg < 33.9")
  expect_equal(passed_checks(results), "10 <= mpg <= 35")
})

test_that("check_less_than", {
  results <- run_suite_on_mtcars(
    check_less_than(mpg, 35),
    check_less_than(mpg, 0, strict = FALSE))
  expect_equal(passed_checks(results), 'mpg < 35')
  expect_equal(failed_checks(results), 'mpg <= 0')
})

test_that("check_greater_than", {
  results <- run_suite_on_mtcars(
    check_greater_than(mpg, 0),
    check_greater_than(mpg, 100, strict = FALSE)
  )
  expect_equal(passed_checks(results), 'mpg > 0')
  expect_equal(failed_checks(results), 'mpg >= 100')
})

test_that("check_values_in", {
  results <- run_suite_on_mtcars(
    check_values_in(am, c(0, 1)),
    check_values_in(mpg, c(0, 1))
  )
  expect_equal(passed_checks(results), 'am %in% c(0, 1)')
  expect_equal(failed_checks(results), 'mpg %in% c(0, 1)')
})

test_that("no_nas", {
  fail <- check_no_na(col1)
  pass <- check_no_na(col2)
  df <- data.frame(col1 = c(1, NA), col2 = c(1, 2))
  results <- dqc_suite(fail, pass)(df)
  expect_equal(passed_checks(results), '!is.na(col2)')
  expect_equal(failed_checks(results), '!is.na(col1)')
}
)

test_that("check_all", {
  pass <- check_all(mpg < 34)
  fail <- check_all(mpg < 33)
  expect_snapshot(pass(mtcars))
  expect_snapshot(fail(mtcars))

  chex_results <- check_runner(mtcars, list(pass, fail))
  expect_false(all_pass(chex_results))
  expect_equal(failed_checks(chex_results), 'mpg < 33')
})

test_that("check_between", {
  pass_1 <- check_between(mpg, 10, 35, lower_strict = FALSE)
  fail_1 <- check_between(mpg, 10, 33.9, upper_strict = TRUE)
  chex_results <- check_runner(mtcars, list(pass_1, fail_1))
  expect_false(all_pass(chex_results))
  expect_equal(failed_checks(chex_results), "10 < mpg < 33.9")
  expect_equal(passed_checks(chex_results), "10 <= mpg <= 35")
})

test_that("check_less_than", {
  pass_1 <- check_less_than(mpg, 35)
  fail_1 <- check_less_than(mpg, 0, strict = FALSE)
  chex_results <- check_runner(mtcars, list(pass_1, fail_1))
  expect_equal(passed_checks(chex_results), 'mpg < 35')
  expect_equal(failed_checks(chex_results), 'mpg <= 0')
})

test_that("check_greater_than", {
  pass_1 <- check_greater_than(mpg, 0)
  fail_1 <- check_greater_than(mpg, 100, strict = FALSE)
  chex_results <- check_runner(mtcars, list(pass_1, fail_1))
  expect_equal(passed_checks(chex_results), 'mpg > 0')
  expect_equal(failed_checks(chex_results), 'mpg >= 100')
})

test_that("check_values_in", {
  pass_1 <- check_values_in(am, c(0, 1))
  fail_1 <- check_values_in(mpg, c(0, 1))
  chex_results <- check_runner(mtcars, list(pass_1, fail_1))
  expect_equal(passed_checks(chex_results), 'am %in% c(0, 1)')
  expect_equal(failed_checks(chex_results), 'mpg %in% c(0, 1)')
})

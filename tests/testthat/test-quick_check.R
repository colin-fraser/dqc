test_that("quick_check", {
  expect_warning(quick_check(mtcars, check_between(mpg, 10, 20), .behavior = "warn"))
  expect_error(quick_check(mtcars, check_between(mpg, 10, 20), .behavior = "stop"))
  expect_equal(quick_check(mtcars, check_between(mpg, 0, 40), .behavior = "stop"), mtcars)
  expect_equal(quick_check(mtcars, check_between(mpg, 20, 30), .behavior = "inform"), mtcars)
  expect_silent(quick_check(mtcars, check_between(mpg, 0, 40),
    .behavior = "stop",
    .quiet_pass = TRUE
  ))
})

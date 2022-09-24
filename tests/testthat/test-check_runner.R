test_that("check_runner works", {
  passer <- data_check("all mpg < 34", function(x) all(x$mpg < 34))
  failer <- data_check("all mpg < 34", function(x) all(x$mpg < 33))
  chex <- list(passer, failer)
  expect_snapshot(check_runner(mtcars, chex))
})

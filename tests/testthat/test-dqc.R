test_that("Creating a dqc", {
  check <- dqc("object is dataframe", is.data.frame)
  expect_s3_class(check, "dqc")
  expect_type(check, "closure")
  expect_equal(dqc_name(check), "object is dataframe")
  expect_snapshot(check)
})

test_that("dqc fails gracefully when columns don't exist", {
  check <- check_between(abc, 0, 100)
  expect_warning(check(mtcars), regexp = "A data quality check threw an error")
  expect_equal(check(mtcars)$error_message, "object 'abc' not found")
}
)

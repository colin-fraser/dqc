test_that("Creating a dqc", {
  check <- dqc("object is dataframe", is.data.frame)
  expect_s3_class(check, "dqc")
  expect_type(check, "closure")
  expect_equal(dqc_name(check), "object is dataframe")
  expect_snapshot(check)
})

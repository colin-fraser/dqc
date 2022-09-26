dq1 <- dqc('all mpg < 35', function(x) all(x$mpg < 35))
dq2 <- dqc('all mpg < 30', function(x) all(x$mpg < 30))

ste1 <- dqc_suite(dq1)
ste2 <- dqc_suite(dq2)
ste12 <- dqc_suite(dq1, dq2)

test_that("all_pass", {
  expect_true(all_pass(ste1(mtcars)))
  expect_false(all_pass(ste2(mtcars)))
  expect_false(all_pass(ste12(mtcars)))
  expect_equal(passed_checks(ste12(mtcars)), 'all mpg < 35')
  expect_equal(failed_checks(ste12(mtcars)), 'all mpg < 30')
})

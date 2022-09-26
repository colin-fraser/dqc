

dq1 <- dqc('all mpg < 35', function(x) all(x$mpg < 35))
dq2 <- dqc('all mpg < 30', function(x) all(x$mpg < 30))
suite <- dqc_suite(dq1, dq2)
mtcars %>%
  suite()

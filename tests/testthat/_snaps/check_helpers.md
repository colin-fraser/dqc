# check_all

    Code
      pass(mtcars)
    Output
      # A tibble: 1 x 3
        check_name expected_output check_passed
        <chr>      <lgl>           <lgl>       
      1 mpg < 34   TRUE            TRUE        

---

    Code
      fail(mtcars)
    Output
      # A tibble: 1 x 3
        check_name expected_output check_passed
        <chr>      <lgl>           <lgl>       
      1 mpg < 33   TRUE            FALSE       


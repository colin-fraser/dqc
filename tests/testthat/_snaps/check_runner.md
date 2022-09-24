# check_runner works

    Code
      check_runner(mtcars, chex)
    Output
      # A tibble: 2 x 3
        check_name   expected_output check_passed
        <chr>        <lgl>           <lgl>       
      1 all mpg < 34 TRUE            TRUE        
      2 all mpg < 34 TRUE            FALSE       


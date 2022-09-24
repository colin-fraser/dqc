
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chex

<!-- badges: start -->
<!-- badges: end -->

The goal of chex is to …

## Installation

You can install the development version of chex like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(chex)

chex <- list(
  check_all(vs %in% c(0, 1)),
  check_between(mpg, 0, 50)
)
check_runner(mtcars, chex)
#> # A tibble: 2 × 3
#>   check_name      expected_output check_passed
#>   <chr>           <lgl>           <lgl>       
#> 1 vs %in% c(0, 1) TRUE            TRUE        
#> 2 0 < mpg <= 50   TRUE            TRUE
```

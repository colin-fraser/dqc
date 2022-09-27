
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Data Quality Checks

<!-- badges: start -->

[![R-CMD-check](https://github.com/colin-fraser/dqc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/colin-fraser/dqc/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`{dqc}` aims to create a simple and intuitive data quality check API.

## Installation

You can install the development version of `{dqc}` like so:

``` r
# devtools::install_github('colin-fraser/dqc')
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(dqc)

mtcars_check_suite <- dqc_suite(
  check_between(mpg, 0, 40),
  check_values_in(vs, c(0, 1))
)
mtcars_check_suite(mtcars)
#> $result_tibble
#> # A tibble: 2 × 3
#>   check_name      expected_output check_passed
#>   <chr>           <lgl>           <lgl>       
#> 1 0 < mpg <= 40   TRUE            TRUE        
#> 2 vs %in% c(0, 1) TRUE            TRUE        
#> 
#> attr(,"class")
#> [1] "dqc_results"
```

The `quick_checks` interface can be useful, especially when reading data
in through a pipeline.

``` r
df <- mtcars %>% 
  quick_check(
    check_between(mpg, 10, 30),
    check_no_na(gear),
    check_names(c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", 
"gear", "carb"))
  )
#> ℹ 2 out of 3 passed.
#> ────────────────────────────────────────────────────────────────────────────────
#> ✖ 10 < mpg <= 30
#> ✔ !is.na(gear)
#> ✔ names are expected
#> Data quality checks failed
```

By default, `quick_check` informs you about data quality check failures
but does not impede your work, returning its input without changes.

``` r
head(df)
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

But this can be changed.

``` r
df <- mtcars %>% 
  quick_check(
    check_between(mpg, 10, 30),
    check_no_na(gear),
    .behavior = 'stop'
  )
#> ℹ 1 out of 2 passed.
#> ────────────────────────────────────────────────────────────────────────────────
#> ✖ 10 < mpg <= 30
#> ✔ !is.na(gear)
#> Error in quick_check(., check_between(mpg, 10, 30), check_no_na(gear), : Data quality checks failed
```

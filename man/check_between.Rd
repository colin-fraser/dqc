% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_helpers.R
\name{check_between}
\alias{check_between}
\alias{check_less_than}
\alias{check_greater_than}
\title{Check that a column is between some values}
\usage{
check_between(
  col,
  lower,
  upper,
  lower_strict = TRUE,
  upper_strict = FALSE,
  check_name = NULL
)

check_less_than(col, n, strict = TRUE)

check_greater_than(col, n, strict = TRUE)
}
\arguments{
\item{col}{column to check}

\item{lower}{lower bound}

\item{upper}{upper bound}

\item{lower_strict}{should the lower bound be strict? True by default}

\item{upper_strict}{should the upper bound be strict? False by default}

\item{check_name}{what do you want the check name to be called?}

\item{n}{bound}

\item{strict}{strict comparison?}
}
\value{
a data check object
}
\description{
Check that a column is between some values

Check that a column is less than a number

Check that a column is greater than a number
}
\section{Functions}{
\itemize{
\item \code{check_less_than}: Check that a column is less than a number

\item \code{check_greater_than}: Check that a column is greater than a number
}}


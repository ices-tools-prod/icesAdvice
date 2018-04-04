#' ICES Rounding Method
#'
#' Round values according to the ICES Advice Technical Guidelines.
#'
#' @param x the values to round.
#' @param percent whether to format values with a percent suffix.
#' @param sign whether to format values with a sign prefix.
#' @param na what to return when x is \code{NA}.
#'
#' @return
#' Rounded values as a \code{noquote} string vector, retaining trailing zeros.
#'
#' @note
#' This function implements the following ICES rounding method:
#' \tabular{rl}{
#'    i) \tab Round to two significant figures when the first non-zero digit is
#'            2 or larger.\cr
#'   ii) \tab Round to three significant figures when the first non-zero digit
#'            is 1.
#' }
#' As indicated in the ICES (2017) technical guidelines, this rounding method
#' should not be applied to biomass, catch, or number of individuals. For those
#' quantities, use the normal \code{\link{round}} function instead.
#'
#' @author Colin Millar and Arni Magnusson.
#'
#' @references
#' ICES (2017) Rounding rules to be applied in ICES advice.
#' \href{https://doi.org/10.17895/ices.pub.3038}{\emph{ICES Advice Technical
#' Guidelines 16.5.3}}.
#'
#' @seealso
#' \code{\link{signif}} rounds values to a specified number of significant
#' digits.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' icesRound(0.123456)
#' icesRound(0.2468)
#'
#' ## Formatted string or numeric
#' icesRound(1.0)
#' as.numeric(icesRound(1.0))
#'
#' ## Percent, sign, NA
#' icesRound(33.33, percent = TRUE)
#' icesRound(33.33, sign = TRUE)
#' icesRound(c(1, NA, 3))
#' icesRound(c(1, NA, 3), na = NA)
#'
#' ## Example from the ICES Technical Guidelines
#' Actual <- c(0.35776, 0.34665, 0.202, 0.12665, 0.001567, 0.002567, 0.013415,
#'             0.02315, 1.168, 2.15678)
#' Rounded <- icesRound(Actual)
#' print(data.frame(Actual = as.character(Actual), Rounded), row.names = FALSE)
#'
#' ## Continued example from Guidelines, now rounding percentages
#' Actual <- c(9.546, 10.546, 23.445, -1.482, -9.09, 0.51, 130.11, 584)
#' Rounded <- icesRound(Actual, percent = TRUE)
#' print(data.frame(Actual = as.character(Actual), Rounded), row.names = FALSE)
#'
#' @export

icesRound <- function(x, percent = FALSE, sign = percent, na = "")
{
  # work on log base 10 scale
  log10_x <- log10(abs(x))

  # calculate significant figures
  sf <- as.integer(log10_x %% 1 < log10(2)) + 2

  # calculate number of decimal places needed
  digits <- pmax(0, sf - 1 - floor(log10_x))

  # special exception when x == 0
  digits[x == 0] <- 2
  sf[x == 0] <- 0

  # suppress error when x is NA
  digits[is.na(x)] <- 0

  # format values
  fmt <- paste0(if (sign) "%+." else "%.",
                digits,
                if (percent) "f%%" else "f")
  out <- sprintf(fmt, signif(x, sf))
  out[is.na(x)] <- na

  noquote(out)
}

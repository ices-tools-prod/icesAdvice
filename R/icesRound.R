#' ICES Rounding Method
#'
#' Round a value according to the ICES Advice Technical Guidelines.
#'
#' @param x the value(s) to round.
#'
#' @return Rounded value(s) as a \code{noquote} string object, retaining
#' trailing zeros.
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
#' quantities, use the normal \code{round} function instead.
#'
#' @author Arni Magnusson with a contribution by Colin Millar.
#'
#' @references
#' ICES. 2017. Rounding rules to be applied in ICES advice.
#' \href{http://ices.dk/sites/pub/Publication\%20Reports/Advice/2017/2017/16.05.03_Rounding_rules_in_ICES_advice.pdf}{\cite{ICES
#' Advice Technical Guidelines 16.5.3}}.
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
#' ## Example from the ICES Technical Guidelines
#' Actual <- c(0.35776, 0.34665, 0.202, 0.12665, 0.001567, 0.002567, 0.013415,
#'             0.02315, 1.168, 2.15678, 9.546, 10.546, 23.445, -1.482, -9.09,
#'             0.51, 130.11, 584)
#' Rounded <- icesRound(Actual)
#' print(data.frame(Actual=as.character(Actual), Rounded), row.names=FALSE)
#'
#' @export

icesRound <- function(x)
{
  if(length(x) > 1)
  {
    out <- sapply(x, icesRound)
  }
  else
  {
    x <- as.numeric(x)
    onlySig <- sub("0\\.0*", "", abs(x))
    firstSig <- substr(onlySig, 1, 1)
    if(firstSig >= 2)
    {
      value <- signif(x, 2)
      digits <- max(0, floor(-log10(abs(value))) + 2)
    }
    else
    {
      value <- signif(x, 3)
      digits <- if(value == 0) 2
                else max(0, floor(-log10(abs(value))-1e-10) + 3)
      ## 1e-10 is a small constant to make sure 1->1.00, 0.1->0.100, etc.
    }
    out <- formatC(value, format="f", digits=digits)
  }
  noquote(out)
}

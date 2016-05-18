#' Sigma from Confidence Interval
#'
#' Calculate the implicit sigma that was used to construct a confidence
#' interval.
#'
#' @param lo the lower confidence bound.
#' @param hi the upper confidence bound.
#' @param log whether the confidence interval is lognormal.
#' @param level the confidence level.
#'
#' @return Implicit value of sigma.
#'
#' @note
#' Useful for reviewing PA reference points, when the report provides a CI but
#' not the value of sigma.
#'
#' @author Arni Magnusson.
#'
#' @seealso
#' \code{\link{sigmaPA}} calculates the implicit sigma from PA reference points.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' sigmaCI(100, 200)
#'
#' @keywords distribution
#'
#' @export

sigmaCI <- function(lo, hi, log=TRUE, level=0.95)
{
  rng <- if(log) log(hi)-log(lo) else hi-lo
  alpha <- 1 - level
  z <- qnorm(1 - alpha/2)
  sigma <- 0.5*rng / z
  return(sigma)
}

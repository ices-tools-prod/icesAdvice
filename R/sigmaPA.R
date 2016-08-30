#' Sigma from PA Reference Points
#'
#' Calculate the implicit sigma that was used to calculate PA reference points
#' from limit reference points (Xpa from Xlim).
#'
#' @param lim the value of the limit reference point, e.g., Blim or Flim.
#' @param pa the value of the PA reference point, e.g., Bpa or Fpa.
#'
#' @details
#' The order of the parameters does not matter, so \code{sigmaPA(Fpa, Flim)} and
#' \code{sigmaPA(Flim, Fpa)} are equivalent.
#'
#' @return Implicit value of sigma.
#'
#' @note
#' Useful for reviewing PA reference points, when the advice sheet provides the
#' value of Xlim and Xpa but not the value of sigma.
#'
#' The inference is based on the following relationships:
#'
#' \deqn{B_\mathrm{pa} = B_\mathrm{lim} \exp(1.645\sigma_B)}{
#'       Bpa = Blim * exp(1.645*sigmaB)}
#'
#' \deqn{F_\mathrm{pa} = F_\mathrm{lim} \exp(-1.645\sigma_F)}{
#'       Fpa = Flim * exp(-1.645*sigmaF)}
#'
#' @author Arni Magnusson.
#'
#' @seealso
#' \code{\link{sigmaCI}} calculates the implicit sigma from a confidence
#' interval.
#'
#' \code{\link{Bpa}} and \code{\link{Fpa}} calculate those reference points from
#' the limit reference points, based on a given sigma.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' sigmaPA(100, 120)
#'
#' @export

sigmaPA <- function(lim, pa)
{
  refpt <- sort(c(lim, pa))
  sigma <- (log(refpt[2]) - log(refpt[1])) / 1.645
  return(sigma)
}

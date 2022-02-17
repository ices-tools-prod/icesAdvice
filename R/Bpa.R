#' Bpa from Blim
#'
#' Calculate the value of Bpa from Blim and sigmaB.
#'
#' @param Blim the value of the Blim reference point.
#' @param sigmaB the estimation uncertainty in B (standard error of logSSB in
#'        the terminal year).
#'
#' @return Value of Bpa.
#'
#' @note
#' The purpose of PA reference points is to apply a precautionary approach in
#' fisheries management.
#'
#' By comparing the current B to Bpa, one can answer the question: are we at
#' least 95\% sure that B is above Blim, given the estimation uncertainty?
#'
#' The ICES (2017) technical guidelines define Bpa as:
#'
#' \deqn{B_\mathrm{pa} = B_\mathrm{lim} \exp(1.645\sigma_B)}{
#'       Bpa = Blim * exp(1.645*sigmaB)}
#'
#' @author Arni Magnusson.
#'
#' @references
#' ICES (2017) ICES fisheries management reference points for category 1 and 2
#' stocks. \doi{10.17895/ices.pub.3036}{\emph{ICES Advice
#' Technical Guidelines 12.4.3.1}}.
#'
#' @seealso
#' \code{\link{Fpa}} calculates that reference point from Flim and sigmaF.
#'
#' \code{\link{sigmaPA}} calculates the implicit sigma from PA reference points.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' Bpa(100, 0.15)
#'
#' @export

Bpa <- function(Blim, sigmaB)
{
  Blim * exp(1.645*sigmaB)
}

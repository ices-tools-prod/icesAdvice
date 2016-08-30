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
#' By comparing the current B to Bpa, one can answer the question: are we at
#' least 95\% sure that B is above Blim, given the estimation uncertainty?
#'
#' The ICES (2016) technical guidelines define Bpa as:
#'
#' \deqn{B_\mathrm{pa} = B_\mathrm{lim} \exp(1.645\sigma_B)}{
#'       Bpa = Blim * exp(1.645*sigmaB)}
#'
#' @author Arni Magnusson.
#'
#' @references
#' ICES. 2016. Advice Technical Guidelines: ICES fisheries management reference
#' points for category 1 stocks. \cite{Draft document version 30 (2016-04-21),
#' available at the ACOM Meetings area on the ICES Sharepoint.}
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
  refpt <- Blim * exp(1.645*sigmaB)
  return(refpt)
}

#' Fpa from Flim
#'
#' Calculate the value of Fpa from Flim and sigmaF.
#'
#' @param Flim the value of the Flim reference point.
#' @param sigmaF the estimation uncertainty in F (standard error of logF in the
#'        terminal year).
#'
#' @return Value of Fpa.
#'
#' @note
#' The purpose of PA reference points is to apply a precautionary approach in
#' fisheries management.
#'
#' By comparing the current F to Fpa, one can answer the question: are we at
#' least 95\% sure that F is below Flim, given the estimation uncertainty?
#'
#' The ICES (2017) technical guidelines define Fpa as:
#'
#' \deqn{F_\mathrm{pa} = F_\mathrm{lim} \exp(-1.645\sigma_F)}{
#'       Fpa = Flim * exp(-1.645*sigmaF)}
#'
#' The \code{Fpa} function can also be used to calculate reference points based
#' on harvest rate: Hpa from Hlim and sigmaH.
#'
#' @author Arni Magnusson.
#'
#' @references
#' ICES (2017).
#' ICES fisheries management reference points for category 1 and 2 stocks.
#' \emph{ICES Advice Technical Guidelines 12.4.3.1}.
#' \doi{10.17895/ices.pub.3036}.
#'
#' @seealso
#' \code{\link{Bpa}} calculates that reference point from Blim and sigmaB.
#'
#' \code{\link{sigmaPA}} calculates the implicit sigma from PA reference points.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' Fpa(0.90, 0.15)
#'
#' @export

Fpa <- function(Flim, sigmaF)
{
  Flim * exp(-1.645*sigmaF)
}

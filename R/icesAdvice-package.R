#' @docType package
#'
#' @name icesAdvice-package
#'
#' @aliases icesAdvice
#'
#' @title Functions Related to ICES Advice
#'
#' @description
#' A collection of functions that facilitate computational steps related to
#' advice for fisheries management, according to ICES guidelines. These include
#' methods for calculating reference points and model diagnostics.
#'
#' @details
#' \emph{Calculate ICES advice:}
#' \tabular{ll}{
#'   \code{\link{DLS3.2}}    \tab DLS method 3.2\cr
#'   \code{\link{icesRound}} \tab rounding method
#' }
#' \emph{Calculate PA reference points:}
#' \tabular{ll}{
#'   \code{\link{Bpa}} \tab from Blim\cr
#'   \code{\link{Fpa}} \tab from Flim
#' }
#' \emph{Calculate sigma:}
#' \tabular{ll}{
#'   \code{\link{sigmaCI}} \tab from confidence interval\cr
#'   \code{\link{sigmaPA}} \tab from PA reference points
#' }
#' \emph{Retrospective diagnostics:}
#' \tabular{ll}{
#'   \code{\link{mohn}} \tab Mohn's rho
#' }
#' \emph{Read and write files:}
#' \tabular{ll}{
#'   \code{\link{read.dls}}  \tab read \code{DLS3.2} results from file\cr
#'   \code{\link{write.dls}} \tab write \code{DLS3.2} results to file
#' }
#' \emph{Example tables:}
#' \tabular{ll}{
#'   \code{\link{shake}} \tab Southern hake retro
#' }
#'
#' @author Arni Magnusson, Colin Millar, and Anne Cooper.
#'
#' @references
#' ICES advisory process:
#' \url{http://ices.dk/community/advisory-process/}.

NA

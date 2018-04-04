#' @docType data
#'
#' @name shake
#'
#' @title Southern Hake Retro
#'
#' @description Retrospective estimates of Southern hake fishing mortality.
#'
#' @usage
#' shake
#'
#' @format
#' Data frame containing 6 columns:
#' \tabular{ll}{
#'   \code{base} \tab base model estimates\cr
#'   \code{-1}   \tab 1st retro peel\cr
#'   \code{-2}   \tab 2nd retro peel\cr
#'   \code{-3}   \tab 3rd retro peel\cr
#'   \code{-4}   \tab 4th retro peel\cr
#'   \code{-5}   \tab 5th retro peel
#' }
#'
#' @details
#' This dataset is an example from the ICES (2018) Advice Technical Guidelines
#' on quantifying and reporting retrospective bias.
#'
#' @source
#' ICES (2018) Guidelines for calculating Mohn's rho: Retrospective bias in
#' assessment. \emph{Draft document version 7 (2018-04-03), available at the
#' Expert Groups area on the ICES Sharepoint.}
#'
#' @seealso
#' \code{\link{mohn}} calculates Mohn's rho.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' shake
#' mohn(shake)

NA

#' @docType data
#'
#' @name icod
#'
#' @title Icelandic Cod Retro
#'
#' @description
#' Retrospective estimates of Icelandic cod biomass (age 4+) in thousands of
#' tonnes.
#'
#' @usage
#' icod
#'
#' @format
#' Data frame containing 8 columns:
#' \tabular{ll}{
#'   \code{base} \tab base model estimates\cr
#'   \code{-1}   \tab 1st retro peel\cr
#'   \code{-2}   \tab 2nd retro peel\cr
#'   \code{-3}   \tab 3rd retro peel\cr
#'   \code{-4}   \tab 4th retro peel\cr
#'   \code{-5}   \tab 5th retro peel\cr
#'   \code{-6}   \tab 6th retro peel\cr
#'   \code{-7}   \tab 7th retro peel
#' }
#'
#' @details
#' The data are an excerpt (first peels) from Table 3.1.13 in the Marine
#' Research Institute (2015) assessment report.
#'
#' @source
#' Marine Research Institute (2015) State of marine stocks in Icelandic waters
#' 2014/2015 and prospects for the quota year 2015/2016.
#' \href{https://www.hafogvatn.is/static/research/files/fjolrit-182-englishpdf}{\emph{Marine
#' Research in Iceland 182}}, p. 145.
#'
#' @seealso
#' \code{\link{mohn}} calculates Mohn's rho.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' icod
#' mohn(icod)

NA

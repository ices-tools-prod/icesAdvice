#' Mohn's Rho
#'
#' Calculate Mohn's rho, the average relative bias of retrospective estimates.
#'
#' @param x a matrix or data frame containing retrospective estimates in
#'        columns, with years as row names.
#' @param peels the number of retrospective peels to use in the calculation of
#'        rho, or \code{NULL} to use all retrospective columns in \code{x}.
#' @param details whether to return the intermediate calculations of relative
#'        bias.
#' @param plot whether to plot the retrospective trajectories.
#' @param \dots passed to \code{matplot} and \code{points}.
#'
#' @details
#' The default value \code{peels = 5} is based on the ICES (2018) guidelines.
#'
#' The basic \code{plot = TRUE} functionality is intended to quickly visualize
#' the calculation of Mohn's rho. To produce a fully formatted plot, bypass the
#' \code{mohn} function and plot the \code{x} data directly.
#'
#' @return
#' Mohn's rho, along with intermediate calculations if \code{details = TRUE}.
#'
#' @note
#' Relative bias is defined as
#' \deqn{b_i=\frac{\hat\theta^{R_i}_{T\!-i}\,-\,\hat\theta_{T\!-i}}{\hat\theta_{T\!-i}}}{relbias
#' = (retro - base) / base}
#' and Mohn's rho is the average relative bias:
#' \deqn{\rho=\sum_{i=1}^n\frac{b_i}{n}}{rho = mean(relbias)}
#'
#' See Mohn (1999), Brooks and Legault (2016), ICES (2018), and
#' \code{mohn(shake, details=TRUE)} for details.
#'
#' @author Arni Magnusson, with a contribution from Ruben Verkempynck.
#'
#' @references
#' Brooks, E.N. and Legault, C.M. (2016).
#' Retrospective forecasting --- evaluating performance of stock projections in
#' New England groundfish stocks.
#' \emph{Canadian Journal of Fisheries and Aquatic Sciences}, \bold{73},
#' 935--950.
#' \doi{10.1139/cjfas-2015-0163}.
#'
#' ICES (2018).
#' Guidelines for calculating Mohn's rho: Retrospective bias in assessment.
#' \emph{Draft document version 7 (2018-04-03), available at the Expert Groups
#' area on the ICES Sharepoint.}
#'
#' ICES (2020).
#' Workshop on Catch Forecast from Biased Assessments (WKFORBIAS; outputs from
#' 2019 meeting).
#' \emph{ICES Scientific Reports 2(28)}.
#' \doi{10.17895/ices.pub.5997}.
#'
#' Mohn, R. (1999).
#' The retrospective problem in sequential population analysis: An investigation
#' using cod fishery and simulated data.
#' \emph{ICES Journal of Marine Science}, \bold{56}, 473--488.
#' \doi{10.1006/jmsc.1999.0481}.
#'
#' @seealso
#' \code{\link{shake}} is a retrospective example table.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' mohn(shake)
#' mohn(shake, details=TRUE)
#' mohn(shake, plot=TRUE)
#'
#' mohn(shake, peels=3, plot=TRUE, col="black", ylim=0:1, yaxs="i")
#' lines(as.numeric(rownames(shake)), shake$base, lwd=3)
#'
#' ## Plot last 10 years
#' x <- rbind(matrix(1,28,6,dimnames=list(1981:2008,names(shake))), shake)
#' mohn(tail(x, 10), plot=TRUE, lwd=2, main="main")
#'
#' @importFrom graphics matplot points title
#' @importFrom stats na.omit
#'
#' @export

mohn <- function(x, peels=5, details=FALSE, plot=FALSE, ...)
{
  ## 1  Check dims
  if(is.null(peels))
    peels <- ncol(x) - 1
  if(peels > ncol(x)-1)
    stop("peels cannot exceed number of retro columns")
  n <- nrow(x)

  ## 2  Extract retro
  retro <- rep(NA_real_, n)
  for(i in seq_len(peels))
    retro[n-i] <- x[n-i, 1+i]
  compare <- na.omit(data.frame(base=x[,1], retro, row.names=rownames(x)))

  ## 3  Calculate average relative bias
  compare$relbias <- (compare$retro - compare$base) / compare$base
  rho <- mean(compare$relbias)
  out <- if(details) list(compare=compare, rho=rho) else rho

  ## 4  Plot
  if(plot)
  {
    matplot(as.numeric(rownames(x)), x, type="l", lty=1, ann=FALSE, ...)
    title(...)  # suppress matplot labels, but allow user to pass main/xlab/ylab
    points(as.numeric(rownames(compare)), compare$retro, ...)
  }

  out
}

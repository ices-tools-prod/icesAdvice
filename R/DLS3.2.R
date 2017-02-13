#' DLS Method 3.2
#'
#' Evaluate ICES method 3.2 for data-limited stocks (DLS).
#'
#' @param lastadvice last catch advice given for this stock.
#' @param index survey index vector.
#' @param prebuffer whether to apply a -20\% precautionary buffer.
#' @param i1 survey index values reflecting previous stock size.
#' @param i2 survey index values reflecting current stock size.
#'
#' @details
#' In the simplest case, only \code{lastadvice} and \code{index} are required.
#' The reference vectors \code{i1} and \code{i2} will then be evaluated
#' automatically as
#'
#' \verb{  }i1 = (I[n-4], I[n-3], I[n-2])
#'
#' \verb{  }i2 = (I[n-1], I[n])
#'
#' where I is a survey index vector of length n.
#'
#' To handle unusual cases, the user can specify \code{i1} and \code{i2}
#' manually, in which case the \code{index} vector is ignored. This can be
#' useful to specify reference periods that are different from the default, or
#' to work around \code{NA} values in the survey index. Missing values are not
#' permitted in the reference vectors \code{i1} and \code{i2}.
#'
#' @return
#' A list containing the resulting \code{advice} and other elements showing
#' intermediate steps in the calculation.
#'
#' @note See the ICES (2012) guidance report for more information.
#'
#' @author Anne Cooper and Arni Magnusson.
#'
#' @references
#' ICES. 2012. ICES DLS guidance report: ICES implementation of advice for
#' data-limited stocks in 2012 in its 2012 advice. \cite{ICES CM 2012/ACOM:68.}
#'
#' @seealso
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' # Three hypothetical surveys
#' survey <- data.frame(year=2001:2010, randu[1:10,])
#'
#' DLS3.2(1000, survey$x)
#'
#' DLS3.2(1000, survey$y)
#' DLS3.2(1000, survey$y, prebuffer=TRUE)
#'
#' DLS3.2(1000, survey$z)
#' DLS3.2(1000, i1=survey$z[6:9], i2=survey$z[10])
#'
#' # Visualize
#' output <- DLS3.2(1000, survey$y)
#' plot(y~year, survey, ylab="index", type="b", lty=3)
#' segments(2006, output$i1bar, 2008, lwd=2)
#' segments(2009, output$i2bar, 2010, lwd=2)
#'
#' @importFrom utils head tail
#'
#' @export

DLS3.2 <- function(lastadvice, index, prebuffer=FALSE,
                   i1=head(tail(index,5),3), i2=tail(index,2))
{
  change <- mean(i2) / mean(i1)
  multiplier <- max(0.8, min(1.2, change))
  if(prebuffer)
    multiplier <- 0.8 * multiplier

  advice <- multiplier * lastadvice

  list(lastadvice=lastadvice, i1=i1, i2=i2, i1bar=mean(i1), i2bar=mean(i2),
       change=change, prebuffer=prebuffer, multiplier=multiplier, advice=advice)
}

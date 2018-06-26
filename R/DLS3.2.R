#' DLS Method 3.2
#'
#' Apply ICES method 3.2 to calculate catch advice for data-limited stocks
#' (DLS).
#'
#' @param lastadvice last catch advice given for this stock.
#' @param index stock size index.
#' @param len two integers, indicating the desired lengths of reference vectors.
#' @param buffer whether to apply a -20\% precautionary buffer.
#' @param i1 included for backward compatibility, use \code{len} instead.
#' @param i2 included for backward compatibility, use \code{len} instead.
#'
#' @details
#' This function compares the average values of two reference vectors \code{i1}
#' and \code{i2}. In the simplest case, only \code{lastadvice} and \code{index}
#' are required to calculate the advice.
#'
#' The default value of \code{len = c(3, 2)} produces vectors \code{i1} and
#' \code{i2} of lengths 3 and 2,
#'
#' \verb{  }i1 = (I[n-4], I[n-3], I[n-2])
#'
#' \verb{  }i2 = (I[n-1], I[n])
#'
#' where I is a stock size index of length n.
#'
#' Other vector lengths can be used, such as \code{len = c(5, 2)} to get
#'
#' \verb{  }i1 = (I[n-6], I[n-5], I[n-4], I[n-3], I[n-2])
#'
#' \verb{  }i2 = (I[n-1], I[n])
#'
#' Finally, a -20\% precautionary buffer can be applied at the end of all
#' calculations.
#'
#' See the ICES (2012) guidance report for details.
#'
#' @return
#' A list containing the resulting \code{advice} and other elements showing
#' intermediate steps in the calculations.
#'
#' @author Anne Cooper and Arni Magnusson.
#'
#' @references
#' ICES (2012) ICES DLS guidance report: ICES implementation of advice for
#' data-limited stocks in 2012 in its 2012 advice.
#' \href{http://ices.dk/sites/pub/Publication\%20Reports/Expert\%20Group\%20Report/acom/2012/ADHOC/DLS\%20Guidance\%20Report\%202012.pdf}{\emph{ICES
#' CM 2012/ACOM:68}}.
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
#' DLS3.2(1000, survey$y, len=c(5,2))
#'
#' DLS3.2(1000, survey$z)
#' DLS3.2(1000, survey$z, buffer=TRUE)
#'
#' # Plot
#' output <- DLS3.2(1000, survey$y)
#' plot(y~year, survey, ylab="index", type="b", lty=3)
#' segments(2006, output$i1bar, 2008, lwd=2)
#' segments(2009, output$i2bar, 2010, lwd=2)
#'
#' @export

DLS3.2 <- function(lastadvice, index, len=c(3,2), buffer=FALSE, i1, i2)
{
  n <- length(index)
  a <- len[1]
  b <- len[2]

  if(missing(i1))
    i1 <- index[(n-a-b+1):(n-b)]
  ## else
  ##   warning("'i1' argument is deprecated - use 'len' instead.")
  if(missing(i2))
    i2 <- index[(n-b+1):n]
  ## else
  ##   warning("'i2' argument is deprecated - use 'len' instead.")

  change <- mean(i2) / mean(i1)
  multiplier <- max(0.8, min(1.2, change))
  if(buffer)
    multiplier <- 0.8 * multiplier

  advice <- multiplier * lastadvice

  list(lastadvice=lastadvice, i1=i1, i2=i2, i1bar=mean(i1), i2bar=mean(i2),
       change=change, buffer=buffer, multiplier=multiplier, advice=advice)
}

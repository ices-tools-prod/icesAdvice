#' Age Range for Fbar
#'
#' Calculate a suitable age range for average fishing mortality (Fbar).
#'
#' @param cn a vector, matrix, table, or data frame containing the catch at age.
#'        Ages are indicated in names if \code{cn} is a vector, or in column
#'        names if \code{cn} is a matrix, table, or data frame.
#' @param probs a vector of probabilities, e.g. \code{c(0.1, 0.9)} to calculate
#'        the age range that covers 80\% of the catch.
#' @param plot whether to plot the cumulative distribution and interpolation.
#' @param main passed to \code{plot}.
#'
#' @return Vector of two values, the lower and upper age.
#'
#' @note
#' \code{NA} values in \code{cn} are treated as zero.
#'
#' The method uses linear interpolation of the cumulative distribution to
#' calculate the cut-off ages. See \code{plot = TRUE} example below.
#'
#' @seealso
#' \code{\link{gss}} is an example catch-at-age table.
#'
#' \code{\link{cumsum}} calculates an empirical cumulative distribution.
#'
#' \code{\link{approx}} performs linear interpolation.
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @examples
#' agesFbar(gss)
#' agesFbar(gss, plot=TRUE)
#' agesFbar(gss, plot=TRUE, main="Greater silver smelt in 5b and 6a")
#'
#' # 50% coverage instead of 80%
#' agesFbar(gss, c(0.25, 0.75))
#'
#' # Include only the last 20 years
#' agesFbar(tail(gss, 20))
#'
#' @importFrom graphics abline barplot par plot points
#' @importFrom stats approx
#'
#' @export

agesFbar <- function(cn, probs=c(0.1, 0.9), plot=FALSE, main=NULL)
{
  ## 1  Handle columns
  if(is.data.frame(cn) && tolower(names(cn)[1])=="year")
    cn <- cn[-1]  # discard first column if it is called Year
  if(is.vector(cn))
    cn <- t(cn)   # arrange in columns so we can use colSums

  ## 2  Calculate cut-off points
  x <- cumsum(prop.table(colSums(cn, na.rm=TRUE)))
  if(is.null(names(x)))
    stop("'cn' must have names indicating ages")
  y <- as.numeric(names(x))
  out <- approx(x, y, xout=probs)$y

  ## 3  Plot
  if(plot)
  {
    opar <- par(mfrow=c(2,1)); on.exit(par(opar))
    plot(as.integer(names(x)), x, type="o", ylim=0:1, main=main,
         xlab="Age", ylab="Proportion of catch this age or younger")
    abline(h=probs, lty=2)
    points(out, probs, pch="+", cex=2)
    z <- barplot(prop.table(colSums(cn, na.rm=TRUE)),
                 main=paste(format(round(out, 3)), collapse=" - "),
                 xlab="Age", ylab="Proportion in catch")
    abline(v=approx(y, z, out)$y, lty=2, lwd=2)
  }

  out
}

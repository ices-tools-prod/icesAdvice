#' Age Range for Fbar
#'
#' Calculate a suitable age range for average fishing mortality (Fbar).
#'
#' @param cn a vector, matrix, table, or data frame containing the catch at age
#'        as integers or decimal values. Ages are indicated in names if
#'        \code{cn} is a vector, or in column names if \code{cn} is a matrix,
#'        table, or data frame.
#' @param probs a vector of probabilities, e.g. \code{c(0.1, 0.9)} to calculate
#'        the age range that covers 80\% of the catch.
#' @param plot whether to indicate the cut points on a bar plot.
#' @param main passed to \code{barplot}.
#' @param xlab passed to \code{barplot}.
#' @param ylab passed to \code{barplot}.
#' @param col passed to \code{barplot}.
#'
#' @return
#' Vector of two values, the lower and upper age. These can be rounded to
#' construct an Fbar age range.
#'
#' @note
#' The calculations are more complicated than traditional quantiles, since the
#' ages for Fbar are discrete and not continuous. For example, with a continuous
#' variable, Fbar[5-6] has width one, but for a discrete variable it has width
#' two.
#'
#' The algorithm cuts off exactly \code{probs[1]} and \code{1-probs[2]} from the
#' left and right tails of the distribution and returns the corresponding values
#' that can be rounded with a simple \code{round(agesFbar(x))} to get a discrete
#' age range that covers close to \code{diff(probs)} of the catch.
#'
#' With \code{plot = TRUE}, the white bars are outside the Fbar age range and
#' the dark gray bars are inside it. The bars affected by the lower and upper
#' cut points are drawn in a shade between white and dark gray, providing a
#' visual cue whether that age should be in the Fbar age range or not.
#'
#' The calculated limits are somewhat unintuitive for interpretation, but they
#' are statistically precise and unbiased. A lower limit of 6.8 means that 80\%
#' of age six was cut off the left tail, so rounding the lower age of Fbar to 7
#' appropriate. An upper limit of 14.1 means that all of age 14 and 10\% of age
#' 15 is inside the range, so rounding the upper age of Fbar to 14 is
#' appropriate. See \code{plot = TRUE} example below.
#'
#' @seealso
#' \code{\link{gss}} is an example catch-at-age table.
#'
#' \code{\link{quantile}} is the base function to calculate quantiles.
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
#' # Tests
#' cn1 <- setNames(c(100,400,400,100), 3:6)
#' cn2 <- setNames(c(99,401,401,99), 3:6)
#' cn3 <- setNames(c(101,399,399,101), 3:6)
#' cn4 <- setNames(c(500,400,50,50), 3:6)
#' cn5 <- setNames(c(50,50,400,500), 3:6)
#' agesFbar(cn1)
#' agesFbar(cn2)
#' agesFbar(cn3)
#' agesFbar(cn4)
#' agesFbar(cn5)
#'
#' @importFrom graphics abline barplot
#' @importFrom stats approx
#'
#' @export

agesFbar <- function(cn, probs=c(0.1, 0.9), plot=FALSE, main=NULL, xlab=NULL,
                     ylab=NULL, col=NULL)
{
  ## 1  Handle columns
  if(is.data.frame(cn) && tolower(names(cn)[1])=="year")
    cn <- cn[-1]  # discard first column if it is called Year
  if(is.vector(cn))
    cn <- t(cn)   # arrange in columns so we can use colSums

  ## 2  Calculate proportions in catch
  p <- prop.table(colSums(cn, na.rm=TRUE))
  if(is.null(names(p)))
    stop("'cn' must have names indicating ages")
  ages <- as.integer(names(p))

  ## 3  Calculate quantiles
  n <- length(ages)
  i <- 1
  j <- n
  while(zapsmall(sum(p[1:i])) <= zapsmall(probs[1]))
    i <- i + 1
  while(zapsmall(sum(p[j:n])) <= zapsmall(1-probs[2]))
    j <- j - 1
  lower <- ages[i]
  upper <- ages[j]

  ## 4  Adjust proportion within age bin
  lower <- unname(lower + (probs[1] - sum(p[1:i]) + p[i]) / p[i])
  upper <- unname(upper - (1 - probs[2] - sum(p[j:n]) + p[j]) / p[j])
  out <- c(lower, upper)

  ## 5  Plot
  if(plot)
  {
    if(is.null(col))
    {
      col <- rep("white", length=length(ages))     # white outside of range
      col[ages %in% ceiling(lower):floor(upper)] <- "gray40"  # gray inside
      ## Cut points are between gray40 and white
      col.lower <- paste0("gray", trunc(100*(0.4+0.6*(lower-floor(lower)))))
      col.upper <- paste0("gray", trunc(100*(0.4+0.6*(ceiling(upper)-upper))))
      col[ages == floor(lower)] <- col.lower
      col[ages == ceiling(upper)] <- col.upper
    }
    if(is.null(main))
      main <- paste(format(round(out, 3)), collapse=" - ")
    xlab <- if(is.null(xlab)) "Age" else xlab
    ylab <- if(is.null(ylab)) "Proportion in catch" else ylab
    z <- barplot(prop.table(colSums(cn, na.rm=TRUE)), space=0, col=col,
                 main=main, xlab=xlab, ylab=ylab)
    abline(v=approx(ages, z, out)$y + c(-0.5, 0.5), lty=2, lwd=2)
  }

  out
}

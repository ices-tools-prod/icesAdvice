#' Read DLS3.2 Results from File
#'
#' Read results from the \code{DLS3.2} advisory method from a file into a list.
#'
#' @param file a filename.
#'
#' @return
#' A list containing \code{advice} and other elements showing intermediate steps
#' in the calculations.
#'
#' @seealso
#' \code{\link{write.dls}} writes \code{DLS3.2} results to a file.
#'
#' \code{\link{DLS3.2}} can be used to calculate catch advice for data-limited
#' stocks (DLS).
#'
#' \code{\link{icesAdvice-package}} gives an overview of the package.
#'
#' @author Arni Magnusson.
#'
#' @examples
#' \dontrun{
#' survey <- data.frame(year=2001:2010, randu[1:10,])
#' dls <- icesAdvice::DLS3.2(1000, survey$y)
#'
#' write.dls(dls, "dls.txt")
#' read.dls("dls.txt")
#'
#' file.remove("dls.txt")
#' }
#'
#' @importFrom utils type.convert
#'
#' @export

read.dls <- function(file)
{
  x <- readLines(file)
  x <- x[x != ""]
  out <- list()

  while(length(x) > 0)
  {
    value <- strsplit(x[2], " ")[[1]]
    value <- type.convert(value, as.is=TRUE)
    out[[x[1]]] <- value
    x <- x[-(1:2)]
  }

  out
}

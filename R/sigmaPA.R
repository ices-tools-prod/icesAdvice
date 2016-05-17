sigmaPA <- function(lim, pa)
{
  refpt <- sort(c(lim, pa))
  sigma <- (log(refpt[2]) - log(refpt[1])) / 1.645
  return(sigma)
}

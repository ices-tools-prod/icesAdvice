sigmaCI <- function(lo, hi, log=TRUE, alpha=0.05)
{
  rng <- if(log) log(hi)-log(lo) else hi-lo
  z <- qnorm(1 - alpha/2)
  sigma <- 0.5*rng / z
  return(sigma)
}

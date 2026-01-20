library(knitr)
library(purrr)
library(dplyr)
library(DataSetsUni)

#Generate random numbers from the distribution
rtplf <- \(n, beta, lambda){
  u <- runif(n)
  t <- ( log( 1 - (log(1 - u) / lambda) ))^(1/beta)
  return(t)
}

#Loglikelihood function
ll <- \(x, par){
  beta = par[1]
  lambda = par[2]
  delta = kidney$status
  
  loglik = sum(delta * (log(lambda) + log(beta) + (beta -1 )*log(x) + x^beta)) - sum(-(lambda *(1 - exp(x^beta))))
  return(-loglik)
}

#Loglikelihood function assuming complete data
ll_tplf <- \(x, par){
  beta = par[1]
  lambda = par[2]
  delta = rep(1, length(x))
  
  loglik = sum(delta*(log(lambda) + log(beta) + (beta -1)*log(x) + x^beta)) +
    sum(lambda*(1 - exp(x^beta)))
  return(-loglik)
}

#Monte carlo simulation for n = 50, 100, 150, 200, 250
estimates <- \(X){
  res = optim(par = c(0.1, 0.1),
              fn = ll_tplf,
              lower = c(1e-5, 1e-5),
              method = "L-BFGS-B",
              x = X, hessian = T)
  
  invH = solve(res$hessian)
  
  res_df = tibble(beta = res$par[1],
                  lambda = res$par[2],
                  beta_var = invH[1,1],
                  lambda_var = invH[2,2])
  return(res_df)
}

#Goodness of fit
set.seed(351)
res <- \(n, N, beta, lambda){
  df = map_dfr(1:N, ~estimates(rtplf(n,beta,lambda)))
  
  tibble(n = n,
         `Bias(beta)` = mean(df$beta) - beta,
         `APE(beta)` = mean(abs((df$beta - beta)) / beta),
         `MSE(beta)` = mean((df$beta - beta)^2),
         `CP(beta)` = mean(between(rep(beta,N), 
                                   df$beta - 1.96 *
                                     sqrt(df$beta_var), 
                                   df$beta + 1.96 * 
                                     sqrt(df$beta_var))),
         `Bias(lambda)` = mean(df$lambda) - lambda,
         `APE(lambda)` = mean(abs((df$lambda - lambda)) / lambda),
         `MSE(lambda)` = mean((df$lambda - lambda)^2),
         `CP(lambda)` = mean(between(rep(lambda,N), 
                                     df$lambda - 1.96 *
                                       sqrt(df$lambda_var), 
                                     df$lambda + 1.96 * 
                                       sqrt(df$lambda_var))))
}

# For beta = 0.4 and lambda = 2
map_dfr(c(50, 100, 150, 200, 250), ~res(.x, 5000, 0.4, 2)) |> 
  kable()

# For beta = 0.8 and lambda = 2
map_dfr(c(50, 100, 150, 200, 250), ~res(.x, 5000, 0.8, 2)) |> 
  kable()

# For beta = 1.2 and lambda = 2
map_dfr(c(50, 100, 150, 200, 250), ~res(.x, 5000, 1.2, 2)) |> 
  kable()

# For beta = 0.4 and lambda = 0.5
map_dfr(c(50, 100, 150, 200, 250), ~res(.x, 5000, 0.4, 0.5)) |> 
  kable()

# For beta = 0.8 and lambda = 0.5
map_dfr(c(50, 100, 150, 200, 250), ~res(.x, 5000, 0.8, 0.5)) |> 
  kable()
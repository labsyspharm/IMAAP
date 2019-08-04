#' @title Distribution plot with the gaussian model fit
#' @description The fuction plots the distribution for every marker along with the gaussian model fit.
#' @param data Dataframe of data (natural scale) containing samples as rows and markers as columns.
#' @param peaks_low Mean expression value of the left most distribution in the gaussian fit
#' @param peaks_high Mean expression value of the left most distribution in the gaussian fit
#' @param SD Standard Deviation. Default is set to 3. This determines to what extend of the data distribution is considered as positive to marker expression. If your data distribution is clearly not bi-modal, it is suggested to be conservative in the selection of an SD value.
#' @return Plots
#' @export

imaap_model_plot <- function(data,peaks_low,peaks_high,SD){
  require(magrittr) # Plotting
  require(ggplot2) # Plotting
  require(gridExtra)
  # Gaussian mixture plotting function
  plot_mix_comps <- function(x, mu, sigma, lam) {lam * dnorm(x, mu, sigma)}
  for (i in 1: ncol(data)){
    P1 <- data.frame(x = data[,i]) %>%
      ggplot() + ggtitle(colnames(data[i]))+
      geom_histogram(aes(x, ..density..), binwidth = 1, colour = "black", fill = "white") +
      stat_function(geom = "line", fun = plot_mix_comps,
                    args = list(peaks_low[i,][[1]], peaks_low[i,][[2]], lam = peaks_low[i,][[3]]),
                    colour = "red", lwd = 1.5) +
      stat_function(geom = "line", fun = plot_mix_comps,
                    args = list(peaks_high[i,][[1]], peaks_high[i,][[2]], lam = peaks_high[i,][[3]]),
                    colour = "blue", lwd = 1.5) +
      geom_vline(xintercept = peaks_high[i,][[1]], color = "grey", size=1.5) +
      geom_vline(xintercept = peaks_high[i,][[1]] - SD*peaks_high[i,][[2]], color = "black", size=1.5) +
      ylab("Density")
    print(colnames(data[i]))
    #print(P1)
    my_plots[[i]] <- P1
  }
  return(my_plots)
}

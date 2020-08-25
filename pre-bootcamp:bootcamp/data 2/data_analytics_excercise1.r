dat <- read.csv(file = "inflammation-01.csv", header = FALSE)

plot_distribution <- function(df, threshold) {
  if (length(df) > threshold) {
    boxplot(df)
  } else {
    stripchart(df)
  }
}

plot_distribution(dat[,10], threshold = 10)

plot_distribution(dat[,10], threshold = 102)

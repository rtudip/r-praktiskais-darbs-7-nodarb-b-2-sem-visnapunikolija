library(dplyr)
library(tidyr)
library(ggplot2)

#1

kordat <- read.table("variants2.txt", header = TRUE, sep = "\t", dec = ",", strip.white = TRUE, row.names = 1)
#head(kordat)
#print(kordat)
#2

cols_to_factor <- names(kordat)[9:ncol(kordat)]
kordat[cols_to_factor] <- lapply(kordat[cols_to_factor], factor)

#3

sink("results.txt")

#4
cat("Faktoru līmeņu kopsavilkums:\n")
for (col in cols_to_factor) {
  cat("\nKolonna:", col, "\n")
  print(summary(kordat[[col]]))


#5
sl_by_b <- split(kordat$Slope, kordat$b)
cat("\nSlope sadalījums pēc b:\n")
print(sl_by_b)

#6
kordat$Average <- rowMeans(kordat[, c("Slope", "Intercept", "adj.r.squared")])

#7
std_dev_by_f <- kordat %>% group_by(f) %>% summarise(StdDev = sd(Slope, na.rm = TRUE))
cat("\nStandartnovirze pa f faktoriem:\n")
print(std_dev_by_f)

#summary(kordat$adj.r.squared) 
#8
prockordat <- kordat %>% filter(adj.r.squared > 0.7)

#9
prockordat$Slope <- 1 - (1/ prockordat$Slope)

#10
cat("\nprockordat dati:\n")
print(prockordat)

sink()

#print(names(kordat))
#11

p <- ggplot(kordat, aes(x = MAD, y = Average)) +
  geom_point() +
  ggtitle("Izkliedes grafiks: MAD vs Average")

ggsave("scatter.svg", plot = p)


#12
p_box <- ggplot(kordat, aes(x = f, y = Intercept, fill = f)) +
  geom_boxplot() +
  ggtitle("Kastišu diagrama: Intercept pec f faktoriem")

ggsave("boxplot.svg", plot = p_box)

#papilduzzd

most_frequent_level <- names(which.max(table(unlist(kordat[, cols_to_factor]))))
filtered_rows <- prockordat[grep(most_frequent_level, rownames(prockordat)), ]
print(filtered_rows)
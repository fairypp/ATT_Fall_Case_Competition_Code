#compute correlation of demographic factors
#and out the computed results
demographics <- read.csv("demographic.csv")
demographics <- demographics[,-1]

demographics <- as.matrix(demographics)
demographics[] <- as.numeric(demographics)
corr <- cor(demographics)
corr <- corr[c(7,8),]
write.csv(corr, "demog_corr.csv")
  
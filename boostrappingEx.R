#Bootstrapping example (sampling the sample)

#load in the data
data(trees)

#sample the whole data with the size of the data
nReps <- 5000
treeRatio <- numeric(nReps)
for (i in 1:nReps){
  treeIndex <- sample(1:31,replace = TRUE)
  treeBootSample <- trees[treeIndex,]
  treeBootMod <- lm(Volume ~ Height + Girth, data = treeBootSample)
  treeBootSampleRatio <- as.vector(treeBootMod$coefficients[2]/treeBootMod$coefficients[3])
  treeRatio[i] <- treeBootSampleRatio
}
#double checking the output
head(treeRatio)

#bootstrap mean
treeBootMean <- mean(treeRatio)
print(treeBootMean)

#95% ci
treeCI <- treeBootMean + c(-1,1) * qt(.975, nReps-1) * (sd(treeRatio)/sqrt(nReps))
names(treeCI) <- c('lower','upper')
print(treeCI)
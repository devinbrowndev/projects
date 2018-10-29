data(iris)
data(swiss)


#kmeans
#data setup
datasetup <- function(k){
  iriscopy <- iris[,1:4]
  iriscopyFull <- iris
  clst <- kmeans(iriscopy, centers = k)
  iriscopyFull$cluster <- clst$cluster
  results_list <- list(iriscopyFull,clst)
  results_list
}


#a: number of pairs of items that belong to the same cluster in both kmeans data and orig data
calcA <- function(df){
  a <- 0
  for (i in 1:nrow(df)){
    for (j in i:nrow(df)){
      if(iriscopyF$cluster[i] == iriscopyF$cluster[j] & iriscopyF$Species[i] == iriscopyF$Species[j]){
        a <- a + 1
      }
    }
    if(a > 0){
      a <- a - 1
    }
  }
  a
}

#b: number of pairs of items that belong to different clusters in both CC and TC
calcB <- function(df){
  a <- 0
  for (i in 1:nrow(df)){
    for (j in i:nrow(df)){
      if(iriscopyF$cluster[i] != iriscopyF$cluster[j] & iriscopyF$Species[i] != iriscopyF$Species[j]){
        a <- a + 1
      }
    }
    if(a > 0){
      a <- a - 1
    }
  }
  a
}

#c: number of pairs of items that belong to the same cluster in CC but different clusters in TC
calcC <- function(df){
  a <- 0
  for (i in 1:nrow(df)){
    for (j in i:nrow(df)){
      if(iriscopyF$cluster[i] == iriscopyF$cluster[j] & iriscopyF$Species[i] != iriscopyF$Species[j]){
        a <- a + 1
      }
    }
    if(a > 0){
      a <- a - 1
    }
  }
  a
}

#d: number of pairs of items that belong to the same cluster in TC but different clusters in CC
calcD <- function(df){
  a <- 0
  for (i in 1:nrow(df)){
    for (j in i:nrow(df)){
      if(iriscopyF$cluster[i] != iriscopyF$cluster[j] & iriscopyF$Species[i] == iriscopyF$Species[j]){
        a <- a + 1
      }
    }
    if(a > 0){
      a <- a - 1
    }
  }
  a
}

#evaluate accuracy function
evaluate <- function(df){
  a <- calcA(df)
  b <- calcB(df)
  c <- calcC(df)
  d <- calcD(df)
  p <- a/(a+c)
  r <- a/(a+d)
  f <- (2*p*r)/(p+r)
  f
}


#k = 2
k2 <- datasetup(2)
iriscopyF <- k2[[1]]
print('k = 2')
k2[[2]]['size']
evaluate(iriscopyF)


#k=3
k3 <- datasetup(3)
iriscopyF <- k3[[1]]
print('k = 3')
k3[[2]]['size']
evaluate(iriscopyF)

#k=4
k4 <- datasetup(4)
iriscopyF <- k4[[1]]
print('k = 4')
k4[[2]]['size']
evaluate(iriscopyF)

#k=5
k5 <- datasetup(5)
iriscopyF <- k5[[1]]
print('k = 5')
k5[[2]]['size']
evaluate(iriscopyF)


##3 is the best k value##
#as the value of k increases past 3, the accuracy of our model gets worse and worse so if you choose a k value
#which is too high, you will end up making your model worse.


#In the swiss data set use kmeans to find which cities are catholic and which are protestant
swiss_copy <- swiss[colnames(swiss) != 'Catholic']
swiss_copy <- swiss
k2cath <- kmeans(swiss_copy,2)
swiss_copy$cluster <- k2cath$cluster
#when cluster == 1 -> protestant
rownames(swiss_copy[swiss_copy$cluster == 1,])

#when cluster == 2 -> catholic
rownames(swiss_copy[swiss_copy$cluster == 2,])


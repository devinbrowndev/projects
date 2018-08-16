#MONTE HALL SIMULATION STUDY
#https://en.wikipedia.org/wiki/Monty_Hall_problem
#Implement both strategies SWITCH and DO NOT SWITCH
#Give the probability of winning under each of the strategies w/ a conf. int

gameshow <- function(nReps,switchDoor = FALSE){
  result <- rep(NA, nReps)
  for (i in 1:nReps){
    #simulate the doors
    sim <- sample(c(1,0,0), replace = FALSE)
    index <- c(1,2,3)
    doors <- data.frame(cbind(index,sim))
    
    #choose a door
    doorChoice <- sample(1:3,1)
    
    #host picks one of the other two doors that the contestant hasn't chosen
    hostPossibleChoices <- doors$index[doors$index != doorChoice & doors$sim == 0]
    #if the possible doors include the car, only choose the goat
    if (length(hostPossibleChoices) == 1){
      doorShown <- hostPossibleChoices
    } else {
      doorShown <- sample(hostPossibleChoices, size = 1)
    }
    if (switchDoor == TRUE){
      doorChoice <- 6 - (doorChoice + doorShown)
    }
    #did I win a car?
    result[i] <- doorChoice == doors$index[doors$sim == 1]
  }
  result
}

#don't switch the door when asked by the gameshow host if you want to switch doors
phatNoSwitch <- mean(gameshow(10000))
print(phatNoSwitch)
#confidence interval don't switch
nReps <- 10000
phatNoSwitch + c(-1,1) * 1.96 * sqrt((phatNoSwitch*(1-phatNoSwitch))/nReps)

#switch doors
phatSwitch <- mean(gameshow(10000,switchDoor = TRUE))
print(phatSwitch)
#confidence interval don't switch
phatSwitch + c(-1,1) * 1.96 * sqrt((phatSwitch*(1-phatSwitch))/nReps)


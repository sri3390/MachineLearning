####################################################################################
###############     Kyphosis Part   ################################################
####################################################################################
library(rpart)
dataframe <- as.data.frame(kyphosis)
kyphosismodel <- rpart(Kyphosis~Age+Number+Start,data = kyphosis,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(kyphosismodel)
summary(kyphosismodel) 
par(mar = rep(0.1,4))
plot(kyphosismodel)
text(kyphosismodel)
prunedtree <- prune(kyphosismodel,cp=kyphosismodel$cptable[which.min(kyphosismodel$cptable[,"rel error"]),"CP"])
printcp(prunedtree)
par(mar = rep(0.1,4))
plot(prunedtree)
text(prunedtree)
######################################################################################
## dividing the test into test and train data #####
#######  split 80-20 #################################################################
######################################################################################
index <- sample(1:nrow(dataframe),0.8*nrow(dataframe))
training <- dataframe[index,]
test <- dataframe[-index,]
newmodel <- rpart(Kyphosis~Age+Number+Start,data = training,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(newmodel)
par(mar = rep(0.1,4))
newprunedtree <- prune(newmodel,cp=newmodel$cptable[which.min(newmodel$cptable[,"rel error"]),"CP"])
plot(newmodel)
text(newmodel)
prediction <- predict(newprunedtree,test, type = "class")
predictionframe <- as.data.frame(prediction)
x <- 0
for (i in 1:nrow(predictionframe))
{
  if(predictionframe[i,1] == test[i,1]){
    x <- x+1
  }
}
p <- x/nrow(test)
p <- p*100
message("The Accuracy for 80 - 20: ")
print(p)
######################################################################################
#### split of 90 - 10 ######################################################
######################################################################################
index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
training <- dataframe[index,]
test <- dataframe[-index,]
newmodel <- rpart(Kyphosis~Age+Number+Start,data = training,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(newmodel)
par(mar = rep(0.1,4))
newprunedtree <- prune(newmodel,cp=newmodel$cptable[which.min(newmodel$cptable[,"rel error"]),"CP"])
plot(newmodel)
text(newmodel)
prediction <- predict(newprunedtree,test, type = "class")
predictionframe <- as.data.frame(prediction)
x <- 0
for (i in 1:nrow(predictionframe))
{
  if(predictionframe[i,1] == test[i,1]){
    x <- x+1
  }
}
p <- x/nrow(test)
p <- p*100
message("The Accuracy for 90 - 10: ")
print(p)

#####################################################################################
####################  Kyphosis part ends  ###########################################
#####################################################################################
message(" ###########################################")
message(" ###########################################")
message(" Start of the solder part ")
message(" ###########################################")
message(" ###########################################")

####################################################################################
###############     Solder Part   ################################################
####################################################################################

library(rpart)
dataframe <- as.data.frame(solder)
soldermodel <- rpart(Solder~Opening+Mask+PadType+Panel+skips,data = solder,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(soldermodel)
summary(soldermodel) 
par(mar = rep(0.1,4))
plot(soldermodel)
text(soldermodel)
prunedtree <- prune(soldermodel,cp=soldermodel$cptable[which.min(soldermodel$cptable[,"rel error"]),"CP"])
printcp(prunedtree)
par(mar = rep(0.1,4))
plot(prunedtree)
text(prunedtree)
######################################################################################
## dividing the test into test and train data ########################################
#####  split of 80 - 20 ##############################################################
######################################################################################
index <- sample(1:nrow(dataframe),0.8*nrow(dataframe))
training <- dataframe[index,]
test <- dataframe[-index,]
newmodel <- rpart(Solder~Opening+Mask+PadType+Panel+skips,data = training,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(newmodel)
par(mar = rep(0.1,4))
newprunedtree <- prune(newmodel,cp=newmodel$cptable[which.min(newmodel$cptable[,"rel error"]),"CP"])
plot(newmodel)
text(newmodel)
prediction <- predict(newprunedtree,test, type = "class")
predictionframe <- as.data.frame(prediction)
x <- 0
for (i in 1:nrow(predictionframe))
{
  if(predictionframe[i,1] == test[i,2]){
    x <- x+1
  }
}
p <- x/nrow(test)
p <- p*100
message("The Accuracy for 80 - 10: ")
print(p)
##################################################################################
#########  Split of 90-10 ########################################################
##################################################################################

index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
training <- dataframe[index,]
test <- dataframe[-index,]
newmodel <- rpart(Solder~Opening+Mask+PadType+Panel+skips,data = training,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
printcp(newmodel)
par(mar = rep(0.1,4))
newprunedtree <- prune(newmodel,cp=newmodel$cptable[which.min(newmodel$cptable[,"rel error"]),"CP"])
plot(newmodel)
text(newmodel)
prediction <- predict(newprunedtree,test, type = "class")
predictionframe <- as.data.frame(prediction)
x <- 0
for (i in 1:nrow(predictionframe))
{
  if(predictionframe[i,1] == test[i,2]){
    x <- x+1
  }
}
p <- x/nrow(test)
p <- p*100
message("The Accuracy for 90 - 10: ")
print(p)

######################################################################################
################   Solder part Ends  #################################################
######################################################################################

library(rpart)
args <- commandArgs(trailingOnly = FALSE)
data <- read.csv(args[6],header = TRUE,sep=",")
data <- read.csv(args[7],header = TRUE,sep=",")
data_frame <- as.data.frame(data)
desiciontree <- rpart(Class~XB+XC+XD+XE+XF+XG+XH+XI+XJ+XK+XL+XM+XN+XO+XP+XQ+XR+XS+XT+XU,data = data_frame,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
message("-------------------------CP Table for the original tree -----------------------------")
printcp(desiciontree)
par(mar = rep(0.1,4))
plot(desiciontree)
text(desiciontree)
prunetree <- prune(desiciontree,cp=desiciontree$cptable[which.min(desiciontree$cptable[,"rel error"]),"CP"])
message("-------------------------CP Table for the pruned tree -----------------------------")
printcp(prunetree)
par(mar = rep(0.1,4))
plot(prunetree)
text(prunetree)
testdata <- read.csv(args[8],header = TRUE,sep = ",")
testdataframe <- as.data.frame(testdata)
prediction <- predict(prunetree,testdataframe, type = "class")
message("-------------------------Prediction results for the test data in class format  -----------------------------")
print(prediction)
message("---------------------- The accuracy of the results  ---------------------------------------")
predictionframe <- as.data.frame(prediction)
x <- 0
for (i in 1:nrow(predictionframe))
{
  if(predictionframe[i,1] == testdataframe[i,21]){
    x <- x+1
  }
}
p <- x/nrow(testdataframe)
p <- p*100
message("The Accuracy is : ")
print(p)

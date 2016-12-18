#################################################################################
## Name : Srikant Iyengar
## Net Id: sxi140530
#################################################################################
#################################################################################
#####   Desicion Tree ###########################################################
#################################################################################
if(!("rpart" %in% rownames(installed.packages()))){
  install.packages("rpart", repos="http://cran.rstudio.com/")  
}
library("rpart")
args <- commandArgs(TRUE)
dataURL<-as.character(args[1])
header<-as.logical(args[2])
columnno <- as.integer(args[3])
data<-read.csv(dataURL,header = header)
data[data == "?"] <- 0
dataframe = as.data.frame(data)
a = list()
for(j in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  classval <- as.vector(training[,columnno])
  training[,columnno] <- NULL
  smodel <- rpart(classval ~ .,data = training,method = "class",control = rpart.control(minsplit = 1,minbucket = 1),parms = list(split = 'information'))
  prunetree <- prune(smodel,cp=smodel$cptable[which.min(smodel$cptable[,"rel error"]),"CP"])
  test <- dataframe[-index,]
  prediction <- predict(prunetree,test, type = "class")
  predictionframe <- as.data.frame(prediction)
  x <- 0
  for (i in 1:nrow(predictionframe))
  {
    if(predictionframe[i,1] == test[i,columnno]){
      x <- x+1
    }
  }
  p <- x/nrow(test)
  p <- p*100
  a[j] = p  
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Decision Tree is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy : ", avg , "\n")
#################################################################################
####   Support Vector Machines ##################################################
#################################################################################
if(!("e1071" %in% rownames(installed.packages()))){
  install.packages("e1071", repos="http://cran.rstudio.com/")
}
require(e1071)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-columnno]
  x <- data.matrix(x)
  y <- as.factor(training[,columnno])
  svmmodel <- svm(x,y,probability = TRUE, kernel = "linear")
  test <- dataframe[-index,]
  t <- test[,-columnno]
  t <- data.matrix(t)
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for SVM is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy : ", avg , "\n")
####################################################################################
##########  Naive Bayes ############################################################
####################################################################################
library("e1071")
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-columnno]
  y <- as.factor(training[,columnno])
  model = naiveBayes(x,y)
  test <- dataframe[-index,]
  t <- test[,-columnno]
  pred <- predict(model,test,type = c("class", "raw"))
  pred <- as.data.frame(pred)
  count <- 0
  for(j in 1:nrow(test)){
    if(pred[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Naive Bayes is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
##################################################################################
####    kNN   ####################################################################
##################################################################################
if(!("class" %in% rownames(installed.packages()))){
  install.packages("class",repos = "http://cran.rstudio.com/")
}
library("class")
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-columnno]
  cl <- as.factor(training[,columnno])
  test <- dataframe[-index,]
  y <- test[,-columnno]
  kmodel <- knn(x,y,cl,k=11,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for kNN where k=11 is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
###################################################################################
#########  Logistic Regression ####################################################
###################################################################################
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  cl <- as.factor(training[,columnno])
  training[,columnno] <- NULL
  model <- glm(cl ~ .,data = training, family = binomial(logit))
  test <- dataframe[-index,]
  l <- names(model$xlevels)
  if(length(l) == 1){
    model$xlevels[[l]] <- union(model$xlevels[[l]],levels(as.factor(test[,l])))
  }
  pred <- predict(model,newdata = test,type = "response",se.fit = FALSE)
  fac <- as.vector(levels(as.factor(test[,columnno])))
  cfac <- cut(pred,breaks = c(-Inf,0.5,Inf),labels = fac)
  cfac <- as.data.frame(cfac)
  count <- 0
  for(j in 1:nrow(test)){
    if(cfac[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Logistic Regression is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
###################################################################################
##############   Neural Networks ##################################################
###################################################################################
if(!("neuralnet" %in% rownames(installed.packages()))){
  install.packages("neuralnet",dependencies = TRUE)
}
library("nnet")
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  cl <- as.vector(training[,columnno])
  cl <- as.factor(cl)
  cl = as.factor(as.numeric(cl))
  nmodel <- nnet(cl ~ . , data = training, size = 4,maxit = 1000,decay = .01)
  test <- dataframe[-index,]
  pred <- predict(nmodel,newdata = test)
  pred <- as.data.frame(pred)
  count <- 0
  test[,columnno] = as.factor(test[,columnno])
  levels(test[,columnno]) = c(0,1)
  for(j in 1:nrow(test)){
    if(round(pred[j,1],digits = 0) == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Neural Networks is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
#################################################################################
#########  Bagging ##############################################################
#################################################################################
if(!("ipred" %in% rownames(installed.packages()))){
  install.packages("ipred") 
}
library(ipred)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  cl <- as.factor(training[,columnno])
  training[,columnno] <- NULL 
  test <- dataframe[-index,]
  model <- bagging(cl ~ . , data = training)
  pred <- predict(model,test)
  pred <- as.data.frame(pred)
  if(is.factor(test[,columnno])){
    pred[,1] <- factor(pred[,1],levels = levels(test[,columnno]))
  }
  count <- 0
  for(j in 1:nrow(test)){
    if(pred[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Bagging is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
#################################################################################
##########  Random Forest #######################################################
#################################################################################
if(!("randomForest" %in% rownames(installed.packages()))){
  install.packages("randomForest",dependencies = TRUE) 
}
library("randomForest")
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-columnno]
  cl <- as.factor(training[,columnno])
  test <- dataframe[-index,]
  y <- test[,-columnno]
  fmodel <- randomForest(x,cl)
  pred <- predict(fmodel,y)
  pred <- as.data.frame(pred)
  count <- 0
  for(j in 1:nrow(test)){
    if(pred[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Random Forest is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
##################################################################################
##########  Boosting #############################################################
##################################################################################
if(!("ada" %in% rownames(installed.packages()))){
  install.packages("ada")
}
library(ada)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-columnno]
  cl <- as.factor(training[,columnno])
  cl <- cl[!is.na(cl)]
  test <- dataframe[-index,]
  y <- test[,-columnno]
  bmodel <- ada(x,cl)
  pred <- predict(bmodel,newdata = y)
  pred <- as.data.frame(pred)
  count <- 0
  for(j in 1:nrow(test)){
    if(pred[j,1] == test[j,columnno]){
      count <- count + 1
    }
  }
  p <- count/nrow(test)
  p <- p*100
  a[i] = p
}
avg <- 0
for(k in 1:10){
  avg <- avg + as.numeric(a[k])
}
avg <- avg/10
message(" The Result of the Experiment for Boosting is : ")
print(" Experiment  Accuracy")
print("Sample No       Accuracy")
for(k in 1:10){
  cat("    ",k,"             ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg, "\n")
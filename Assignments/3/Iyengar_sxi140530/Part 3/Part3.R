#################################################################################
## Name : Srikant Iyengar
## Net Id: sxi140530
#################################################################################
install.packages("e1071", repos="http://cran.rstudio.com/")
library("e1071")
args <- commandArgs(TRUE)
data <- read.csv(file=args[1],header = FALSE,sep=",")
dataframe = as.data.frame(data)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  svmmodel <- svm(x,y,probability = TRUE)
  test <- dataframe[-index,]
  t <- test[,-9]
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,9]){
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
message(" The Result of the Experiment for SVM with default kernal is : ")
print(" Experiment  Accuracy")
for(k in 1:10){
  cat("  ",k,"  ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy with default kernal : ", avg , "\n")

################################################################################
###### with linear kernal ######################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  svmmodel <- svm(x,y,probability = TRUE, kernel = "linear")
  test <- dataframe[-index,]
  t <- test[,-9]
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,9]){
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
cat("Overall accuracy with linear kernal : ", avg, "\n")

#################################################################################
#########   with polynomial kernal ##############################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  svmmodel <- svm(x,y,probability = TRUE, kernel = "polynomial")
  test <- dataframe[-index,]
  t <- test[,-9]
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,9]){
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
cat("Overall accuracy with polynomial kernal : ", avg, "\n")

################################################################################
###########  with radial basis kernel ##########################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  svmmodel <- svm(x,y,probability = TRUE, kernel = "radial")
  test <- dataframe[-index,]
  t <- test[,-9]
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,9]){
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
cat("Overall accuracy with radial kernal : ", avg, "\n")

###############################################################################
######## with sigmoid kernel  #################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  svmmodel <- svm(x,y,probability = TRUE, kernel = "sigmoid")
  test <- dataframe[-index,]
  t <- test[,-9]
  svmpred <- predict(svmmodel,t)
  svmpred <- as.data.frame(svmpred)
  count <- 0
  for(j in 1:nrow(test)){
    if(svmpred[j,1] == test[j,9]){
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
cat("Overall accuracy with sigmoid kernal : ", avg, "\n")


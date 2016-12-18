#################################################################################
## Name : Srikant Iyengar
## Net Id: sxi140530
#################################################################################
install.packages("klaR", repos = "http://cran.rstudio.com/")
install.packages("caret" , repos = "http://cran.rstudio.com/")
library("klaR")
library("caret")
args <- commandArgs(TRUE)
data <- read.csv(file=args[1],header = FALSE,sep=",")
dataframe = as.data.frame(data)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  y <- as.factor(training$V9)
  model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))
  test <- dataframe[-index,]
  t <- test[,-9]
  pred <- predict(model$finalModel,t)$class
  pred <- as.data.frame(pred)
  count <- 0
  for(j in 1:nrow(test)){
    if(pred[j,1] == test[j,9]){
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
for(k in 1:10){
  cat("  ",k,"  ",as.numeric(a[k]),"\n")
}
cat("Overall accuracy: ", avg)
#################################################################################
## Name : Srikant Iyengar
## Net Id: sxi140530
#################################################################################

#################################################################################
##################### k=3 #######################################################
install.packages("class",repos = "http://cran.rstudio.com/")
library("class")
args <- commandArgs(TRUE)
data <- read.csv(file=args[1],header = FALSE,sep=",")
dataframe = as.data.frame(data)
a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  cl <- as.factor(training$V9)
  test <- dataframe[-index,]
  y <- test[,-9]
  kmodel <- knn(x,y,cl,k=3,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,9]){
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
cat("Overall accuracy with k=3 : ", avg, "\n")

################################################################################
####################   k=5  ####################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  cl <- as.factor(training$V9)
  test <- dataframe[-index,]
  y <- test[,-9]
  kmodel <- knn(x,y,cl,k=5,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,9]){
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
cat("Overall accuracy with k=5 : ", avg, "\n")

#################################################################################
##############  k=7  ############################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  cl <- as.factor(training$V9)
  test <- dataframe[-index,]
  y <- test[,-9]
  kmodel <- knn(x,y,cl,k=7,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,9]){
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
cat("Overall accuracy with k=7 : ", avg, "\n")

#################################################################################
####################   k=9   ####################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  cl <- as.factor(training$V9)
  test <- dataframe[-index,]
  y <- test[,-9]
  kmodel <- knn(x,y,cl,k=9,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,9]){
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
cat("Overall accuracy with k=9 : ", avg, "\n")

###############################################################################
#############  k=11  ##########################################################

a = list()
for(i in 1:10){
  index <- sample(1:nrow(dataframe),0.9*nrow(dataframe))
  training <- dataframe[index,]
  x <- training[,-9]
  cl <- as.factor(training$V9)
  test <- dataframe[-index,]
  y <- test[,-9]
  kmodel <- knn(x,y,cl,k=11,prob = TRUE)
  kmodel <- as.data.frame(kmodel)
  count <- 0
  for(j in 1:nrow(test)){
    if(kmodel[j,1] == test[j,9]){
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
cat("Overall accuracy with k=11 : ", avg, "\n")

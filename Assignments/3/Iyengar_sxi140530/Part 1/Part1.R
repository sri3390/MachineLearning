#################################################################################
## Name : Srikant Iyengar
## Net Id: sxi140530
#################################################################################
args <- commandArgs(TRUE)
data <- read.csv(file=args[1],header = FALSE,sep=",")
# for 1st attribute
nopregnent <- data$V1
hist(nopregnent,main = "Histogram for Number of times pregnant Attribute", xlab = "Number of times pregnant", breaks=7)
barplot(nopregnent,main = "Bar Graph for Number of times pregnant Attribute", xlab = "Number of times pregnant", xlim = c(0,100))
# for 2nd attribute
plasma <- data$V2
hist(plasma,main = "Histogram for Plasma glucose concentration Attribute", xlab = "Plasma glucose concentration", breaks=7)
barplot(plasma,main = "Bar Graph for Plasma glucose concentration Attribute", xlab = "Plasma glucose concentration", xlim = c(0,100))
# for 3rd attribute
bpressure <- data$V3
hist(bpressure,main = "Histogram for Diastolic blood pressure (mm Hg) Attribute", xlab = " Diastolic blood pressure (mm Hg)", breaks=7)
barplot(bpressure,main = "Bar Graph for Diastolic blood pressure (mm Hg) Attribute", xlab = " Diastolic blood pressure (mm Hg)", xlim = c(0,100))
# for 4th attribute
skin <- data$V4
hist(skin,main = "Histogram for Triceps skin fold thickness (mm) Attribute", xlab = " Triceps skin fold thickness (mm)", breaks=8)
barplot(skin,main = "Bar Graph for Triceps skin fold thickness (mm) Attribute", xlab = " Triceps skin fold thickness (mm)", xlim = c(0,100))
# for 5th attribute
serum <- data$V5
hist(serum,main = "Histogram for  2-Hour serum insulin (mu U/ml) Attribute", xlab = " 2-Hour serum insulin (mu U/ml) ", breaks=6)
barplot(serum,main = "Bar Graph for  2-Hour serum insulin (mu U/ml) Attribute", xlab = " 2-Hour serum insulin (mu U/ml) " , xlim = c(0,100))
# for 6th attribute
bmi <- data$V6
hist(bmi,main = "Histogram for  Body mass index (weight in kg/(height in m)^2)  Attribute", xlab = "  Body mass index ", breaks=7)
barplot(bmi,main = "Bar Graph for  Body mass index (weight in kg/(height in m)^2)  Attribute", xlab = "  Body mass index ", xlim = c(0,100))
# for 7th attribute
pedigree <- data$V7
hist(pedigree,main = "Histogram for Diabetes pedigree function Attribute", xlab = " Diabetes pedigree function ", breaks=9)
barplot(pedigree,main = "Bar Graph for Diabetes pedigree function Attribute", xlab = " Diabetes pedigree function ", xlim = c(0,100))
# for 8th attribute
age <- data$V8
hist(age,main = "Histogram for Age (years) Attribute", xlab = " Age (years) ", breaks=7)
barplot(age,main = "Bar Graph for Age (years) Attribute", xlab = " Age (years) ", xlim = c(0,100))


#Correlation between each attribute and the class
class <- data$V9
message(" The Correlation Between 1st attribute and the Class")
cor(nopregnent,class)
message(" The Correlation Between 2nd attribute and the Class")
cor(plasma,class)
message(" The Correlation Between 3rd attribute and the Class")
cor(bpressure,class)
message("The Correlation Between 4th attribute and the Class")
cor(skin,class)
message(" The Correlation Between 5th attribute and the Class")
cor(serum,class)
message("The Correlation Between 6th attribute and the Class")
cor(bmi,class)
message("The Correlation Between 7th attribute and the Class")
cor(pedigree,class)
message("The Correlation Between 8th attribute and the Class")
cor(age,class)
message(" The Maximum correlation is between Plasma glucose concentration and the class attribute")

dataframe <- as.data.frame(data)
val <- cor(dataframe[1],dataframe[2])
for(i in 1:8){
  for( j in 1:8){
    if(i!=j){
    val1 <- cor(dataframe[i],dataframe[j])
    if(val<val1){
      val <- val1
      att1 = i
      att2 = j
    }
    }
  }
}
message(" The highest correlation is : ")
print(val)
print(" The Correlation is between attributes :")
print(att1)
print(att2)
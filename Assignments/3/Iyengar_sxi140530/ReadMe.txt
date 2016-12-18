Assignment 3:

Name : Srikant Iyengar
Net Id: sxi140530

***********************************************************************************************************************
Contents:

4 folders named Part1, Part2, Part3 and Part4 respectively

data.csv - Data for the current assignment
ReadMe file - Current file
Report.doc -  Report containing the results for the assignment and explanation.

Part1 - Part1.R - R script file for I.Exploratory Data Analysis part of the assignment. 
	Also contains images for all the barplots and the histograms for this question.
	For answers associated with this question refer the report.

Part2 - Part2.R - R script file for II. Naïve Bayesian Classifier part of the assignment.
	For answers associated with this question refer the report.

Part3 - Part3.R - R script file for III. SVM Classifier part of the assignment.
	For answers associated with this question refer the report.

Part4 - Part4.R - R script file for IV.kNN part of the assignment.
	For answers associated with this question refer the report.

***************************************************************************************************************************

Run the files using rscript:

We can run the script via command line by using the command:

RScript "path of R script file" "data file path"

P.S : Include the "" marks if you have spaces in the filepath.

Example:

if the path of the RScript file is: "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\Part 1\Part1.R" and the
path of the data file is : "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\data.csv" then the command is:

RScript "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\Part 1\Part1.R" "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\data.csv"	
RScript "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\Part 2\Part2.R" "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\data.csv"
RScript "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\Part 3\Part3.R" "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\data.csv"
RScript "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\Part 4\Part4.R" "C:\Users\Ajay Srrinivas\Desktop\srikant\ML Slides\Assignment 3\data.csv"

P.S : Make sure you install all the R binaries and set the class path for RScript.exe to run the RScript command. In case of a linux system th RScript command 
can be accessed directly without the need to set the class path.

For the first question the plots and graphs will be expoted in a file called Rplots.pdf by default into the current working directory. Please make sure you have 
all the necessary permission in the directory for the code to wrk properly.

****************************************************************************************************************************


Packages used and install commands:

For the assignment the following packages were used:
1. klaR
2. caret
3. e1071
4. class

The install commands are directly incorporated into the R code. You need not install any of these pakages separately. Incase of errors in installation 
try the following commands separately:

install.packages("klaR", repos = "http://cran.rstudio.com/")
install.packages("caret" , repos = "http://cran.rstudio.com/")
install.packages("e1071", repos="http://cran.rstudio.com/")
install.packages("class",repos = "http://cran.rstudio.com/")

Data:

I have used the data as present in the submission folder. I have assumed that the file will not have any header and hence used names such as V1,V2....V8 in the
R code. Please include data file without header since the original data file did not have any headers.
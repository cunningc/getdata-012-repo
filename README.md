---
title: "getdata-012 project README.md"
author: "Anthony C Cunningham"
date: "April 25, 2015"
output: html_document
---
This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
***
This README.md is for the getdata-012 class project explains how all of the scripts work and how they are connected.

***
#### PROJECT REPOSITORY COMPONENTS:
README.md - this file  
CodeBook.md - describes the variables, the data, and any transformations  
run_analysis.R - script for processing raw data into tidy data and analysis summary  
tidy_data.csv - tidy data set that can be used for analysis  

***
#### PROCESSING STEPS:
The run_analysis.R "R"" script does the following:  
0) Download the source data from URL and extract raw data files
1) Merge the training and the test sets to create one data set.  
2) Extracts only the measurements on the mean and standard deviation for each measurement.  
3) Uses descriptive activity names to name the activities in the data set  
4) Appropriately label the data set with descriptive variable names.  
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

***
---
When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

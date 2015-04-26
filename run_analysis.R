## run_analysis.R does the following functions:
## ---------- NOTE ----------
## this script will create appropriate target directories
## for the data it is working with relative to the working dir
## ---------- ---- ----------
## for test purposes....
## setwd("getdata-012/project") // used for test only

## *********************** Inertial Signals Processing ****************
## see 'inertial_signals.R
## ********************************************************************

library(dplyr) ## using dplyr functions

## ********************** Download and Extract ***************************
path2url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile<-"data/FUCIDataset.zip"
## download source data
if(!file.exists(zipfile)){
        download.file(path2url,zipfile,method="curl") 
        dateDownloaded<-date()
        ## unzip zipfile (use default dir structure)
        unzip(zipfile) 
}
## pull list of files in zipfile without extracting
ziplist<-unzip(zipfile,list=TRUE) 
## create file index for processing
fileIndex<-as.vector((ziplist[,1])) 
## write.csv(fileIndex, "fileIndex.csv") - used for testing

## -- NOTE see CodeBook.md for fileIndex details

## ****** Test ID Labels and Column Labels ***************************
## create the test label key index (from activity_labels.txt)
test_key<-read.table(fileIndex[1]) ## read in the activity_labels file
colnames(test_key)<-c("test_id","activity") ## set col names for test_key
## Use test_key table to replace test indexes with readable names

## load in the 'features.txt' column index
## features has data column names
features <- read.table(fileIndex[2]) ## read in the features file
features <- as.matrix(features) ## convert data frame to matrix
features <- as.vector(features[,2]) ## create vector of test types
## Use features to label test result data columns

## features data has mixed case and special characters
## this step reduces the complexity to make better column names
features<-tolower(features) ## make all lower case
features<-gsub("\\()","", features) ## remove double parens .. use \\ for special char "("
features<-gsub(")","", features) ## remove extra right parens
features<-gsub("\\(","-", features) ## replace extra left parens
features<-gsub(",","-", features) ## replace extra commas

## example grep command to find all entries with either "std" or "mean...
## ---- grep("std|mean", features, value=TRUE)

## *********************** Test Data Processing ****************
## NOTES:
## 'test/subject_test.txt: subject identifier fileIndex[16]  (2947 rows)
## 'test/X_test.txt': Test set raw data.      fileIndex[17]  (1,653,267 rows)
## -- note: the key to this data set is the "features.txt' file (561 records)
## -- this file must be used to segment the data into 561 columns
## -- this will result in a table with 2497 rows and 561 columns
## 'test/y_test.txt': Test identifiers (ID).  fileIndex[18]   (2947 rows)
## -- note: this file references the'activity_labels.txt' file with 'test_key' var
## -- use this to transform the numeric codes to string labels

## -- load in the TEST SUBJECT ID DATA ('subject_test.txt')
s<-scan(fileIndex[16]) ## scan in subject data
subjects<-matrix(s, ncol=1, byrow=T) ## transform to matrix
colnames(subjects)<-"subject_id" ## set col name
subjects<-as.data.frame(subjects) ## convert to data frame

## load in the TEST MEASUREMENT DATA ('X_test.txt')
## s<-scan(fileIndex[17], nmax=5610) ## use for trial scan (limit the input)
s<-scan(fileIndex[17]) ## scan in test result data
Test_data<-matrix(s, ncol=561, dimnames=list(NULL,features)) ## transform to matrix
Test_data<-as.data.frame(Test_data) ## converts to data frame
## Test_Data is the raw test result data

## load in the TEST ID DATA ('y_test.txt)
s<-scan(fileIndex[18]) ## scan in test ID's file
tests<-matrix(s, ncol=1, byrow=T) ## transform to matrix
colnames(tests)<-"test_id" ## set col name
tests<-as.data.frame(tests) ## convert to data frame
activity <- merge(tests,test_key,by="test_id")
activity = select(activity, activity) ## results in single column for activity name
## activity is table of test activities to cbind() with test data

## merge SUBJECT, ACTIVITY AND TEST_DATA into single data frame 'Test_data'
Test_data<-cbind(subjects, activity, Test_data) ## combine all columns in 3 tables
## Test_data[1:5,1:4] ## can be used to check the merge

## clear temporary data

## *********************** Train Data Processing ****************
## NOTES:
## 'train/subject_train.txt: subject identifier fileIndex[30]  (... rows)
## 'train/X_train.txt': Train raw data set.     fileIndex[31]   (... rows)
## -- note: the key to this data set is the "features.txt' file (561 records)
## -- this file must be used to segment the data into 561 columns
## -- this will result in a table with 2497 rows and 561 columns
## 'test/y_test.txt': Test identifiers.  fileIndex[32]   (... rows)
## -- note: this file references the'activity_labels.txt' file 
## -- use this to transform the numeric codes to string labels

## -- load in the SUBJECT ID DATA ('subject_test.txt')
s<-scan(fileIndex[30]) ## scan in subject data
subjects<-matrix(s, ncol=1, byrow=T) ## transform to matrix
colnames(subjects)<-"subject_id" ## set col name
subjects<-as.data.frame(subjects) ## convert to data frame

## load in the TRAIN MEASUREMENT DATA ('X_train.txt')
s<-scan(fileIndex[31]) ## scan in test data
## s<-scan(fileIndex[31], nmax=5610) ## test scan (limit the input)
Train_data<-matrix(s, ncol=561, dimnames=list(NULL,features)) ## transform to matrix
Train_data<-as.data.frame(Train_data) ## converts to data frame

## load in the TEST ID DATA ('y_test.txt)
s<-scan(fileIndex[32]) ## scan in test labels
train<-matrix(s, ncol=1, byrow=T) ## transform to matrix
colnames(train)<-"test_id" ## set col name
train<-as.data.frame(train) ## convert to data frame
## -- Note: test_key (from activity_labels.txt) created during test processing
activity <- merge(train,test_key,by="test_id") ## combine with test_key 
activity = select(activity, activity) ## results in single column for activity

## merge SUBJECT ID, ACTIVITY AND MEASUREMENT into single data frame
Train_data<-cbind(subjects, activity, Train_data) ## combine all columns in 3 tables
## Test_data[1:5,1:4] ## to check the merge

## *********************** Tidy Data Set Processing ****************
## combine test and train with rbind()
results_data<-rbind(Train_data, Test_data)
## ---- remove un-needed data frames from memory
rm(Test_data)
rm(Train_data)
rm(subjects)
rm(activity)
## ----- write full raw data 'tidy' data file 'tidy_measurements_data.csv'
write.csv(results_data, file = "tidy_measurements_data.csv")

## *********************** Mean and STD Data Processing ****************
## ------- subset results_data to only mean and standard deviation data
results_data<-results_data[,grep("std|mean", features)]
## x<-names(results_data[grep("std|mean", features)])
## mean-std_data<-(select(results_data, grep("std|mean", features)))
## results_data[1:5,1:85] ## to check the resulting data set

## ----- write data file 'tidy_mean-std_data.csv'
write.csv(results_data, file = "tidy_mean-std_data.csv", row.names = FALSE)

## *********************** Mean and STD Data Processing ****************
## --- average the variables for each activity and each subject




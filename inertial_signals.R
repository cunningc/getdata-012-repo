## run_analysis.R does the following functions:
## ---------- NOTE ----------
## this script will create appropriate target directories
## for the data it is working with relative to the working dir
## ---------- ---- ----------
## for test purposes....
## setwd("getdata-012/project") // used for test only
## setwd("UCI HAR Dataset") // used for test only
library(dplyr) ## using dplyr functions

## 0) Download source data and extract raw files
## --------begin 0 ------------------------
path2url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile<-"data/FUCIDataset.zip"
if(!file.exists(zipfile)){
        download.file(path2url,zipfile,method="curl") ## download source data
        dateDownloaded<-date()
        unzip(zipfile) ## unzip zipfile (use default dir structure)
}
ziplist<-unzip(zipfile,list=TRUE) ## pull list of files in zipfile without extracting
fileIndex<-as.vector((ziplist[,1])) ## create file index for processing
## --------- end step 0 ------------------------
## -- NOTE see CodeBook.md for fileIndex details

## *********************** Inertial Signals Processing ****************
## ------- Build test signal data set (dat) ------------------------
## -- test inertial signals are at fileIndex[7] to fileIndex[15]
## -- REF commands:
## -- nchar(fileIndex[7]) ## counts number of chars in a string
## -- unlist(strsplit(fileIndex[7], "/")) ## splits a string by specified str into a vector
## -- substr("simple text",1,3) ## extracts substring (data,start,length)

## initialize new matrix (dat) to accept signal data from individual files
l<-length(scan(fileIndex[7]))
dat <- matrix(,ncol = 1,nrow=l) ## initializes empty matrix with proper length
for(i in 7:15) {
        x<-unlist(strsplit(fileIndex[i], "/")) ## breaks fileIndex into pieces
        y=x[length(x)] ## get filename from x (the last element in x)
        z<-substr(y,1,nchar(y)-9) ## get short name from y for column name
        s<-scan(fileIndex[i]) ## load in the data
        tmp<-matrix(s, ncol = 1, byrow = T)
        colnames(tmp) <- z ## set name of the input column
        dat <- cbind(dat, tmp)
        ## note with cbind() the source and target must be of the same length
}
dat <- as.data.frame(dat[,c(2:10)]) ## remove empty starter col (1)
rm(tmp) ## clean up unused variables
## ------- END Test signal data set (dat) ------------------------

## ------- BEGIN Train signal data set (dat2) ------------------------
## -- Train inertial signals are at fileIndex[21] to fileIndex[29]

## initialize new matrix (dat) to accept data from individual files
l<-length(scan(fileIndex[21]))
dat2 <- matrix(,ncol = 1,nrow=l) ## initializes a matrix with proper length
## test_signals = data.table
for(i in 21:29) {
        x<-unlist(strsplit(fileIndex[i], "/")) ## breaks fileIndex into pieces
        y=x[length(x)] ## get filename from x (the last element in x)
        z<-substr(y,1,nchar(y)-10) ## get short name from y for column name
        s<-scan(fileIndex[i]) ## load in the data
        tmp<-matrix(s, ncol = 1, byrow = T)
        colnames(tmp) <- z ## set name of the input column
        dat2 <- cbind(dat2, tmp)
        ## note with cbind() the source and target must be of the same length
}
dat2 <- as.data.frame(dat2[,c(2:10)]) ## remove empty starter col (1)
rm(tmp) ## clean up unused variables
## ------- end Train signal data set (dat2) ------------------------

## -- Combine Test (dat) & Train (dat2) Inertial Signals with rbind()
## -- and write to tidy_inertial_signals.csv file on disk
dat<-rbind(dat,dat2)
write.csv(dat, file = "tidy_inertial_signals.csv", row.names = FALSE)
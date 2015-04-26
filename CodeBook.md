---
title: "getdata-012_proj_codebook.d"
author: "Anthony C Cunningham"
date: "March 5, 2015"
output: html_document  
---
This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.  

***
### PURPOSE
This code book that describes the variables, the data, and transformations or work performed to clean up the data for the getdata-012 class project.

***
### STUDY DESIGN
This section describes how the data is collected.  
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities while wearing a smartphone (Samsung Galaxy S II) on the waist.:  
1 - WALKING  
2 - WALKING_UPSTAIRS  
3 - WALKING_DOWNSTAIRS  
4 - SITTING  
5 - STANDING  
6 - LAYING  

Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.  
The obtained dataset has been randomly partitioned into two sets:  
- 70% of the volunteers was selected for generating the TRAINING DATA  
- 30% for TEST DATA.     

#### Attribute Information
For each record in the dataset it is provided:  
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.   
- Triaxial Angular velocity from the gyroscope.  
- A 561-feature vector with time and frequency domain variables. 
        -- note each record will have 561 result variables
        -- the raw data set should have a row count of 561 x (# records)
- Its activity label.  
        -- note there will be an activity label for each result record
- An identifier of the subject who carried out the experiment. 
        -- note there will be a subject identifier for each result record

#### Data Source URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

#### The dataset includes the following files:  
- 'README.txt'  contains descriptive info about source files  
- 'features_info.txt': Shows information about the variables used on the feature vector.  
- 'features.txt': List of all features (used as variable names).  (561 rows)   
- 'activity_labels.txt': Links the numeric activity labels with their name (use to make readable activity names in tidy data).  (6 rows)

- 'train/X_train.txt': Training set.  
- 'train/y_train.txt': Training labels.  (7299 rows)  
- 'train/subject_train.txt: Subject Identifier. (7299 rows) Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'test/X_test.txt': Test set.  
- 'test/y_test.txt': Test labels.  (2947 rows)  
- 'test/subject_test.txt: Subject Identifier. (2947 rows) Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The Inertial Signals raw data are available for the train and test data in a subdirectory called "Inertial Signals". It contains a set of signal files for each of the train and test data. Their descriptions are detailed in the 'Readme.txt' file of the UCI HAR Dataset. The "Inertial Signals" raw data is processed into a tidy data set of its own ('tidy_inertial_signals.csv') using 'inertial_signals.R' but is not used to create the analysis summary file 'tidy_data.csv'.

#### Acknowledgements  
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

***
### CODE BOOK
This section describes the variables and their units.  
- path2url holds the sourcefile url  
- zipfile holds the zip file name  
- dateDownloaded holds the download date
- fileIndex vector indexing the files in the zip source file


##### fileIndex
 [1] "UCI HAR Dataset/activity_labels.txt"                         
 [2] "UCI HAR Dataset/features.txt"                                
 [3] "UCI HAR Dataset/features_info.txt"                           
 [4] "UCI HAR Dataset/README.txt"                                  
 [5] "UCI HAR Dataset/test/"                                       
 [6] "UCI HAR Dataset/test/Inertial Signals/"                      
 [7] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"   
 [8] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"   
 [9] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"   
[10] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"  
[11] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"  
[12] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"  
[13] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"  
[14] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"  
[15] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"  
[16] "UCI HAR Dataset/test/subject_test.txt"                       
[17] "UCI HAR Dataset/test/X_test.txt"                             
[18] "UCI HAR Dataset/test/y_test.txt"                             
[19] "UCI HAR Dataset/train/"                                      
[20] "UCI HAR Dataset/train/Inertial Signals/"                     
[21] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
[22] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt"  
[23] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt"  
[24] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"  
[25] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"  
[26] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"  
[27] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"  
[28] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"  
[29] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"  
[30] "UCI HAR Dataset/train/subject_train.txt"                     
[31] "UCI HAR Dataset/train/X_train.txt"                           
[32] "UCI HAR Dataset/train/y_train.txt"  

***
### SUMMARY CHOICES
This section describes the summary choices made for analysis.  
Project assignment is to create a tidy data set with the average of each variable for each activity and each subject. These data points are contained in the 'train/X_train.txt'and the 'test/X_test.txt' raw data sets therefore the "Inertial Signals" raw data is processed into a tidy data set of its own ('tidy_inertial_signals.csv') using 'inertial_signals.R' but is not used to create the analysis summary file 'tidy_data.csv'.

***
### INSTRUCTION LIST
Reference r-script "run_analysis.R"  
Input is raw data from source URL  
Output is Tidy data for later analysis  
*italics Note if all processing steps are not documented in the r-script, detailed instructions are here:*  


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

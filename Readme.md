### Readme for Data Cleansing Course Project

This readme file is documentation for runAnalysis.R located in this folder.

The purpose of the code is to transform the data below into a tidy dataset for analysis. 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This program will merge the trainset and output a file named tidy.csv where the original data 
is merged into a single data set only the mean and standard deviation measures are extracted.

It is dependant on dfsql.

It also outputs a second indepdant tidy data set with the average for each variable for each activity for each subject.

The data sets are labeled with the SUBJECT_ID for the subject and ACTIVITY_NAME for the activity.  Measures are kept with their original names from the dataset.
################################################################################
## R Programming Class File
##
#Here are the data for the project: 
#
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
#
#
# Assums data is local in data
#
# Prereq: sqldf package
#


#################################################################################
# Read the activity Data Object
activity_labels <- read.table('data/UCI HAR Dataset/activity_labels.txt');
colnames(activity_labels)[1] <- "ACTIVITY_ID";
colnames(activity_labels)[2] <- "ACTIVITY_NAME";
activity_labels; summary(activity_labels);

#################################################################################
# Parse the Feature Data
features <- read.table('data/UCI HAR Dataset/features.txt');
colnames(features)[1] <- "COLUMN_ID";
colnames(features)[2] <- "FEATURE_NAME";

featureMeasure <- c();
featureCalculation <- c();
featureAxis <- c();


for( i in 1 : nrow(features)) {
  detailedType <- unlist(strsplit(toString(features$FEATURE_NAME[i]), "-"));
  
  featureMeasure[i] <- detailedType[1];
  featureCalculation[i] <- detailedType[2];  
  featureAxis[i] <- detailedType[3];
  
}

features <- cbind(features, featureMeasure);
features <- cbind(features, featureCalculation);
features <- cbind(features, featureAxis);


#################################################################################
# Read X and Y transfer data 
x_test <- read.table('data/UCI HAR Dataset/test/x_test.txt');
colnames(x_test) <- features$FEATURE_NAME;

x_train <- read.table('data/UCI HAR Dataset/train/x_train.txt');
colnames(x_train) <- features$FEATURE_NAME;

y_test <- read.table('data/UCI HAR Dataset/test/y_test.txt');
colnames(y_test)[1] <- "ACTIVITY_ID"; 

y_train <- read.table('data/UCI HAR Dataset/train/y_train.txt');
colnames(y_train)[1] <- "ACTIVITY_ID"; 


##################################################################################
# Set Human Readable labels on Y

activity_test <- merge(activity_labels, y_test,by="ACTIVITY_ID");
activity_train <- merge(activity_labels, y_train,by="ACTIVITY_ID");

##################################################################################
# Get the columns for the mean and sdev data

features_mean <- sqldf('select COLUMN_ID from features where featureCalculation="mean()"');
for ( i in 1: length(features_mean$COLUMN_ID)) {
  if ( i == 1 ) {
    x_test_mean <- x_test[features_mean$COLUMN_ID[i]];
    x_train_mean <- x_train[features_mean$COLUMN_ID[i]];    
  }
  else {    
    x_test_mean <- cbind(x_test_mean, x_test[features_mean$COLUMN_ID[i]] );
    x_train_mean <- cbind(x_train_mean, x_train[features_mean$COLUMN_ID[i]] );
  }
}
activity_train_mean <- cbind( activity_train, x_train_mean);
activity_test_mean <- cbind( activity_test, x_test_mean);


features_sdev <- sqldf('select COLUMN_ID from features where featureCalculation="std()"');
for ( i in 1: length(features_sdev$COLUMN_ID)) {
  if ( i == 1 ) {
    x_test_sdev <- x_test[features_sdev$COLUMN_ID[i]];
    x_train_sdev <- x_train[features_sdev$COLUMN_ID[i]];    
  }
  else {    
    x_test_sdev <- cbind(x_test_sdev, x_test[features_sdev$COLUMN_ID[i]] );
    x_train_sdev <- cbind(x_train_sdev, x_train[features_sdev$COLUMN_ID[i]] );
  }
}

activity_test_sdev <- cbind( activity_test, x_test_sdev);
activity_train_sdev <- cbind( activity_train, x_train_sdev);

######################################################################################################
## Merge the data sets by name.


activity_mean <- rbind(activity_test_mean, activity_train_mean);

activity_sdev <- rbind(activity_test_sdev, activity_train_sdev);

activity <- cbind( activity_mean, activity_sdev );

#write.table(activity, "activity.csv", sep="\t");



#######################################################################################################
# Merge all and make a tidy Data Set

tb_make_tidy <- function (subject_activity_test) {
  
  colnames(subject_activity_test)[1] <- "SUBJECT_ID"; 
  
  colnamesMapBack <- c();
  
  summarySql <- 'select subject_id, activity_name';
  for( i in 4 : ncol(subject_activity_test) ) {
    colnamesMapBack[i-3] = colnames(subject_activity_test)[i];
    colnames(subject_activity_test)[i] <- paste(c( "M_", i ), collapse = "");
    summarySql <- paste(c( summarySql, ', avg(',  colnames(subject_activity_test)[i], ')' ), collapse="");
    summarySql;
  }
  summarySql <- paste(c(summarySql, ' from subject_activity_test group by subject_id, activity_name'), collapse="");
  
  
  tidy_data <- sqldf(summarySql);
  
  for( i in 4 : ncol(subject_activity_test) ) {
    colnames(tidy_data)[i-1] = colnamesMapBack[i-3];
    
  }
  
  tidy_data;
}

subject_test <- read.table('data/UCI HAR Dataset/test/subject_test.txt');
subject_train <- read.table('data/UCI HAR Dataset/train/subject_train.txt');

subject_activity_test_mean <- cbind(subject_test, activity_test_mean);
subject_activity_train_mean <- cbind(subject_train, activity_train_mean);

subject_activity_mean <- rbind( subject_activity_test_mean, subject_activity_train_mean );

subject_activity_test_sdev <- cbind(subject_test, activity_test_sdev);
subject_activity_train_sdev <- cbind(subject_train, activity_train_sdev);
subject_activity_sdev <- rbind( subject_activity_test_sdev, subject_activity_train_sdev );

subject_activity <- cbind(subject_activity_mean, subject_activity_sdev);

tidy <- tb_make_tidy( subject_activity );

write.table(subject_activity, "subject_activity.csv", sep="\t");
write.table(tidy, "tidy.csv", sep="\t");



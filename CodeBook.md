## This is the codebook for Getting and Cleaning Data Course Project

The original variables read are 

	SUBJECT_ID - An identifier of the subject who carried out the experiment.
	ACTIVITY_NAME - The activity performed by object under test.
	<many metrics>
	
	
The output is only the measures that are standard deviation and mean.

	SUBJECT_ID - An identifier of the subject who carried out the experiment.
	ACTIVITY_NAME - The activity performed by object under test.
	"tBodyAcc-std()-X"           "tBodyAcc-std()-Y"          
 [5] "tBodyAcc-std()-Z"           "tGravityAcc-std()-X"        "tGravityAcc-std()-Y"        "tGravityAcc-std()-Z"       
 [9] "tBodyAccJerk-std()-X"       "tBodyAccJerk-std()-Y"       "tBodyAccJerk-std()-Z"       "tBodyGyro-std()-X"         
[13] "tBodyGyro-std()-Y"          "tBodyGyro-std()-Z"          "tBodyGyroJerk-std()-X"      "tBodyGyroJerk-std()-Y"     
[17] "tBodyGyroJerk-std()-Z"      "tBodyAccMag-std()"          "tGravityAccMag-std()"       "tBodyAccJerkMag-std()"     
[21] "tBodyGyroMag-std()"         "tBodyGyroJerkMag-std()"     "fBodyAcc-std()-X"           "fBodyAcc-std()-Y"          
[25] "fBodyAcc-std()-Z"           "fBodyAccJerk-std()-X"       "fBodyAccJerk-std()-Y"       "fBodyAccJerk-std()-Z"      
[29] "fBodyGyro-std()-X"          "fBodyGyro-std()-Y"          "fBodyGyro-std()-Z"          "fBodyAccMag-std()"         
[33] "fBodyBodyAccJerkMag-std()"  "fBodyBodyGyroMag-std()"     "fBodyBodyGyroJerkMag-std()"
	"tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
 [5] "tBodyAcc-mean()-Z"           "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
 [9] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"       "tBodyGyro-mean()-X"         
[13] "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"          "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
[17] "tBodyGyroJerk-mean()-Z"      "tBodyAccMag-mean()"          "tGravityAccMag-mean()"       "tBodyAccJerkMag-mean()"     
[21] "tBodyGyroMag-mean()"         "tBodyGyroJerkMag-mean()"     "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
[25] "fBodyAcc-mean()-Z"           "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"      
[29] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"          "fBodyAccMag-mean()"         
[33] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroJerkMag-mean()"

The raw data is in the file subject_activity.csv which contains all data for both the training and transfer sets.  
The summarized data is in tidy.csv containing the averages for all measurs by SUBJECT_ID and ACTIVITY_NAME.	

 
# **Codebook for the course project**
# **"Getting and Cleaning Data"**


The text below describes the data, variables, transformations and  work performed to clean up the data in the project. 

## **DATA**

The raw data for the project were obtained from the site:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

A full description of the data is available in the files `Readme` and `features_info` inside the zip archive. 

The project uses raw data from the following files in the zip archive:

* `features.txt`: List of all features.
* `activity_labels.txt`: Links the class labels with their activity name.
* `train/X_train.txt`: Training set.
* `train/y_train.txt`: Training labels.
* `test/X_test.txt`: Test set.
* `test/y_test.txt`: Test labels.
* `train/subject_train.txt`: Identifiers of the train subject who performed the activity for each window sample. 
* `test/subject_test.txt`: Identifiers of  the test subject who performed the activity for each window sample. 

## **Variables**

The projects uses the above datasets to create a data frame with the information from training and test datasets about  values of the mean and standard deviation for each measurement. The developed R code selects the variables that have the following text in their names: `mean()` or `std()`. These variables are used to create the dataframe `datajoin2`. The information about descriptive activity names and numerical codes of subjects is given in the columns   `activitylabs` and `subjects` of `datajoin2`  respectively. 

The variables in the final tidy data frame are:
```{r}
 [1] "subjects"                      "activitylabs"                  "tBodyAcc_mean_X"              
 [4] "tBodyAcc_mean_Y"               "tBodyAcc_mean_Z"               "tBodyAcc_std_X"               
 [7] "tBodyAcc_std_Y"                "tBodyAcc_std_Z"                "tGravityAcc_mean_X"           
[10] "tGravityAcc_mean_Y"            "tGravityAcc_mean_Z"            "tGravityAcc_std_X"            
[13] "tGravityAcc_std_Y"             "tGravityAcc_std_Z"             "tBodyAccJerk_mean_X"          
[16] "tBodyAccJerk_mean_Y"           "tBodyAccJerk_mean_Z"           "tBodyAccJerk_std_X"           
[19] "tBodyAccJerk_std_Y"            "tBodyAccJerk_std_Z"            "tBodyGyro_mean_X"             
[22] "tBodyGyro_mean_Y"              "tBodyGyro_mean_Z"              "tBodyGyro_std_X"              
[25] "tBodyGyro_std_Y"               "tBodyGyro_std_Z"               "tBodyGyroJerk_mean_X"         
[28] "tBodyGyroJerk_mean_Y"          "tBodyGyroJerk_mean_Z"          "tBodyGyroJerk_std_X"          
[31] "tBodyGyroJerk_std_Y"           "tBodyGyroJerk_std_Z"           "tBodyAccMag_mean"             
[34] "tBodyAccMag_std"               "tGravityAccMag_mean"           "tGravityAccMag_std"           
[37] "tBodyAccJerkMag_mean"          "tBodyAccJerkMag_std"           "tBodyGyroMag_mean"            
[40] "tBodyGyroMag_std"              "tBodyGyroJerkMag_mean"         "tBodyGyroJerkMag_std"         
[43] "fBodyAcc_mean_X"               "fBodyAcc_mean_Y"               "fBodyAcc_mean_Z"              
[46] "fBodyAcc_std_X"                "fBodyAcc_std_Y"                "fBodyAcc_std_Z"               
[49] "fBodyAcc_meanFreq_X"           "fBodyAcc_meanFreq_Y"           "fBodyAcc_meanFreq_Z"          
[52] "fBodyAccJerk_mean_X"           "fBodyAccJerk_mean_Y"           "fBodyAccJerk_mean_Z"          
[55] "fBodyAccJerk_std_X"            "fBodyAccJerk_std_Y"            "fBodyAccJerk_std_Z"           
[58] "fBodyAccJerk_meanFreq_X"       "fBodyAccJerk_meanFreq_Y"       "fBodyAccJerk_meanFreq_Z"      
[61] "fBodyGyro_mean_X"              "fBodyGyro_mean_Y"              "fBodyGyro_mean_Z"             
[64] "fBodyGyro_std_X"               "fBodyGyro_std_Y"               "fBodyGyro_std_Z"              
[67] "fBodyGyro_meanFreq_X"          "fBodyGyro_meanFreq_Y"          "fBodyGyro_meanFreq_Z"         
[70] "fBodyAccMag_mean"              "fBodyAccMag_std"               "fBodyAccMag_meanFreq"         
[73] "fBodyBodyAccJerkMag_mean"      "fBodyBodyAccJerkMag_std"       "fBodyBodyAccJerkMag_meanFreq" 
[76] "fBodyBodyGyroMag_mean"         "fBodyBodyGyroMag_std"          "fBodyBodyGyroMag_meanFreq"    
[79] "fBodyBodyGyroJerkMag_mean"     "fBodyBodyGyroJerkMag_std"      "fBodyBodyGyroJerkMag_meanFreq"
```
They were obtained for normalized values of the measurements. Measurement units are reletive values of each variable to its max value.  Each variable is bounded within [-1,1].

## **Transformations**

The R script  performs the following transformations of the original data file:

1.  Unzips the data file
2.	Merges `X_train.txt` and `X_test.txt`
3.	Corrects features names from `features.txt` 
4.	Assigns the corrected future names to dataframe's columns
5.	Extracts the columns with values of the mean and standard deviation into a new dataframe
6.	Merges `y_train.txt` and `y_test.txt`
7.	Replaces the activity numbers by descriptive terms from the file `activity_labels.txt`
8.	Merges `subject_train.txt` and `subject_test.txt`
9.	Groups the data due to subjects and activities
10.	Creates a new dataframe with the mean of each variable for each activity and subject

## **Manipulating data** 

The script  `run_analysis.R`  does the following:

1.	Downloads the data, save them as the file `data.zip`, and unzip it into the folder  `./data1/UCI HAR Dataset`
2.	Merges the training and test sets (`X_train.txt`, `X_test.txt`)  to create the dataframe `datajoin`. Its dimension is 10299 x 561
3.	Reads features names from the file `features.txt`. Then it corrects features names by replacing the symbols "(", ")", ",", "-" by "_" and deleting multiple instances of "_". Finally the corrects features names are used to appropriately label the data set with descriptive variable names.  
4.	Extracts the values of the mean and standard deviation for each measurement (columns containing mean() or std() in their names).
5.	Adds the column `activitylabs` of activity labels merging the information from the files `y_train.txt` and `y_test.txt`. Then it uses the activity numbers in the data and replaces them by descriptive terms from the file `activity_labels.txt`. 
6.	Merges the information from `subject_train.txt` and `subject_test.txt` to create the column `subjects` with subject numbers.
7.	Groups the data in `datajoin2` due to subjects and activities. Then it computes means of each column for the groups(each activity and each subject). The resulting dataframe `datajoin_summarize` has the dimension 180 x 81

## **Writing tidy data to CSV file**
The script saves the resulting dataframe `datajoin_summarize` to the file `averages.txt`. To check that it was written correctly it reads and opens `averages.txt` in R.

`averages.txt`  is a tidy data set with one mean value for each activity, subject, and variable. The results are split into 180 groups (30 subjects and 6 activities).  The resulting dataframe has 81 columns. The first two columns show the numerical code of a subject and the description of an activity respectively. The remaining columns give mean values for each variable. 




# CodeBook
This code book, called "CoodBook.md" describes the variables, the data, and any 
transformations or work performed to clean up the data.

## Data
This data was collected from the accelerometers from the Samsung Galaxy S smartphones.
Human Activity Recognition Using Smartphones Dataset

source :"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
data_downloaded : "Fri Jan 23 21:55:31 2015"

## Transfomations

0. Download and Open files.
* Download and unzip the data.
* The files are txt files (separator "") with no colomns names.

1. Merge the "train" and "test" datasets.
* Add columns to the datasets with the subject and acitivity information
* Merge the rows of the train and the test datasets with `rbind()` "train" and "test" are different observations

2. Extract only mean() and std() for each measurement.
* Open the list of features file
* Identify the features containing "mean()" or "std()" using `grepl`
* Subset the dataset to the variables including "mean()" or "std()"

3. Label variables with appropriate names.
* Set the column names (variables) with the name of the measurement (from the features list)

4. Add descriptive activity names.
* Open the activity labels file to lookup the name of each activity coded by 1-6.
* Add a new column with the activity name as factor variable.

5. Tidy data set with the average of each variable for each (activity, subject).\s\s
* Transform the subject variable into a factor.
* Split the dataset according to the subjets AND the activity (the interaction between the two).
* Calculate the mean by columns for each interaction (activity.subject)
* Save the tidy dataset as a txt file.



## Variables
### Volunteers subjects (1-30)

### Activities 
* WALKING 
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### Measurements 
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.\s\s
* mean(): Mean value
* std(): Standard deviation

        *tBodyAcc-XYZ
        *tGravityAcc-XYZ
        *tBodyAccJerk-XYZ
        *tBodyGyro-XYZ
        *tBodyGyroJerk-XYZ
        *tBodyAccMag
        *tGravityAccMag
        *tBodyAccJerkMag
        *tBodyGyroMag
        *tBodyGyroJerkMag
        *fBodyAcc-XYZ
        *fBodyAccJerk-XYZ
        *fBodyGyro-XYZ
        *fBodyAccMag
        *fBodyAccJerkMag
        *fBodyGyroMag
        *fBodyGyroJerkMag



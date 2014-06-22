
## 1. Data
The data to be processed consists of measurements taken for an accelerometer and gyroscope for subjects performing various activities.
* A more detailed description of the measurement variables can be found in the files: features.txt and features_info.txt 
* A more detailed description of the activities can be found in the file: activity_labels.txt

The original source of the data and meta data files:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 2. Transformation
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The script, run_analysis.R, combines the measurements from the test and train data set, and extracts only the variables for mean and standard deviation. Using only the extracted variables, the script then outputs an independent data set with the average of each variable for each activity and each subject.

The details of the script's actions are:

### 2.1 Read in meta data
* Read in meta data information about the measured variables and activities performed (i.e. information from features.txt and activity_labels.txt).

### 2.2 Read and create Test data frame
* Create a data frame for the test data (i.e. from X_test.txt). 
* Extract only the mean and standard deviation columns from the data frame created in the previous step
* Use information from featurest.txt to name the columns in the test data frame
* Combine the test measurement data with subject (subject_test.txt) and activity information(activity_labels.txt) to form one data frame (i.e. filteredTestData)

### 2.3 Read and create Train data frame
* Create a data frame for the train data (i.e. from X_train.txt). 
* Extract only the mean and standard deviation columns from the data frame created in the previous step
* Use information from featurest.txt to name the columns in the train data frame
* Combine the train measurement data with subject (subject_train.txt) and activity information(activity_labels.txt) to form one data frame (i.e. filteredTraintData)

### 2.4 Combine test and train data sets
* Use rbind to combine the filteredTestData and filteredTrainData data frames (i.e. tidyActivityMeasures)
* Order the tidyAcivityMeasures data frame by subject id

### 2.5 Write activity measures data frame to file
* Write the tidyActivityMeasures data frame to the file tidyActivityMeasures.txt

### 2.6 Compute variable means for each activity and each subject
* Using tidyActivityMeasures, create a second independent tidy data set with the average of each variable for each activity and each subject (i.e. tidyActivityMeans)

### 2.7 Write means data frame to file 
* Write the tidyActivityMeans data frame to the file tidyActivityMeans.txt
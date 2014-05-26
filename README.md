run_analysis.R
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for
  each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each
  variable for each activity and each subject.

The original data was downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and unzipped. run_analysis.R should be run in the directory which
contains the unzipped UCI HAR Dataset

How to run the analysis: source('run_analysis.R')

The result will be a file: tidy_data_set, contains the cleaned data set

tidy_data_set contains:
* Subject
* Activity
* Means for all mean and std type measures for that Subject/Activity pairing

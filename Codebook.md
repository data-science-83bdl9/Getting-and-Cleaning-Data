Processing done on the input files
* Read in the input files:
  * subject_train.txt
  * X_train.txt
  * y_train.txt
  * subject_test.txt
  * X_test.txt
  * y_test.txt
  * activity_labels.txt
  * features.txt
* Concatenate together all training and test data with rbind
* Using feature labels, label the columns with human-readable names to be manageable
* Use grep to form a list of measurements involving mean and std
* Merge activity_labels content to provide nice activity names instead of numbers
* Column bind the subjects, activities, and measurements from above
* Melt and cast using Subjects/Activities as an ID to summarize the data
* Write the data out to a file

tidy_data_set contains:
* Subject
* Activity
* Means for all mean and std type measures for that Subject/Activity pairing

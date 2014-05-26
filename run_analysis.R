# Extract data from files
subject_training <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
training_x <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
training_y <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
test_x <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
feature_labels <- features[,c("V2")]

# Glue training and test data together
subjects <- rbind(subject_training, subject_test)
measurements <- rbind(training_x, test_x)
activity_raw <- rbind(training_y, test_y)

# Provide human-readable column names
colnames(subjects) <- c("Subject")
colnames(activity_raw) <- c("activity_num")
colnames(activity_labels) <- c("activity_num", "Activity")
colnames(measurements) <- feature_labels

# Map activity number to activity name
Activity <- merge(activity_labels, activity_raw, all=TRUE)
Activity <- Activity[, c("Activity")]

# Filter out non-mean/std measurements
feature_labels_mean <- as.character(feature_labels[grep("-mean\\(",feature_labels,ignore.case=TRUE)])
feature_labels_std <- as.character(feature_labels[grep("-std\\(",feature_labels,ignore.case=TRUE)])
feature_labels_filt <- c(feature_labels_mean, feature_labels_std)
measurements_filt <- measurements[,feature_labels_filt]

# Put the table together
bigtable <- cbind(subjects, Activity, measurements_filt)

# Write out to a file
write.table(bigtable, file="tidy_data_set")

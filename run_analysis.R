library(reshape2)

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

# 1. Merges the training and the test sets to create one data set
subjects <- rbind(subject_training, subject_test)
measurements <- rbind(training_x, test_x)
activity_raw <- rbind(training_y, test_y)

# Provide human-readable column names
colnames(subjects) <- c("Subject")
colnames(activity_raw) <- c("activity_num")
colnames(activity_labels) <- c("activity_num", "Activity")

# 4. Appropriately labels the data set with descriptive activity names. 
colnames(measurements) <- feature_labels

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
feature_labels_mean <- as.character(feature_labels[grep("-mean\\(",feature_labels,ignore.case=TRUE)])
feature_labels_std <- as.character(feature_labels[grep("-std\\(",feature_labels,ignore.case=TRUE)])
feature_labels_filt <- c(feature_labels_mean, feature_labels_std)
measurements_filt <- measurements[,feature_labels_filt]

# 3. Uses descriptive activity names to name the activities in the data set
Activity <- merge(activity_labels, activity_raw, all=TRUE)
Activity <- Activity[, c("Activity")]

# Put the table together
bigframe <- cbind(subjects, Activity, measurements_filt)

# 5. Creates a second, independent tidy data set with the average of each
# variable for each activity and each subject.
bigframe_m <- melt(bigframe, id=c("Subject", "Activity"))
tidy_data <- dcast(bigframe_m, Subject + Activity ~ variable, fun.aggregate=mean)

# Write out to a file
write.table(tidy_data, file="tidy_data_set")

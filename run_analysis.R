## Coursera - Getting and Cleaning Data - Course Project
## The purpose of this project is to collect, work with, and clean a data set.
## The goal is to prepare tidy data that can be used for later analysis.
## This project includes the following:
##    1) Merges the training and the test sets to create one data set.
##    2) Extracts only the measurements on the mean and standard deviation for
##       each measurement.
##    3) Uses descriptive activity names to name the activities in the data set.
##    4) Appropriately labels the data set with descriptive variable names.
##    5) Creates a second, independent tidy data set with the average of each
##       variable for each activity and each subject.

# load libraries
library(data.table)
library(plyr)
library(reshape2)

# load test and training data
train_subj <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
train_X <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
train_y <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
#
test_subj <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
test_X <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
test_y <- read.table("./UCI_HAR_Dataset/test/y_test.txt")

# load data's labels
labels_features <- read.table("./UCI_HAR_Dataset/features.txt")
labels_activity <- read.table("./UCI_HAR_Dataset/activity_labels.txt")

# set names to all columns in all loaded datasets (train and test sets)
setnames(train_subj, "SubjectID")
setnames(train_X, as.vector(labels_features$V2))
setnames(train_y, "ActivityType")
#
setnames(test_subj, "SubjectID")
setnames(test_X, as.vector(labels_features$V2))
setnames(test_y, "ActivityType")

# replace numerical code with actual labels for Activity data
# (e.g., 1=WALKING, ..., 6=LAYING)
for(i in 1:6) {
      tmp_train <- train_y$ActivityType==i
      train_y[tmp_train==TRUE,1] <- as.character(labels_activity$V2[i])
      #
      tmp_test <- test_y$ActivityType==i
      test_y[tmp_test==TRUE,1] <- as.character(labels_activity$V2[i])
}

# extract subsets for only variables related to means and standard deviations
train_X_means <- train_X[,grep("mean", names(train_X))]
train_X_stds <- train_X[,grep("std", names(train_X))]
#
test_X_means <- test_X[,grep("mean", names(test_X))]
test_X_stds <- test_X[,grep("std", names(test_X))]

# consolidate each dataset
train_data <- cbind(train_subj, train_y, train_X_means, train_X_stds)
test_data <- cbind(test_subj, test_y, test_X_means, test_X_stds)

# join the two datasets into one
data <- rbind(train_data, test_data)

# create tidy data set with the average of each variable for each activity and
# each subject
data_melt <- melt(data, id.vars = c("ActivityType", "SubjectID"))
data_tidy <- ddply(data_melt, c("ActivityType", "SubjectID"), summarise, 
                   Average = mean(value))

# save data_tidy in working directory
write.table(data_tidy, file="tidyData.txt", row.name=FALSE)

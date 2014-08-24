Course Project for "Getting and Cleaning Data" (Coursera)
==============

Coursera - Getting and Cleaning Data - Course Project

The purpose of this project is to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.
This project includes the following:
  1) Merges the training and the test sets to create one data set.
  2) Extracts only the measurements on the mean and standard deviation for
     each measurement.
  3) Uses descriptive activity names to name the activities in the data set.
  4) Appropriately labels the data set with descriptive variable names.
  5) Creates a second, independent tidy data set with the average of each
     variable for each activity and each subject.

These are the steps performed by the "run_analysis.R" script

- load libraries which are used
- load data and their labels
- set labels' names to correspondent datasets
- for Activity data, replace numerical entries with text labels (e.g., 1=WALKING, ..., 6=LAYING)
- extract subsets for variables related to means and standard deviations
- consolidate the datasets and then join them into one
- create tidy data set with the average of each variable for each activity and each subject
- save tidy data

The script is included in this GitHub repository.
<>

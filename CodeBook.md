##Intro
 This code book describes the variables, the data, and any transformations or work that was performed to clean up the data.
 
##Data
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Script
Call function createTidyDataFile("yourFileName"). To create tidy data file in working directory.
This funtion run these process.
* Process: 1 Prepare data set.
* Process: 2 Merges the training and the test sets to create one data set.
* Process: 3 Extracts only the measurements on the mean and standard deviation for each measurement. 
* Process: 4 Uses descriptive activity names to name the activities in the data set
* Process: 5 Appropriately labels the data set with descriptive variable names. 
* Process: 6 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

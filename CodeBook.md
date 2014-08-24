##Intro
 This code book describes the variables, the data, and any transformations or work that was performed to clean up the data.
 
##Data
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Process:
1. Prepare data set.
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Script
Call function createTidyDataFile("yourFileName"). To create tidy data file in working directory.
This funtion run all process above.
* Process 1:

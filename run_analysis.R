library(plyr)

## Create .csv tidy data file with name in working directory.
createTidyDataFile <- function(name = "") {
    message("Processing Please wait a moment !")

    ## (Process 1): Prepare data set.
    message("Process 1.")
    prepareDataset()

    ## (Process 2): Merges the training and the test sets to create one
    ## data set..
    message("Process 2.")
    mergeData <- mergeDatasets()

    ## (Process 3): Extracts only the measurements on the mean and standard
    ## deviation for each measurement.
    message("Process 3.")
    meanStd <- extractMeanAndStandard(mergeData$x)

    ## (Process 4): Uses descriptive activity names to name the activities
    ## in the data set.
    message("Process 4.")
    activities <- decodeActivitieLabels(mergeData$y)

    ## (Process 5): Appropriately labels the data set with descriptive
    ## variable names.
    message("Process 5.")
    ## Name subject.
    colnames(mergeData$subject) <- c("subject")
    setDescriptiveVariableNames()

    ## (Process 6): Creates a second, independent tidy data set with the
    ## average of each variable for each activity and each subject.
    message("Process 6.")
    tidyData <- createTidyDataset(meanStd, activities, mergeData$subject)

    ## File Name.
    name <- paste(name, ".txt")

    ## Write .csv tidy data file
    message("Creating file ...")
    write.table(tidyData, name , row.names=FALSE)
    message("Finished!")
}

## prepareDataset (Process 1): Prepare data set.
prepareDataset <- function() {
    ## Checks "data" directory if it doesn't exist then create.
    if (!file.exists("data")) {
        message("Creating data directory")
        dir.create("data")
    }

    ## Check is data dowloaded before.
    if (!file.exists("data/UCI HAR Dataset")) {
        ## Data's URL
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        ## File's destination.
        zipData ="data/UCI_HAR_data.zip"

        ## Download data.
        download.file(fileURL, destfile=zipData, method="curl")

        ##Unzip data.
        unzip(zipData, exdir="data")
    }
}

## mergeDatasets (Process 2):Merges the training and the test sets to create one data set..
mergeDatasets <- function() {
    ## Read data from file.
    trainingX <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    trainingY <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    trainingSubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
    testX <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    testY <- read.table("data/UCI HAR Dataset/test/y_test.txt")
    testSubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

    ## Merge Training and Test.
    didMergeX <- rbind(trainingX, testX)
    didMergeY <- rbind(trainingY, testY)
    didMergeSubject <- rbind(trainingSubject, testSubject)

    ## Return merged dataset as list.
    list(x=didMergeX, y=didMergeY, subject=didMergeSubject)
}
## mergeDatasets (Process 3): Extracts only the measurements on the mean and standard deviation for each measurement.
extractMeanAndStandard <- function(data) {
    ## Read feature file.
    features <- read.table("data/UCI HAR Dataset/features.txt")

    ## Get mean columns.
    columnMean <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
    
    ## Get standard columns.
    columnStd <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))

    ## Extract mean and standard from data.
    extractedData <- data[, (columnMean | columnStd)]

    ## Name.
    colnames(extractedData) <- features[(columnMean | columnStd), 2]

    ## Return extracted data.
    extractedData
}

## decodeActivitieLabels (Process 4): Uses descriptive activity names to name the activities in the data set
decodeActivitieLabels <- function(data) {
    ## Name activity.
    colnames(data) <- "activity"

    ## Decode.
    data$activity[data$activity == 1] = "WALKING"
    data$activity[data$activity == 2] = "WALKING_UPSTAIRS"
    data$activity[data$activity == 3] = "WALKING_DOWNSTAIRS"
    data$activity[data$activity == 4] = "SITTING"
    data$activity[data$activity == 5] = "STANDING"
    data$activity[data$activity == 6] = "LAYING"

    ## Return decoded data.
    data
}

## decodeActivitieLabels (Process 5): Appropriately labels the data set with descriptive variable names.
setDescriptiveVariableNames <- function (meanStdData = NULL, activityData = NULL, mergeData = NULL) {
    ## Name was named in decodeActivitieLabels().

    ## Mean was named in extractMeanAndStandard().

    ## Name was named in Process 5.
}

## combineData (Process 6): Creates a second, independent tidy data set with
## the average of each variable for each activity and each subject.
createTidyDataset <- function(meanStd, activities, subjects) {
    ## Combine data.
     combineData <-  cbind(meanStd, activities, subjects)

    ## Create tidy data.
    tidyData <- ddply(combineData, .(subject, activity), function(x) colMeans(x[,1:60]))

    ## Return tiny dataset.
    tidyData
}

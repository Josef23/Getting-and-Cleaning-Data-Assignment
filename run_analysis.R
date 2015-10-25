
# Download dataset from the web and unzip it if it is not already present and unziped in the
# working directory.
setInternet2(use = TRUE)
files <- list.files()
if (!"UCI HAR Dataset" %in% files){
  if (!"getdata_dataset.zip" %in% files){
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, destfile="getdata_dataset.zip", method = "internal")
  }
  unzip("getdata_dataset.zip") 
}


# Read the 'features.txt. file in table format and find the indices that include the words 'mean' and 'std'.
featureNames <- read.table("UCI HAR Dataset/features.txt")[,2]
MeanStdIndex <- grep("mean|std", featureNames)
# Create new table that contains ovly the feature names that contain the words 'mean' and 'std'.
featureNamesMeanStd <- featureNames[MeanStdIndex]


# Read the 'activity_labels.txt' file in table format and change the column names to something descriptive.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("code", "activity")


# Read the 'y_train.txt' file in table format and change the column names to something descriptive.
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(yTrain)<- 'activity'
# Match the code numbers in the table 'yTrain' with descriptive activity names found in table
# 'activityLabels' and replace them.
for (i in 1:nrow(activityLabels)) {
  tempIndex <- yTrain$activity == activityLabels[i,1]
  yTrain$activity[tempIndex] <- as.character(activityLabels[i,2])
}

# Read the 'x_train.txt' file in table format, keep only the columns indicated by the 'MeanStdIndex' indexer
# and give them the apropriate column names from 'featureNamesMeanStd'.
xTrain <- read.table("UCI HAR Dataset/train/x_train.txt")
xTrainMeanStd <- xTrain[,MeanStdIndex]
colnames(xTrainMeanStd) <- featureNamesMeanStd

# Read the 'subject_train.txt' file in table format and change the column names to something descriptive.
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subjectTrain) <- 'subject'

# Create a new table 'trainSet' by binding 'subjectTrain', 'yTrain' and 'xTrainMeanStd' tables column wise.
trainSet <- cbind(subjectTrain, yTrain, xTrainMeanStd)



# Read the 'y_Test.txt' file in table format and change the column names to something descriptive.
yTest <- read.table("UCI HAR Dataset/Test/y_Test.txt")
colnames(yTest)<- 'activity'
# Match the code numbers in the table 'yTest' with descriptive activity names found in table
# 'activityLabels' and replace them.
for (i in 1:nrow(activityLabels)) {
  tempIndex <- yTest$activity == activityLabels[i,1]
  yTest$activity[tempIndex] <- as.character(activityLabels[i,2])
}

# Read the 'x_Test.txt' file in table format, keep only the columns indicated by the 'MeanStdIndex' indexer
# and give them the apropriate column names from 'featureNamesMeanStd'.
xTest <- read.table("UCI HAR Dataset/Test/x_Test.txt")
xTestMeanStd <- xTest[,MeanStdIndex]
colnames(xTestMeanStd) <- featureNamesMeanStd

# Read the 'subject_train.txt' file in table format and change the column names to something descriptive.
subjectTest <- read.table("UCI HAR Dataset/Test/subject_Test.txt")
colnames(subjectTest) <- 'subject'

# Create a new table 'trainSet' by binding 'subjectTrain', 'yTrain' and 'xTrainMeanStd' tables column wise.
testSet <- cbind(subjectTest, yTest, xTestMeanStd)


# Create a new table 'dataSet' by binding 'trainSet' and 'testSet' tables row wise.
dataSet <- rbind(trainSet, testSet)

# Shape the table 'dataSet' into subsets according to the columns 'dataSet$subject' and 'dataSet$activity'
# and calculate the means of the columns in these subsets. Create a new table 'meansSet' that contains all
# the means of these subsets by 'dataSet$subject' and 'dataSet$activity' pairs.
# (The aggregate() function is mentioned in the next course 'Exploratory Data Analysis' which I follow
# at the same time as this one. I think I used it correctly here as it returns a table of 180 rows (one row
# for each subject-activity pair) and 81 columns (one column for each one of the 79 mean-std features, 1
# for the activity name and 1 for the subject number). Also running the line
# mean(dataSet[dataSet$subject==subNumber&dataSet$activity==activityName, columnNumber]
# for any given subNumber, activityName and columnNumber in the 'dataSet' table, retuns the correct mean.) 
meansSet <- aggregate(dataSet[,-(1:2)], list(subject = dataSet$subject,  activity = dataSet$activity), mean)

# Save the tabkle 'meansSet'.
tidySet <- write.table(meansSet, file = "tidy_set.txt", row.name=FALSE, sep = " ")

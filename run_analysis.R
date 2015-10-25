

setInternet2(use = TRUE)
files <- list.files()
if (!"UCI HAR Dataset" %in% files){
  if (!"getdata_dataset.zip" %in% files){
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, destfile="getdata_dataset.zip", method = "internal")
  }
  unzip("getdata_dataset.zip") 
}

featureNames <- read.table("UCI HAR Dataset/features.txt")[,2]
MeanStdIndex <- grep("mean|std", featureNames)
featureNamesMeanStd <- featureNames[MeanStdIndex]



activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("code", "activity")



yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(yTrain)<- 'activity'
for (i in 1:nrow(activityLabels)) {
  tempIndex <- yTrain$activity == activityLabels[i,1]
  yTrain$activity[tempIndex] <- as.character(activityLabels[i,2])
}

xTrain <- read.table("UCI HAR Dataset/train/x_train.txt")
xTrainMeanStd <- xTrain[,MeanStdIndex]
colnames(xTrainMeanStd) <- featureNamesMeanStd

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subjectTrain) <- 'subject'

trainSet <- cbind(subjectTrain, yTrain, xTrainMeanStd)



yTest <- read.table("UCI HAR Dataset/Test/y_Test.txt")
colnames(yTest)<- 'activity'
for (i in 1:nrow(activityLabels)) {
  tempIndex <- yTest$activity == activityLabels[i,1]
  yTest$activity[tempIndex] <- as.character(activityLabels[i,2])
}

xTest <- read.table("UCI HAR Dataset/Test/x_Test.txt")
xTestMeanStd <- xTest[,MeanStdIndex]
colnames(xTestMeanStd) <- featureNamesMeanStd

subjectTest <- read.table("UCI HAR Dataset/Test/subject_Test.txt")
colnames(subjectTest) <- 'subject'

testSet <- cbind(subjectTest, yTest, xTestMeanStd)


dataSet <- rbind(trainSet, testSet)


meansSet <- aggregate(dataSet[,-(1:2)], list(subject = dataSet$subject,  activity = dataSet$activity), mean)

tidySet <- write.table(meansSet, file = "tidy_set.txt", row.name=FALSE, sep = " ")

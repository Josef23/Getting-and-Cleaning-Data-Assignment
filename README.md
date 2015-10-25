# Getting-and-Cleaning-Data-Assignment
Repo of the assignment of the the Coursera course 'Getting and Cleaning Data'. 

Assignment description:

    The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal
    is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of
    yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2)
    a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the
    variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
    You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work
    and how they are connected. 
    
    One of the most exciting areas in all of data science right now is wearable computing - see for example this
    article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to
    attract new users. The data linked to from the course website represent data collected from the accelerometers
    from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
    
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    
    Here are the data for the project:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
    You should create one R script called run_analysis.R that does the following. 
    
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
    each activity and each subject.
    
    Good luck!


Solution description:
    
    Download dataset from the web and unzip it if it is not already present and unziped in the working directory.
    
    Read the features file and find the indices that include the words 'mean' and 'std'. This includes 'meanFreq'.
    I took 'meanFreq' to be another mean in the data set.
    
    Create new table that contains ovly the feature names that contain the words 'mean' and 'std'. I didn't change
    the feature names to something "prettier" because I am in no position to know the significance of each
    abreviation used in the names. If I was the initial data collector though, I would try to do a better job than
    this.
    
    Read the 'activity_labels.txt' file in table format and change the column names to something descriptive.
    
    Read the 'y_train.txt' file in table format and change the column names to something descriptive.
    
    Match the code numbers in the table 'yTrain' with descriptive activity names found in table 'activityLabels'
    and replace them.
    
    Read the 'x_train.txt' file in table format, keep only the columns indicated by the 'MeanStdIndex' indexer and
    give them the apropriate column names from 'featureNamesMeanStd'.
    
    Read the 'subject_train.txt' file in table format and change the column names to something descriptive.
    
    Create a new table 'trainSet' by binding 'subjectTrain', 'yTrain' and 'xTrainMeanStd' tables column wise.
    
    Read the 'y_Test.txt' file in table format and change the column names to something descriptive.
    
    Match the code numbers in the table 'yTest' with descriptive activity names found in table 'activityLabels' and
    replace them.
    
    Read the 'x_Test.txt' file in table format, keep only the columns indicated by the 'MeanStdIndex' indexer and
    give them the apropriate column names from 'featureNamesMeanStd'.
    
    Read the 'subject_train.txt' file in table format and change the column names to something descriptive.
    
    Create a new table 'trainSet' by binding 'subjectTrain', 'yTrain' and 'xTrainMeanStd' tables column wise.
    
    Create a new table 'dataSet' by binding 'trainSet' and 'testSet' tables row wise.
    
    Shape the table 'dataSet' into subsets according to the columns 'dataSet$subject' and 'dataSet$activity' and
    calculate the means of the columns in these subsets. Create a new table 'meansSet' that contains all the means 
    of these subsets by 'dataSet$subject' and 'dataSet$activity' pairs.
    
    Save the table 'meansSet' as 'tidy_set.txt'.
    

# CouseraGettingAndCleaningDataProject
Project for Cousera course

This repo holds the documentation and R code files for the Cousera "Getting and Cleaning Data Project". 

The dataset being used is: Human Activity Recognition Using Smartphones

How all of the scripts work and how they are connected:

The code in run_analysis.R assumes that the data is unzipped and located is the same directory. 

run_analysis.R contains code that- 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.


From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The resulting file from these steps is called tidy_data_set.txt, and can be found on the Git repo as well as the Cousera site. 

CodeBook.md describes the data.

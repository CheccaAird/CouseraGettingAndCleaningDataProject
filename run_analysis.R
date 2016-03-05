# 1. Merges the training and the test sets to create one data set.
trainTableX <- read.table("train/X_train.txt")
testTableX <- read.table("test/X_test.txt")

combinedX <- rbind(trainTableX, testTableX)

trainTableSubject <- read.table("train/subject_train.txt")
testTableSubject <- read.table("test/subject_test.txt")

combinedSubject <- rbind(trainTableSubject, testTableSubject)

trainTableY <- read.table("train/y_train.txt")
testTableY <- read.table("test/y_test.txt")

combinedY <- rbind(trainTableY, testTableY)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
requiredFeatures <- grep(".*mean.*|.*std.*", features[,2])

combinedX <- combinedX[, requiredFeatures]
names(combinedX) <- features[requiredFeatures, 2]
names(combinedX) = gsub('-mean', 'Mean', names)
names(combinedX) = gsub('-std', 'Std', names)
names(combinedX) <- gsub('[-()]', '', names)

# 3. Uses descriptive activity names to name the activities in the data set.
activityLabels <- read.table("activity_labels.txt")
activityLabels[, 2] = gsub("_", "", tolower(as.character(activityLabels[, 2])))
combinedY[,1] = activityLabels[combinedY[,1], 2]
names(combinedY) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(combinedSubject) <- "subject"
cleaned <- cbind(combinedSubject, combinedY, combinedX)
write.table(cleaned, "merged_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(combinedSubject)[,1]

lengthSubjects = length(unique(combinedSubject)[,1])

lengthActivities = length(activityLabels[,1])

totalCols = dim(cleaned)[2]

cleanData = cleaned[1:(lengthSubjects*lengthActivities), ]
row = 1

    for (s in 1:lengthSubjects) {
      for (a in 1:lengthActivities) {
        
        cleanData[row, 1] = uniqueSubjects[s]
        cleanData[row, 2] = activityLabels[a, 2]
        temp <- cleaned[cleaned$subject==s & cleaned$activity==activityLabels[a, 2], ]
        cleanData[row, 3:totalCols] <- meansCOls(temp[, 3:totalCols])
        
        row = row+1
        
      }
}

write.table(cleanData, "tidy_data_set.txt", row.names = FALSE)
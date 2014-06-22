
# This function transforms the measures data (X_test.txt and X_train.txt) into a data set 
# containing only the columns for mean and std. The information used to transform the raw 
# data comes from the features.txt file
# 
# Inputs:
# (a) rawFrame: data frame representing raw data from either X_test.txt or X_train.txt
# (b) colInfo: data frame representing information from features.txt used to transform 
#     the raw data
#
# Output:
# A data frame with only columns for mean and std variables. 
# Each column is assigned a descriptive name .
# ----------------------------------------------------------------------------------------------------
GetFilteredDataFrame <- function(rawFrame, colInfo)
{
  filteredData <- data.frame(row.names=1:nrow(rawFrame))
  for(i in 1:nrow(colInfo))
  {
    colName <- colInfo$Names[i]
    if(grepl(pattern="mean\\(\\)|std\\(\\)", x=colName))
    {
      filteredData[[colName]] <- rawFrame[,i]      
    }
  }
  filteredData
}
# ----------------------------------------------------------------------------------------------------

# Read in meta data
dataColumnsInfo <- read.table(file="./features.txt", col.names=c("Id", "Names"), colClasses=c("integer", "character"))
activityLabels <- read.table(file="./activity_labels.txt", col.names=c("Id", "Names"), colClasses=c("integer", "character"))

## Read and create Test data frame
testSubjects <- read.table(file="./subject_test.txt", col.names=c("Subject.Id"), colClasses=c("integer"))
testActivity <- read.table(file="./y_test.txt", col.names=c("Id"), colClasses=c("integer"))
testActivity <- sapply(testActivity$Id, function(oneId) activityLabels$Names[oneId] )
testData <- read.table(file="./X_test.txt")
filteredTestData <- GetFilteredDataFrame(testData, dataColumnsInfo)
filteredTestData <- cbind(testSubjects, Activity=testActivity, filteredTestData)
filteredTestData$Activity <- as.character(filteredTestData$Activity)

# Read and create Train data frame
trainSubjects <- read.table(file="./subject_train.txt", col.names=c("Subject.Id"), colClasses=c("integer"))
trainActivity <- read.table(file="./y_train.txt", col.names=c("Id"), colClasses=c("integer"))
trainActivity <- sapply(trainActivity$Id, function(oneId) activityLabels$Names[oneId] )
trainData <- read.table(file="./X_train.txt")
filteredTrainData <- GetFilteredDataFrame(trainData, dataColumnsInfo)
filteredTrainData <- cbind(trainSubjects, Activity=trainActivity, filteredTrainData)
filteredTrainData$Activity <- as.character(filteredTrainData$Activity)

# Combine test and train data sets
tidyActivityMeasures <- rbind(filteredTestData, filteredTrainData)
tidyActivityMeasures <- tidyActivityMeasures[order(tidyActivityMeasures$Subject.Id),]

# Write activity measures data frame to file
write.table(x=tidyActivityMeasures, file="./tidyActivityMeasures.txt", row.names = FALSE, sep=" ")

# Compute variable means for each activity and each subject
activityMelt <- melt(tidyActivityMeasures, id=c("Subject.Id", "Activity"))
tidyActivityMeans <- dcast(activityMelt, Subject.Id + Activity ~ variable, mean)

# Write means data frame to file
write.table(x=tidyActivityMeans, file="./tidyActivityMeans.txt", row.names = FALSE, sep=" ")

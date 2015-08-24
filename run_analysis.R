

X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
Test<-cbind(X_test, y_test)
Test[,563] = read.table("subject_test.txt")

X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
Train<-cbind(X_train, y_train)
Train[,563] = read.csv("subject_train.txt", sep="", header=FALSE)

activity_labels = read.csv("activity_labels.txt", sep="", header=FALSE)

# Read features and make the feature names better suited for R with some substitutions

features = read.table("features.txt")
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets together
CompleteData = rbind(Train, Test)

# Get only the data on mean and std. dev.
Needed_Cols <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[Needed_Cols,]
# Now add the last two columns (activity and subject)
Needed_Cols <- c(Needed_Cols, 562, 563)
# And remove the unwanted columns from allData
CompleteData <- CompleteData[,Needed_Cols]
# Add the column names (features) to allData
colnames(CompleteData) <- c(features$V2, "Activity", "Subject")
colnames(CompleteData) <- tolower(colnames(CompleteData))

#Replace activity numbers with descriptive names

currentActivity = 1
for (currentActivityLabel in activity_labels$V2) {
  CompleteData$activity <- gsub(currentActivity, currentActivityLabel, CompleteData$activity)
  currentActivity <- currentActivity + 1
}

# turn activities & subjects into factors
CompleteData$activity <- as.factor(CompleteData$activity)
CompleteData$subject <- as.factor(CompleteData$subject)

CompleteData.melted <- melt(CompleteData, id = c("subject", "activity"))
CompleteData.mean <- dcast(CompleteData.melted, subject + activity ~ variable, mean)


write.table(CompleteData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

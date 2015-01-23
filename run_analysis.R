## Put comments here that give an overall description of what your
## run_analysis.R

library(downloader)

## 0. Download files and Open files 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download(fileUrl,dest="dataset.zip", mode = "wd") 
unzip ("dataset.zip",exdir = "./")
dateDownloaded <- date()

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                        sep = "", header = FALSE, col.names = "subject")
label_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                        sep = "", header = FALSE, col.names = "label")
data_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                        sep = "", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                        sep = "", header = FALSE, col.names = "subject")
label_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                        sep = "", header = FALSE, col.names = "label")
data_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                        sep = "", header = FALSE)


## 1. Merge the "train" and "test" datasets
data_train$subject      <- subject_train$subject
data_train$label        <- label_train$label
data_test$subject       <- subject_test$subject
data_test$label         <- label_test$label

data_full               <- rbind(data_train, data_test)

## 2. Extract only mean() and std() for each measurement
features <- read.table("UCI HAR Dataset/features.txt", sep = "", header = FALSE, 
                       col.names = c("code","feature"), stringsAsFactors = FALSE)
features$mean_mes <- NA
features$std_mes <- NA
for (i in 1:nrow(features)){
        features[i,]$mean_mes <- grepl("mean()",features[i,]$feature)
        features[i,]$std_mes <- grepl("std()", features[i,]$feature)
}
data_fullMS <- data_full[,(features$mean_mes | features$std_mes)]

## 3. Label variables with appropriate names
colnames(data_fullMS) <- c(features[(features$mean_mes | features$std_mes),]$feature,
                         "subject", "label")
head(data_fullMS)


## 4. Add descriptive activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "", 
                       header = FALSE, col.names = c("code", "activity"), 
                       stringsAsFactors = FALSE)
data_fullMS2  <- mutate(data_fullMS , activity = 
                                factor(label, labels = activity_labels$activity))

## 5. Tidy data set with the average of each variable for each (activity, subject).
data_fullMS2$subject <- factor(data_fullMS2$subject)
splitted <- split(data_fullMS2, list(data_fullMS2$activity, 
              data_fullMS2$subject), drop = FALSE)
ncolend <- ncol(data_fullMS2)-3
data_tidy2 <- t(sapply(splitted, function(x) colMeans(x[, 1:ncolend], na.rm = TRUE)))

write.table(data_tidy2, "Tidy_data2.txt", sep = "\t", row.names = FALSE, col.names = TRUE)


library(dplyr)
library(data.table)
if(!file.exists("samsungdata.zip")){
        fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, "samsungdata.zip",method = "curl")
}

unzip("samsungdata.zip")

#make training data frame
X_train <- fread("UCI HAR Dataset/train/X_train.txt")
y_train <- fread("UCI HAR Dataset/train/y_train.txt",stringsAsFactors = FALSE)
column_names <- fread("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
subject <- fread("UCI HAR Dataset/train/subject_train.txt")
activity_names <- fread("UCI HAR Dataset/activity_labels.txt")
colnames(X_train) <- column_names[[2]]
colnames(y_train) <- "activity"
colnames(subject) <- "subject"
Training <- cbind(X_train,y_train) %>% cbind(subject)

#make test data frame (use same column and activity names as for training data)
X_test <- fread("UCI HAR Dataset/test/X_test.txt")
y_test <- fread("UCI HAR Dataset/test/y_test.txt",stringsAsFactors = FALSE)
subject <- fread("UCI HAR Dataset/test/subject_test.txt")
colnames(X_test) <- column_names[[2]]
colnames(y_test) <- "activity"
colnames(subject) <- "subject"
testing <- cbind(X_test,y_test) %>% cbind(subject)

#bind the data frames together
Alldata <- rbind(Training,testing)

#get only relevant data
Alldata <- select(Alldata, grep("[Mm]ean",names(Alldata)),
                grep("std",names(Alldata)), activity, subject)

Alldata$activity <- as.factor(Alldata$activity) 
levels(Alldata$activity) <- activity_names[[2]]
        
DataSummary <-Alldata %>% arrange(subject,activity) %>% 
        group_by(subject,activity) %>% 
        summarize_each(funs(mean), -(subject:activity)) %>%
        melt(id=1:2)

write.table(DataSummary,"SummaryData.txt",row.names=FALSE)

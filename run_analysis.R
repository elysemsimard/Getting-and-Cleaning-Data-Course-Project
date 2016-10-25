fileZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileZip, destfile = "./Data.zip")
unzip("./Data.zip")


##Read names features
x_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)


##Read table TEST and assign names
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c("Subject")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(X_test) <- x_names$V2

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test) <- c("Activity")


##Read table TRAIN and assign names
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c("Subject")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(X_train) <- x_names$V2

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train) <- c("Activity")


##Merge Data TEST
data_test <- cbind(X_test,y_test,subject_test)


##Merge Data TRAIN
data_train <- cbind(X_train,y_train,subject_train)


##Merge all data
data_set <- rbind(data_test,data_train)



## 2. Extracts only the measurements on the mean and standard deviation for each measurement
Mean_std_field <- x_names$V2[grepl("mean\\(\\)|std()",x_names$V2)]

keep_names <- c(as.character(Mean_std_field), "Activity", "Subject")

subset_mean_std <- subset(data_set, select=keep_names)


## Read activity_labels table
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activity_labels) <- c("V1", "Activity_Names")

## Merge activity labels to the subset_mean_std
narrow_data <- merge(subset_mean_std,activity_labels,by.x="Activity",by.y="V1")
drop <- c("Activity")
narrow_data <- narrow_data[!(names(narrow_data) %in% drop)]


## Appropriately labels the data set with descriptive variable names

names(narrow_data) <- sub("Acc", "Acceleration", names(narrow_data))
names(narrow_data) <- sub("Gyro", "Gyroscope", names(narrow_data))
names(narrow_data) <- sub("Mag", "Magnitude", names(narrow_data))

names(narrow_data) <- sub("std()", "Std", names(narrow_data))
names(narrow_data) <- sub("mean()", "Mean", names(narrow_data))


## Melt data
narrow_data_melt <- melt(narrow_data, id=c("Activity_Names", "Subject"))

## Create tidy
average_narrow <- dcast(narrow_data_melt, Subject+Activity_Names ~ variable, mean)


## Create new table
write.table(average_narrow, file = "./UCI HAR Dataset/mean_tidy_data_q5.txt", row.name=FALSE)





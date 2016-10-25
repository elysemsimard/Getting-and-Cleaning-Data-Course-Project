# Getting-and-Cleaning-Data-Course-Project
Coursera - Getting and cleaning data course

Project:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps in R script (in run_analysis.R) :
1. Read names features
2. Read table TEST and assign names
3. Read table TRAIN and assign names
4. Merge all data
5. Extracts only the measurements on the mean and standard deviation for each measurement
6. Read activity_labels table
7. Merge activity labels to the subset_mean_std
8. Appropriately labels the data set with descriptive variable names
9. Melt data
10. Create tidy
11. Create new table



#======================================================================
# run_analysis.R                                             
# Author: Gerson Guilhem                 
#                                                                   
# Description: This script will load the data files from the course
# project data and use data manipulation commands to accomplish the
# following:
#           
# - Merge the train and test sets into a single data set
# - Keep only the measurements on the mean and standard deviation for 
#   each measurement.
# - Use descriptive activity names to name the activities in the data
#   set
# - Appropriately label the data set with descriptive variable names
# - Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject.
#
# This script assumes you have downloaded the Samsung data for the
# course project and that it is unzipped in your current working
# directory.
#
# Outcome: the outcome of this script is the summary_data data frame 
# exported as a text file in the parent working directory.
# (See the CodeBook.R for more details about the variables of this 
# script)
#======================================================================

# Load required packages
library(dplyr)
library(tidyr)
library(stringr)

##############################
# Load the data              #
##############################

# Load the original data files
features <- read.table(file = "features.txt", header = FALSE)
activity_labels <- read.table(file = "activity_labels.txt", header = FALSE)

subject_train <- read.table(file = "./train//subject_train.txt", header = FALSE)
X_train <- read.table(file = "./train//X_train.txt", header = FALSE)
y_train <- read.table(file = "./train//y_train.txt", header = FALSE)

subject_test <- read.table(file = "./test//subject_test.txt", header = FALSE)
X_test <- read.table(file = "./test//X_test.txt", header = FALSE)
y_test <- read.table(file = "./test//y_test.txt", header = FALSE)

##############################
# Prepare the Train Dataset #
##############################

# create a tibble object (special case of a data frame) to store the train data measurements 
train_data_measurements <- as_tibble(X_train)

# assign the feature names for the measurements according to the names in the features.txt file
names(train_data_measurements) <- features$V2

# retrieve the activity names from the activity_labels.txt and join them in the y_train.txt according
# to the activity codes
activity_names <- left_join(x = y_train, y = activity_labels)

# name the columns appropriately
names(activity_names) <- c("ActivityId","ActivityName")

# keep only the activity names column
activity_names <- activity_names %>% select(ActivityName)

# bind the activity names column with the measurements from the train data
final_train_data <- cbind(activity_names, train_data_measurements)

# bind the subject identification with the train data
final_train_data <- cbind(subject_train, final_train_data)

# name the subject identification column
names(final_train_data)[1] <- "SubjectId"

##############################
# Prepare the Test Dataset  #
##############################

# create a tibble object (special case of a data frame) to store the train data measurements
test_data_measurements <- as_tibble(X_test)

# assign the feature names for the measurements according to the names in the features.txt file
names(test_data_measurements) <- features$V2

# retrieve the activity names from the activity_labels.txt and join them in the y_train.txt according
# to the activity codes
activity_names <- left_join(x = y_test, y = activity_labels)

# name the columns appropriately
names(activity_names) <- c("ActivityId","ActivityName")

# keep only the activity names column
activity_names <- activity_names %>% select(ActivityName)

# column bind the activity names with the measurements from the train data
final_test_data <- cbind(activity_names, test_data_measurements)

# bind the subject identification with the test data
final_test_data <- cbind(subject_test, final_test_data)

# name the subject identification column
names(final_test_data)[1] <- "SubjectId"

###############################################################
# Merge the training and the test sets to create one data set #
###############################################################

# Merges the training and the test sets to create one data set
unified_data <- rbind(final_train_data, final_test_data)

# Remove unnecessary variables
rm(activity_labels, activity_names, features, final_test_data, final_train_data, 
   subject_test, subject_train, test_data_measurements, train_data_measurements, 
   X_test, X_train, y_test, y_train)

# Extracts only the measurements on the mean and standard deviation for each measurement.
column_with_mean_or_std <- grep(pattern = "mean\\()|std\\()", x = names(unified_data))
unified_data <- unified_data[,c(1:3, column_with_mean_or_std)]

# Clean the parentheses "()" from the column names
names(unified_data) = gsub("[()-]","",names(unified_data))

# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
summary_data <- unified_data %>% 
  group_by(ActivityName, SubjectId) %>%
  summarize_all(.funs = mean)

write.table(x = summary_data, file = "summary_data.txt", row.names = FALSE)

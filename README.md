run\_analysys.R
---------------

Author: Gerson Guilhem

Description: This script will load the data files from the course
project data and use data manipulation commands to accomplish the
following:

-   Merge the train and test sets into a single data set
-   Keep only the column that contains measurements on the mean and
    standard deviation.
-   Use descriptive activity names to name the activities in the data
    set.
-   Appropriately label the data set with descriptive variable names.
-   Creates a second, independent tidy data set with the average of each
    variable for each activity and each subject.

<span style="color:red">Important:</span> This script assumes you have
downloaded the Samsung data for the course project and that it is
unzipped in your current working directory.

Outcome: the outcome of this script is the *summary\_data* data frame
exported as a text file in the parent working directory.  
The *summary\_data* is tidy since it contains only one variable per
column and each row represents a single observation for each combination
of subject and activity.  
(See the CodeBook.R for more details about the variables of this script)

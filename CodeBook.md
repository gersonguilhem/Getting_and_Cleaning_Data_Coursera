Codebook for run\_analysis.R
============================

File Description
----------------

This file describes the data files, variables produced and any
tranformations that were performed to clean up the data.

Data files loaded by this script
--------------------------------

-   <span style="color: blue">features</span>: file containing the names
    of the features of the dataset
-   <span style="color: blue;">activity\_labels</span>: file containing
    the labels of the activities and their respective ID’s
-   <span style="color: blue;">subject\_train, subject test</span>: Each
    row identifies the subject who performed the activity for each
    window sample. Its range is from 1 to 30.
-   <span style="color: blue;">X\_train</span>: Training set
-   <span style="color: blue;">y\_train</span>: Training labels
-   <span style="color: blue;">X\_test</span>: Test set
-   <span style="color: blue;">y\_test</span>: Test labels

Variables produced or used by the script
----------------------------------------

-   <span style="color: blue">train\_data\_measurements,
    test\_data\_measurements</span>: variables that hold the contents of
    the X\_Test and Y\_Test data files respectively, as a data frame.x

-   <span style="color: blue;">activity\_names</span>: data frame that
    holds the activity names according to the activity ID’s in the
    X\_Test / Y\_Test data files.

-   <span style="color: blue;">final\_train\_data,
    final\_test\_data</span>: data frames holding the subject ID’s, the
    contents of the activity\_names and all features with their
    appropriate labels and values.

-   <span style="color: blue;">unified\_data</span>: final\_train\_data
    and final\_test\_data as a single dataset, with only feature columns
    that have measurements of mean and std. deviation.

-   <span style="color: blue;">summary\_data</span>: summary per each
    subject and activity, with the mean of all colums from
    unified\_data.

Data transformations applied by this script
-------------------------------------------

-   train\_data\_measurements, test\_data\_measurements: both variables
    are transformed to data frames with the as.tibble() command (*dplyr*
    package) applied to the *X\_Test* and *Y\_Test* data files,
    respectively. The *features* data file is used to provide the column
    names for these data frames, with the names() command.

-   activity\_names: the activity ID column from the *x\_train* and
    *y\_train* data files are used to lookup the activity names in the
    *activity\_labels* data file. The join operation is performed with
    the left\_join() function (*dplyr* package). After the join
    operation, only the column with the activity name is maintained.

-   final\_train\_data, final\_test\_data: after having the
    *train\_data\_measurements/test\_data\_measurements* and
    *activity\_names* ready, cbind() is used to bind their columns in a
    single data frame. Another cbind() operation is performed after this
    one to include the subject ID’s from the *subject\_train* and
    *subject\_test* data files. The subject ID column is then named
    appropriately.

-   unified\_data: using the rbind() command, the *final\_train\_data*
    and *final\_test\_data* are bound together, producing a single data
    frame with the train and test data. After binding these rows, a
    grep() command is used to identify the column names that references
    mean or std deviation, by searching for string patterns that
    contains the sequence “mean()” or “std()”. Next, *unified\_data* is
    subsetted to keep all of its descritptive columns (ActivityName and
    SubjectId) and only the feature columns where the grep() function
    found a pattern match. Finally, a gsub() command is used to remove
    the parentheses “()” from the column names.

-   summary\_data: using *dplyr* group\_by() and summarize(), the mean
    of all columns from *unified\_data* are calculated for each activity
    and subject, saving its contents in this separated data frame.

Data Dictionary for the produced dataset (summary\_data.txt)
------------------------------------------------------------

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Column Name</th>
<th>Data Type</th>
<th>Example</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ActivityName</td>
<td><code>Factor</code></td>
<td>LAYING, SITTING</td>
<td>Factor with 6 levels: “LAYING”, “SITTING”, “STANDING”, “WALKING”, “WALKING_DOWNSTAIRS”, “WALKING_UPSTAIRS”</td>
</tr>
<tr class="even">
<td>SubjectId</td>
<td><code>Integer</code></td>
<td>1, 2, 3</td>
<td>Integer ranging from 1 to 30</td>
</tr>
<tr class="odd">
<td>From tBodyAccmeanX [column 3] to fBodyBodyGyroJerkMagstd [column 68]</td>
<td><code>numeric</code></td>
<td>0.289, -0.0203, -0.133</td>
<td>These columns refer to the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ (prefix ‘t’ to denote time). The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals). The set of variables that were estimated from these signals are: mean(): Mean value std(): Standard deviation</td>
</tr>
</tbody>
</table>

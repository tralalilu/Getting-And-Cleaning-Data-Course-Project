## CodeBook for the Getting and Cleaning Data Course

### Obtaining the data
For this project we are using the following [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description of it can be found at the [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
The goal of our project is to clean this dataset and create tidy data than can be used later on. 
We are not concerned with how this data was collected and the processing that was done before. 

### Raw data
We won't use all files from this dataset, but only the following ones:

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'features.txt': List of all features.

We will do the following operations on the raw data:

* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement. 
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names. 
* Create a second, independent tidy data set with the average of each variable for each activity and each subject.

### Cleaning the data

We first create a subset vector that will contain the indices of the variables that we are interested in (mean and standard deviation).

For each of the two sets (test and train), we create a new data frame, named data_test/train by combining subject_test/train, y_test/train with the subsetted data frames X_test/train. The test data frame has 2947 rows and 68 columns and the train data frame has 7352 rows and 68 columns. 

We then merge these two data frames. 

The first variable is the subject variable and its values are integer numbers between 1 and 30.

We change the activity variable (y_test + y_train) class from numeric to a factor with 6 levels. The labels of the factor' levels are taken from the 'activity_labels.txt' file. We also transform the letters of the labels to lower case ("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying").

We then label the first two variables of the data frame with the names "subject" and "activity".

We change the class of the second column of the 'features.txt' data frame (the one that contains tha variable names) from factor to character. We then remove all non-alphanumeric ("-","(", ")") characters from these names. We modify the names to get descriptive variable names. We replace "t" by "time", "f" by "frequency", "Acc" by "Accelerometer", "Gyro" by "Gyroscope", "Mag" by "Magnitude", "mean" by "Mean", "std" by "StandardDeviation", "BodyBody" by "Body", "X" by "Xaxis", "Y" by "Yaxis", "Z" by "Zaxis".
Here is the list of variables from our final data frame: 

* subject: an integer value between 1 and 30; it represents the subject who performed the activity 
* activity: factor with 6 levels ("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")

The next 66 variables are normalized (so they don't have units of measurement) and are bounded within [-1,1]. 

* timeBodyAccelerometerMeanXaxis
* timeBodyAccelerometerMeanYaxis
* timeBodyAccelerometerMeanZaxis
* timeBodyAccelerometerStandardDeviationXaxis
* timeBodyAccelerometerStandardDeviationYaxis
* timeBodyAccelerometerStandardDeviationZaxis
* timeGravityAccelerometerMeanXaxis
* timeGravityAccelerometerMeanYaxis
* timeGravityAccelerometerMeanZaxis
* timeGravityAccelerometerStandardDeviationXaxis
* timeGravityAccelerometerStandardDeviationYaxis
* timeGravityAccelerometerStandardDeviationZaxis
* timeBodyAccelerometerJerkMeanXaxis
* timeBodyAccelerometerJerkMeanYaxis
* timeBodyAccelerometerJerkMeanZaxis
* timeBodyAccelerometerJerkStandardDeviationXaxis
* timeBodyAccelerometerJerkStandardDeviationYaxis
* timeBodyAccelerometerJerkStandardDeviationZaxis
* timeBodyGyroscopeMeanXaxis
* timeBodyGyroscopeMeanYaxis
* timeBodyGyroscopeMeanZaxis
* timeBodyGyroscopeStandardDeviationXaxis
* timeBodyGyroscopeStandardDeviationYaxis
* timeBodyGyroscopeStandardDeviationZaxis
* timeBodyGyroscopeJerkMeanXaxis
* timeBodyGyroscopeJerkMeanYaxis
* timeBodyGyroscopeJerkMeanZaxis
* timeBodyGyroscopeJerkStandardDeviationXaxis
* timeBodyGyroscopeJerkStandardDeviationYaxis
* timeBodyGyroscopeJerkStandardDeviationZaxis
* timeBodyAccelerometerMagnitudeMean
* timeBodyAccelerometerMagnitudeStandardDeviation
* timeGravityAccelerometerMagnitudeMean
* timeGravityAccelerometerMagnitudeStandardDeviation
* timeBodyAccelerometerJerkMagnitudeMean
* timeBodyAccelerometerJerkMagnitudeStandardDeviation
* timeBodyGyroscopeMagnitudeMean
* timeBodyGyroscopeMagnitudeStandardDeviation
* timeBodyGyroscopeJerkMagnitudeMean
* timeBodyGyroscopeJerkMagnitudeStandardDeviation
* frequencyBodyAccelerometerMeanXaxis
* frequencyBodyAccelerometerMeanYaxis
* frequencyBodyAccelerometerMeanZaxis
* frequencyBodyAccelerometerStandardDeviationXaxis
* frequencyBodyAccelerometerStandardDeviationYaxis
* frequencyBodyAccelerometerStandardDeviationZaxis
* frequencyBodyAccelerometerJerkMeanXaxis
* frequencyBodyAccelerometerJerkMeanYaxis
* frequencyBodyAccelerometerJerkMeanZaxis
* frequencyBodyAccelerometerJerkStandardDeviationXaxis
* frequencyBodyAccelerometerJerkStandardDeviationYaxis
* frequencyBodyAccelerometerJerkStandardDeviationZaxis
* frequencyBodyGyroscopeMeanXaxis
* frequencyBodyGyroscopeMeanYaxis
* frequencyBodyGyroscopeMeanZaxis
* frequencyBodyGyroscopeStandardDeviationXaxis
* frequencyBodyGyroscopeStandardDeviationYaxis
* frequencyBodyGyroscopeStandardDeviationZaxis
* frequencyBodyAccelerometerMagnitudeMean
* frequencyBodyAccelerometerMagnitudeStandardDeviation
* frequencyBodyAccelerometerJerkMagnitudeMean
* frequencyBodyAccelerometerJerkMagnitudeStandardDeviation
* frequencyBodyGyroscopeMagnitudeMean
* frequencyBodyGyroscopeMagnitudeStandardDeviation
* frequencyBodyGyroscopeJerkMagnitudeMean
* frequencyBodyGyroscopeJerkMagnitudeStandardDeviation

## Readme for the Getting and Cleaning Data Course

### Obtaining the data

For this project we are using the following [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description of it can be found at the [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
The goal of our project is to clean this dataset and create tidy data than can be used later on. 
We are not concerned with how this data was collected and the processing that was done before.

In the run_analysis.R we first check if there is a folder called Data in the current folder. If it doesn't exist, then we create it. We then download the .zip file from the previous webpage and unzip it using the **unzip()** function.

### Loading the data

We then read the following files: 'test/subject_test.txt', 'test/X_test.txt', 'test/y_test.txt', 'train/subject_train.txt', 'train/X_train.txt', 'train/y_train.txt', 'activity_labels.txt', 'features.txt'. 

### Cleaning the data

Our next step is to extract the measurements on the mean and standard deviation for each measurement. We create a vector, *subset*, that contains the indices of the variable names that we are going to retain. This is done using the **grep()** function.

For each of the two sets (test and train), we use the **cbind()** function with *subject_test/train*, *y_test/train* and the subsetted data *X_test/train[, subset]* to obtain a new data frame, *data_test/train*. 

We then combine the two datasets together by rows using the **rbind()** function. We obtain a data frame, *merged_data*, with 10299 rows and 68 columns.

We change the class of the second column of this merged dataset (so the one containing the values from *y_test* and *y_train*) from integer to factor and then re-label the levels with the descriptive activity names (the names from *activity_labels*), translating all letters to lower case (so the activities now have descriptive names).

The next step is to label the first two variables of the merged dataset (so the names of the first two columns) with "subject" and "activity", respectively.

We then use the *features* data frame and the *subset* vector to obtain the names of the remaining 66 variables (those referring to measurements on the mean and standard deviation). We also change the class of the vector from factor to character.

Our next goal is to modify the variable names to make them more descriptive. Since
the variables contain many different information about the measurements, we don't think we can find some short names for them (that are still meaningful). We know that the video lectures encourage us to use only lower case letter, but in our case the names would become almost impossible to read (due to not seeing immediately where a word ends and where the next one begins). We have first removed the non-alphanumeric characters "-" and "()". Then we expanded all words that appear (so "t" becomes "time", "acc" becomes "Accelerometer" and so on). Since we didn't want to use underscores or dots, we have decided to begin a word with a capital letter, except for the first word of the name (which is either "time" or "frequency"). The names don't look too pretty, but we don't think other ways are necessarily much better. Probably using underscores would improve readability, but we wanted to stick to alphanumeric characters. We are using the **gsub()** function to make these changes.

After modifying the variable names we put them in the merged_data data frame.

We now split the merged_data dataset by the *subject* and *activity* variables. 
For each group we then compute the mean of every variable (so the column means).
We are using the *plyr* package and the **ddply()** function together with the function **colwise()**, that will apply a function (in this case mean) to all columns. We also indicate other methods to obtain the same results.

The data frame that we obtained is tidy. Notice that some entries from the "activity" variable contain an underscore, but this is not a problem since they are not variable names, but values. This data frame has 180 rows (30 persons * 6 activities) and 68 columns. Each row contains one measurement and each column contains values from one variable. The final step is to write this tidy dataset to a file. 



## Create a folder called Data in the current folder (if one doesn't exist) and download
## the .zip file containing the database. 

if(!file.exists("./Data")) {
        dir.create("./Data")
}
myurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = myurl, destfile = "./Data/UCI HAR Dataset.zip", method = "curl")
unzip("./Data/UCI HAR Dataset.zip", exdir = "./Data")

## Read the files for the two sets. For the test datasets we have 2947 observations, 
## and for the train datasets we have 7352 observations.

subject_test <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Data/UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Data/UCI HAR Dataset/train/y_train.txt")

## Read the activity labels and the names of the features

activity_labels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./Data/UCI HAR Dataset/features.txt")

## Extract the right columns

subset <- grep("(mean|std)\\(\\)", features$V2)

## For each of the two sets (test and train), create a new data frame, named data_test/train,
## by combining the subject_test/train, y_test/train columns with the subsetted data 
## frames X_test/train[, subset]. Notice that I am using the cbind() function, 
## so the combination is done by columns.

data_test <- cbind(subject_test, y_test, X_test[, subset])
data_train <- cbind(subject_train, y_train, X_train[, subset])

## Combine the two datasets together by rows using the rbind() function. We obtain 
## a data frame with 10299 rows and 68 columns.

merged_data <- rbind(data_test, data_train)

## Change the class of the second column of this merged dataset (so the one containing 
## the values from y_test and y_train) from integer to factor and then re-label the 
## levels with the descriptive activity names (the names from activity_labels), translating
## all letters to lower case (thus the activities now have descriptive names).

merged_data[, 2] <- factor(merged_data[, 2], labels = tolower(activity_labels$V2))

## Label the first two variables of the merged dataset (so the names of the first 
## two columns) with "subject" and "activity", respectively. At this point we still 
## have to appropriately re-label the other 66 columns.

names(merged_data)[1:2] <- c("subject", "activity")

## I now use the features data frame and the subset vector to obtain the names of the
## remaining 66 variables (those referring to measurements on the mean and standard 
## deviation). I also change the class of the vector from factor to character.

variable_names <- as.character(features$V2)[subset]

## The next step is to modify the variable names to make them more descriptive. Since
## the variables contain many different information about the measurements, I don't think
## we can find some short names for them. I know that the video lectures encourage us 
## to use only lower case letter, but in our case the names would become almost 
## impossible to read (due to not seeing immediately where a word ends and where the 
## next one begins). I have first removed the non-alphanumeric characters "-" and "()". 
## Then I expanded all words that appear (so "t" becomes "time", "acc" becomes "Accelerometer"
## and so on). Since I didn't want to use underscores or dots, I have decided to begin a
## word with a capital letter, except for the first word of the name (which is either
## "time" or "frequency"). The names don't look too pretty, but I don't think other ways
## are definitely much better. Probably using underscores would improve readability, 
## but I wanted to stick to alphanumeric characters. I am using the gsub() function
## to make these changes.

variable_names <- gsub("^t", "time", variable_names)
variable_names <- gsub("^f", "frequency", variable_names)
variable_names <- gsub("Acc", "Accelerometer", variable_names)
variable_names <- gsub("Gyro", "Gyroscope", variable_names)
variable_names <- gsub("Mag", "Magnitude", variable_names)
variable_names <- gsub("-", "", variable_names)
variable_names <- gsub("mean\\(\\)", "Mean", variable_names)
variable_names <- gsub("std\\(\\)", "StandardDeviation", variable_names)
variable_names <- gsub("BodyBody", "Body", variable_names)
variable_names <- gsub("X", "Xaxis", variable_names)
variable_names <- gsub("Y", "Yaxis", variable_names)
variable_names <- gsub("Z", "Zaxis", variable_names)

## After modifying the variable names I put them in the merged_data data frame.

names(merged_data)[3:68] <- variable_names

## I now split the merged_data dataset by the "subject" and "activity" variables. 
## For each group I then compute the mean of every variable (so the column means).
## I am using the plyr package and the function ddply() together with the function 
## colwise(), that will apply a function (in this case mean) to all columns. 

library(plyr)
data_frame <- ddply(merged_data, c("subject", "activity"), colwise(mean))

## The same results can be achieved using the following commands (I include them here
## just for comparison): 

## data_frame2 <- ddply(merged_data, c("subject", "activity"), function(base) colMeans(base[, -2:-1]))

## Using the reshape2 package we can melt the merged_data data frame and then dcast() it. 

## melted <- melt(merged_data, id=c("subject", "activity"),measure.vars = c(names(merged_data)[3:68]))
## data_frame3 <- dcast(melted, subject + activity ~ variable, mean)

## The same data frame, but with a different order of the rows, can be obtained using
## the aggregate() function: 

## data_frame4 <- aggregate(. ~ subject + activity, data = merged_data,FUN = mean)

## There is also the possibilty to use the dplyr package, but I am not doing this here. 

## The data frame that I obtained is tidy. Notice that some entries from the "activity"
## variable contain an underscore, but this is not a problem since they are not variable
## names, but values. This data frame has 180 rows (30 persons * 6 activities) and 68
## columns. Each row contains one measurement and each column contains values from 
## one variable. The final step is to write this tidy dataset to a file. 

write.table(data_frame, file = "tidy_data.txt", row.name = FALSE)





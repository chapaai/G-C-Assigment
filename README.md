# G-C-Assigment

## firstly we read our train and test data into variables.

train <- read.table("X_train.txt")
test <- read.table("X_test.txt")

dim(train) ## dim gives 561 variables

dim(test) ## dim gives 561 variables. Equal to train data set


features <- read.table("features.txt", colClasses = c("NULL", NA))## we read into features object only the second column. So we dont have 1,2,3 rows in the data.

deneme <- as.character(features$V2) ## takes the column names into the deneme object

colnames(test) <- deneme ## adds columnnames to test and train objects. Now we have variable names on top of the values.
colnames(train) <- deneme

a <- bind_cols(y_train, train) ## merged y_train and train data 


a$V1[a$V1 == "1"] <- "WALKING"; a$V1[a$V1 == "2"] <- "WALKING_UPSTAIRS"; a$V1[a$V1 == "3"] <- "WALKING_DOWNSTAIRS"; a$V1[a$V1 == "4"] <- "SITTING"; a$V1[a$V1 == "5"] <- "STANDING"; a$V1[a$V1 == "6"] <- "LAYING";

## then changed 1,2,3,4,5,6 values of data to text (Walking, Sitting etc.)

b <- bind_cols(y_test, test) ## merged y_test and test data

b$V1[b$V1 == "1"] <- "WALKING"; b$V1[b$V1 == "2"] <- "WALKING_UPSTAIRS"; b$V1[b$V1 == "3"] <- "WALKING_DOWNSTAIRS"; b$V1[b$V1 == "4"] <- "SITTING"; b$V1[b$V1 == "5"] <- "STANDING"; b$V1[b$V1 == "6"] <- "LAYING";

## then changed 1,2,3,4,5,6 values of data to text (Walking, Sitting etc.)

rbind(train, test) ## binds two datasets together. 1st step is done.

meanandstd <- bindedtable[grep("mean|std|V1", names(bindedtable))] ## with grep we searched for mean and std keywords inside the names of the bindedtable object.

## then subsetted the bindedtable object according to the grepped values. 2nd step is done.

colnames(meanandstd)[1] <- c("Activities") ## changed the first colname 

## via purr package i have been able to take the average of each variable.

install.packages("purrr")

library("purrr")

meanandstd2 <- meanandstd %>% slice_rows("Activities") %>% dmap(mean)

View(meanandstd2)

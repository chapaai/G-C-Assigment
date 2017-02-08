# G-C-Assigment

## firstly we read our train and test data into variables.
train <- read.table("X_train.txt")
test <- read.table("X_test.txt")

## dim gives 561 variables
dim(train) 

## dim gives 561 variables. Equal to train data set
dim(test) 

## we read into features object only the second column. So we dont have 1,2,3 row names in the data.
features <- read.table("features.txt", colClasses = c("NULL", NA))

## takes the column names into the deneme object
deneme <- as.character(features$V2) 

## adds columnnames to test and train objects. Now we have variable names on top of the values.
colnames(test) <- deneme 
colnames(train) <- deneme

## merged y_train and train data 
a <- bind_cols(y_train, train) 

## then changed 1,2,3,4,5,6 values of data to text (Walking, Sitting etc.)
a$V1[a$V1 == "1"] <- "WALKING"; a$V1[a$V1 == "2"] <- "WALKING_UPSTAIRS"; a$V1[a$V1 == "3"] <- "WALKING_DOWNSTAIRS"; a$V1[a$V1 == "4"] <- "SITTING"; a$V1[a$V1 == "5"] <- "STANDING"; a$V1[a$V1 == "6"] <- "LAYING";

## merged y_test and test data
b <- bind_cols(y_test, test) 

## then changed 1,2,3,4,5,6 values of data to text (Walking, Sitting etc.)
b$V1[b$V1 == "1"] <- "WALKING"; b$V1[b$V1 == "2"] <- "WALKING_UPSTAIRS"; b$V1[b$V1 == "3"] <- "WALKING_DOWNSTAIRS"; b$V1[b$V1 == "4"] <- "SITTING"; b$V1[b$V1 == "5"] <- "STANDING"; b$V1[b$V1 == "6"] <- "LAYING";

## binds two datasets together.
rbind(train, test) 

## with grep we searched for mean and std keywords inside the names of the bindedtable object.
meanandstd <- bindedtable[grep("mean|std|V1", names(bindedtable))] 

## then subsetted the bindedtable object according to the grepped values.
colnames(meanandstd)[1] <- c("Activities") ## changed the first colname 

## via purr package i have been able to take the average of each variable grouped by activity names.
install.packages("purrr")
library("purrr")

meanandstd2 <- meanandstd %>% slice_rows("Activities") %>% dmap(mean)

View(meanandstd2)

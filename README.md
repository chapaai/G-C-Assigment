# G-C-Assigment

## firstly we read our datas into variables. Assuming your are in the same folder with all those text files.

train <- read.table("X_train.txt")
test <- read.table("X_test.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")

## we read into features object only the second column. So we dont have 1,2,3 rows in the data.
features <- read.table("features.txt", colClasses = c("NULL", NA))

## takes the column names into the deneme object
deneme <- as.character(features$V2) 

## adds columnnames to test and train objects. Now we have variable names on top of the values.
colnames(test) <- deneme 
colnames(train) <- deneme

## merged y_train, subject_train and train data 
a <- bind_cols(y_train, subject_train, train) 

## changed the first and second colname
colnames(a)[1] <- c("Activities") 
colnames(a)[2] <- c("Subjects")

## then changed 1,2,3,4,5,6 values of data to text (Walking, Sitting etc.)
a$Activities[a$Activities == "1"] <- "WALKING"; a$Activities[a$Activities == "2"] <- "WALKING_UPSTAIRS"; a$Activities[a$Activities == "3"] <- "WALKING_DOWNSTAIRS"; a$Activities[a$Activities == "4"] <- "SITTING"; a$Activities[a$Activities == "5"] <- "STANDING"; a$Activities[a$Activities == "6"] <- "LAYING";

## same here for "test" 
b <- bind_cols(y_test, subject_test, test) ## merged y_test and test data
colnames(b)[1] <- c("Activities") ## changed the first colname
colnames(b)[2] <- c("Subjects")
b$Activities[b$Activities == "1"] <- "WALKING"; b$Activities[b$Activities == "2"] <- "WALKING_UPSTAIRS"; b$Activities[b$Activities == "3"] <- "WALKING_DOWNSTAIRS"; b$Activities[b$Activities == "4"] <- "SITTING"; b$Activities[b$Activities == "5"] <- "STANDING"; b$Activities[b$Activities == "6"] <- "LAYING";
 
## binds two datasets together.
bindedtable <- rbind(a, b)

## with grep we searched for mean and std keywords inside the names of the bindedtable object. Also didnt throw away activity and subject too.
meanandstd <- bindedtable[grep("mean|std|Activity|Subjects", names(bindedtable))] 

## Aggregate gives the mean off other data than activities and subject, grouped by activities and subject. 
second_data <- aggregate(. ~ Activities + Subjects, data = meanandstd, FUN = 'mean')

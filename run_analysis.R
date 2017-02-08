train <- read.table("X_train.txt")
test <- read.table("X_test.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")


features <- read.table("features.txt", colClasses = c("NULL", NA))


deneme <- as.character(features$V2) 


colnames(test) <- deneme 
colnames(train) <- deneme


a <- bind_cols(y_train, subject_train, train) 


colnames(a)[1] <- c("Activities") 
colnames(a)[2] <- c("Subjects")


a$Activities[a$Activities == "1"] <- "WALKING"; a$Activities[a$Activities == "2"] <- "WALKING_UPSTAIRS"; a$Activities[a$Activities == "3"] <- "WALKING_DOWNSTAIRS"; a$Activities[a$Activities == "4"] <- "SITTING"; a$Activities[a$Activities == "5"] <- "STANDING"; a$Activities[a$Activities == "6"] <- "LAYING";


b <- bind_cols(y_test, subject_test, test) ## merged y_test and test data
colnames(b)[1] <- c("Activities") ## changed the first colname
colnames(b)[2] <- c("Subjects")
b$Activities[b$Activities == "1"] <- "WALKING"; b$Activities[b$Activities == "2"] <- "WALKING_UPSTAIRS"; b$Activities[b$Activities == "3"] <- "WALKING_DOWNSTAIRS"; b$Activities[b$Activities == "4"] <- "SITTING"; b$Activities[b$Activities == "5"] <- "STANDING"; b$Activities[b$Activities == "6"] <- "LAYING";
 

bindedtable <- rbind(a, b)


meanandstd <- bindedtable[grep("mean|std|Activity|Subjects", names(bindedtable))] 


second_data <- aggregate(. ~ Activities + Subjects, data = meanandstd, FUN = 'mean')

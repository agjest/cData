#You should create one R script called run_analysis.R that does the following.
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt", header=FALSE,sep="")
y_test <- read.table("UCI\ HAR\ Dataset/test/Y_test.txt", header=FALSE,sep="")
subject_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt", header=FALSE,sep="")
x_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt", header=FALSE,sep="")
y_train <- read.table("UCI\ HAR\ Dataset/train/Y_train.txt", header=FALSE,sep="")
subject_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt", header=FALSE,sep="")
#cbind to test
test <- cbind(subject_test,x_test,y_test)
#cbind to test
train <- cbind(subject_train,x_train,y_train)
#rbind 
tot <- rbind(test,train)
# read in features
features <- read.table("UCI\ HAR\ Dataset/features.txt", header=FALSE,sep="")
# name the columns
names(tot) <- c("subject",features[,2],"Y")
# this is not elegant, but it works
tot$activity <- tot$Y
tot$activity <- ifelse(tot$Y==1,"WALKING",tot$activity)
tot$activity <- ifelse(tot$Y==2,"WALKING_UPSTAIRS",tot$activity)
tot$activity <- ifelse(tot$Y==3,"WALKING_DOWNSTAIRS",tot$activity)
tot$activity <- ifelse(tot$Y==4,"SITTING",tot$activity)
tot$activity <- ifelse(tot$Y==5,"STANDING",tot$activity)
tot$activity <- ifelse(tot$Y==6,"LAYING",tot$activity)
# only mean() and std()
colM <- grep("mean()",features[,2],fixed = TRUE)
colS <- grep("std()",features[,2],fixed = TRUE)
totRed <- tot[,c(1, colM, colS, 564)]
names(totRed) <- c("subject",features[c(colM,colS),2],"activity")
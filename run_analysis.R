#You should create one R script called run_analysis.R that does the following.
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the
#average of each variable for each activity and each subject.
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
# only mean() and std() are the variables we are interested in
# add 1 because of subject in first col in tot
colM <- grep("mean\\(\\)",features[,2]) +1
colS <- grep("std\\(\\)",features[,2]) +1
# pick the ones we want and move activity to col 2
totRed <- tot[,c(1, dim(tot)[2],colM, colS)]
#name the cols, use () in col names. Have to enclose the variables in "" when used
#but a good thing to keep them like the originals
names(totRed) <- c("subject","activity",as.character(features[c(colM,colS),2]))
tmp <- as.dataframe(matrix(nrow=11880,ncol=4))
for(i in 3:5){
tmp[((i-3)*180)+1:((i-3)*180)+180:] <- aggregate(totRed[,i],list(totRed$subject,totRed$activity),mean))
}

(((i-3)*180)+1)=180i - 
  
1:180
181:361

f <- rep(names(totRed)[i],180)
tmp <- cbind(tmp,f)
rbind
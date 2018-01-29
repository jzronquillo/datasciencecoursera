##R SCRIPT FOR GETTING AND CLEANING DATA COURSE PROJECT

#Get the zip file
zipUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
datapath <- "UCI HAR Dataset"
if (!file.exists(datapath)) {
    unzip(zipFile)
}

#list the files contained on the UCI HAR Dataset
list.files(datapath,recursive = TRUE)

# read subjects
testSubjects <- read.table(file.path(datapath, "test", "subject_test.txt"),header = FALSE)
trainSubjects <- read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE)
subjects<-rbind(testSubjects,trainSubjects)
colnames(subjects)<-c("Subjects")

#read activity
testActivities <- read.table(file.path(datapath,"test","Y_test.txt"), header = FALSE)
trainActivities <- read.table(file.path(datapath, "train", "Y_train.txt"), header = FALSE)
activities<-rbind(testActivities,trainActivities)
colnames(activities)<-c("Activities")

#readfeatures data and rename using features.txt
testFeatures <- read.table(file.path(datapath,"test","X_test.txt"),header = FALSE)
trainFeatures <- read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE)
features<-rbind(testFeatures,trainFeatures)

featuresNames <- read.table(file.path(datapath,"features.txt"), as.is = TRUE)
colnames(features)<-featuresNames$V2

#merge subjects, activities and features into Data
combine1<-cbind(subjects,activities)
Data<-cbind(combine1,features)

#Extracts only the measurements on the mean and standard deviation for each measurement
#subset features by the mean and std measurement
subFeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]
selectDataNames<-c("Subjects", "Activities",subFeaturesNames)

#Subset data by the selectedDataNames
subData<-subset(Data,select = selectDataNames)

#read activity labels
activityLabels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)

#Uses descriptive activityLabeks to name the activities in the data set
Data$Activities<-factor(Data$Activities,levels=activityLabels[,1],labels = activityLabels[,2])


#Appropriately label the data set with descriptive variable names
colnames(Data)<-gsub("^t", "time", colnames(Data))
colnames(Data)<-gsub("^f", "frequency", colnames(Data))
colnames(Data)<-gsub("Acc", "Accelerometer", colnames(Data))
colnames(Data)<-gsub("Gyro", "Gyroscope", colnames(Data))
colnames(Data)<-gsub("Mag", "Magnitude", colnames(Data))
colnames(Data)<-gsub("BodyBody", "Body", colnames(Data))

#Create a second,independent tidy data set with the average of each variable
# for each activity and each subject

library(plyr)
Data2<-aggregate(. ~Subjects+Activities, data=Data,mean)
Data2<-Data2[order(Data2$Subjects,Data2$Activities),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)




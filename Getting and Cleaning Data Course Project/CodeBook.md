##CODEBOOK FOR GETTING AND CLEANING DATA COURSE PROJECT

#INTRODUCTION

# R script called run_analysis.R in this repository does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
#     *prefix t is replaced by time
#     *Acc is replaced by Accelerometer
#     *Gyro is replaced by Gyroscope
#     *prefix f is replaced by frequency
#     *Mag is replaced by Magnitude
#     *BodyBody is replaced by Body
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject

#VARIABLES

# testSubjects, trainSubjects, testActivities, trainActivities , testFeatures, trainFeatures
# featuresNames and activityLabels contain the data from the downloaded files.

# subjects, activities and features merge the train and test datasets to further analysis.

# Data merges subjects,activities and features datasets

# subFeaturesNames contains the desired names for the features dataset
# (mean and std measurements only) 

# subData is extracted from Data dataset that only contains the measurements for mean and std

# Finally, Data2 contains the relevant averages which was strored as tidydata.txt file. 



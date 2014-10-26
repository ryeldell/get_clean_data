# Set working directory
setwd("C:/Users/robin_000/_NextGen/Google Drive/Collateral/R-course")

# Load libraries 
library(data.table)
library(dplyr)


# Read in activity labels (walking, etc.) and label the columns of the labels 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
colnames(activity_labels)<-c("activity_id","activitydescription")

# Read in the features table (e.g. fBodyAccMag-std())
features <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

# Read in the subject list which matches row for row with the features detail 
#    table in the x_train.txt table
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            stringsAsFactors=FALSE)
# Apply column name to subject data
colnames(subject_train)<-"subjectidentifier"
# Read in the features detail table for the training observations
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                      stringsAsFactors=FALSE)
# Apply the feature names to the feature detail table
colnames(x_train)<-features[,2]
# Create a table with only the mean and standard deviation columns from the raw 
#    table
x_train_mean_std <- x_train[,which(grepl('(mean\\()|(std\\())',features[,2]))]
# Read in the activity list and assign the column name
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt",
                      stringsAsFactors=FALSE)
colnames(y_train)<-"activity_id"
# Assign activity id to the detail dataset, activity ID is repeated over and 
#    over until it labels all the rows
z_train<-cbind(subject_train,y_train,x_train_mean_std)
# Add a column with the activity labels, merge will join on like-named column,
#    activity_id
z_train_actv<-merge(z_train,activity_labels,sort=FALSE,all.x=TRUE)


# Repeat steps with test observations
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                            stringsAsFactors=FALSE)
colnames(subject_test)<-"subjectidentifier"
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                      stringsAsFactors=FALSE)
colnames(x_test)<-features[,2]
x_test_mean_std <- x_test[,which(grepl('(mean\\()|(std\\())',features[,2]))]
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt",
                      stringsAsFactors=FALSE)
colnames(y_test)<-"activity_id"
z_test<-cbind(subject_test,y_test,x_test_mean_std)
z_test_actv<-merge(z_test,activity_labels,sort=FALSE,all.x=TRUE)

# Merge training and test observations
z_merge_actv<-rbindlist(list(z_train_actv,z_test_actv))

# Rename columns to prepare "tidy" dataset
z_colnam<-gsub("-X","xaxis",colnames(z_merge_actv))
z_colnam<-gsub("-Y","yaxis",z_colnam)
z_colnam<-gsub("-Z","zaxis",z_colnam)
z_colnam<-gsub("tBody","timeseriesbody",z_colnam)
z_colnam<-gsub("tGravity","timeseriesgravity",z_colnam)
z_colnam<-gsub("fBody","frequencybody",z_colnam)
z_colnam<-gsub("fGravity","frequencygravity",z_colnam)
z_colnam<-gsub("Acc","accelerator",z_colnam)
z_colnam<-gsub("Body","body",z_colnam)
z_colnam<-gsub("Gravity","gravity",z_colnam)
z_colnam<-gsub("Jerk","jerk",z_colnam)
z_colnam<-gsub("Gyro","gyroscope",z_colnam)
z_colnam<-gsub("Mag","magnitude",z_colnam)
z_colnam<-gsub("-mean\\(\\)","mean",z_colnam)
z_colnam<-gsub("-std\\(\\)","standarddeviation",z_colnam)
z_colnam
colnames(z_merge_actv)<-z_colnam
# Remove Activity_ID and move activitydescription column to second column
z_merge_actv2<-select(z_merge_actv,subjectidentifier,activitydescription,
                      timeseriesbodyacceleratormeanxaxis:frequencybodybodygyroscopejerkmagnitudestandarddeviation)
# Run the mean for all the variables grouping by subjectidentifier,
#    activitydescription
z_merge_actv3 <- z_merge_actv2 %>% 
     group_by(subjectidentifier,activitydescription) %>% 
     summarise_each(funs(mean))
# Write tidy dataset out to csv file
write.csv(z_merge_actv3, file ="UCIHAR.csv",row.names=FALSE)
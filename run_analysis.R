library(dplyr)
library(downloader)

setwd("./")
wdd<-getwd()

#Downloading data

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=file, destfile="./data.zip")
list.files("./")
datedownloaded <- date()
datedownloaded

#Unzipping data
unzip("./data.zip",exdir="./data1")


#Reading test and training data
datatest <- read.table("./data1/UCI HAR Dataset/test/X_test.txt")
str(datatest)
dim(datatest)
datatrain <- read.table("./data1/UCI HAR Dataset/train/X_train.txt")
str(datatrain)
dim(datatrain)

#Merging test and training data
datajoin <- bind_rows(datatest,datatrain)
str(datajoin)
dim(datajoin)

#Reading features names,  correcting and assigning them to the rows of the dataframe datajoin
features <- read.table("./data1/UCI HAR Dataset/features.txt")
str(features)
n1 <- gsub("\\-|\\(|\\)|\\,","_",features$V2)
n1 <- gsub("(\\_*)$","",n1)
n1 <- gsub("(\\_){2,4}","_",n1)
names(datajoin) <- n1
names(datajoin)

#Creating a new data frame with columns containing mean() and std() results
indexmean <- grep("mean()|std()",features$V2)
str(indexmean)
datajoin <- datajoin[,indexmean]
dim(datajoin)

#Adding a column of activity labels
datatrain_lab <- read.table("./data1/UCI HAR Dataset/train/y_train.txt")
datatest_lab <- read.table("./data1/UCI HAR Dataset/test/y_test.txt")
datajoin_lab <- bind_rows(datatest_lab,datatrain_lab)
names(datajoin_lab) <- "activitylabs"
str(datajoin_lab)
datajoin1<-bind_cols(datajoin_lab,datajoin)
str(datajoin1)

#Changing numarical labels of activities to their descriptions
activity_words <- read.table("./data1/UCI HAR Dataset/activity_labels.txt")
act_names <- function(x) x<-activity_words$V2[x==activity_words$V1]
datajoin1$activitylabs<-sapply(datajoin1$activitylabs,act_names)
datajoin1$activitylabs  

#Adding a column of subject numbers
datatest_subj_test <- read.table("./data1/UCI HAR Dataset/test/subject_test.txt")
datatest_subj_train <- read.table("./data1/UCI HAR Dataset/train/subject_train.txt")

datajoin1_subj<-bind_rows(datatest_subj_test,datatest_subj_train)
names(datajoin1_subj) <- "subjects"
dim(datajoin1_subj)
str(datajoin1_subj)

datajoin2<-bind_cols(datajoin1_subj,datajoin1)
datajoin2$subjects <- as.factor(datajoin2$subjects)
str(datajoin2)
sum(is.na(datajoin2))

#Groupping due to subjects and activities and computing means of each colums for the groups

datajoin_group <- group_by(datajoin2,subjects,activitylabs)
str(datajoin_group)
datajoin_summarize <- summarise_each(datajoin_group,funs(mean))
str(datajoin_summarize)
dim(datajoin_summarize)
head(datajoin_summarize,20)

#Saving results to the file averages.txt
write.table(datajoin_summarize, file = "./averages.txt", row.name=FALSE)

# Verifying that result was correctly written in to the file averages.txt
data <- read.table("./averages.txt", header = TRUE)
View(data)
dim(data)

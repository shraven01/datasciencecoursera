run_analysis <- function() {
    
  ## The purpose of this project is to demonstrate the ability to collect, work
  ## with, and clean a data set. The goal is to prepare tidy data that can be
  ## used for later analysis.
  ##
  ## Developed by Venky Thyagarajan
  ## 
  ## At a high-level, the R script first processes the training data and then 
  ## the test data. Then, the processed training and test data is combined. 
  ## Average is then calculated, and finally, two output text files are 
  ## produced. Process Training data.   All data tables that begin with "tr" 
  ## refer to Train data sets and "ts" refer to Test data sets Training data 
  ## represents 70% of the Subjects while Test data represents 30% of Subjects.
  ## 
  ## After you unzip the data make sure the directories are appropriately 
  ## updated before running the script.
  vL1Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/"
  vL2Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/"
  vTestDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test"
  vTrainDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train"

  setwd(vTrainDir)
  ## Load subjects into table
  tr1 <- read.table(file="subject_train.txt")
  names(tr1) <- c("subject")
  
  ## Load activities performed by subjects into table
  tr2 <- read.table(file="y_train.txt")
  names(tr2) <- c("activity")
  
  setwd(vL2Dir)
  ## Load activity labels into table
  tr3 <- read.table("activity_labels.txt")
  names(tr3) <- c("activity","activity.desc")
  
  ## Merge activities performed by the subjects and activities labels
  tr4 <- merge(tr2,tr3,by.x="activity",by.y="activity")
  
  ## Merge subjects and activities detailed information from pervious step
  tr5 <- data.frame(tr1,tr4)
  
  ## Load Features into table - Count: 561
  tr6 <- read.table("features.txt")
  ## Search for Standard Deviation Descriptions - std()
  s <- data.frame(grep("std",tr6$V2))

  ## Search for Standard Deviation Descriptions - mean()
  m <- data.frame(grep("mean",tr6$V2))
  
  setwd(vTrainDir)
  ## Load X Training into table 7352x561
  tr7 <- read.table("X_train.txt")
  
  setwd(vL1Dir)

  ## Combine mean variable columns with subject and activity data using a for
  ## loop. The variable columns will be added using cbind with an offset from
  ## the subject and activity columns
  
  tr8 <- data.frame(tr5)
  
  for ( i in 1:nrow(m)) {
    ## print(s[i,1])
    mVal <- m[i,1]
    mName <- tr6[mVal,2]
    for ( n in 1:ncol(tr7) ) {
      if (n == mVal) { 
        tr8 <- cbind(tr8,as.numeric(tr7[,mVal]))
        offSet <- ncol(tr8)
        mName <- tolower(mName)
        mName <- gsub("acc", "accelerometer.", mName)
        mName <- gsub("gyro", "gyroscope.", mName)
        mName <- gsub("tgravity", "gravity.", mName)
        mName <- gsub("fbody|tbody", "body.", mName)
        mName <- gsub("body.body", "body.", mName)
        mName <- gsub("jerk", "jerk.", mName)
        mName <- gsub("mag", "magnitude.", mName)
        mName <- gsub("freq", "frequency.", mName)
        mName <- gsub("mean", "mean.", mName)
        mName <- gsub("-|\\()", "", mName)
        mName <- gsub("mean.$", "mean", mName)
        mName <- gsub("frequency.$", "frequency", mName)
        names(tr8)[offSet] <- paste(gsub("-|\\()", "", mName))
      }
    }
  }
  
  ## Combine standard deviation variable columns with subject and activity data
  ## using a for loop. The variable columns will be added using cbind with an
  ## offset from the subject and activity columns
  
  for ( i in 1:nrow(s)) {
    ## print(s[i,1])
    sVal <- s[i,1]
    sName <- tr6[sVal,2]
    for ( n in 1:ncol(tr7) ) {
      if (n == sVal) { 
        tr8 <- cbind(tr8,as.numeric(tr7[,sVal]))
        offSet <- ncol(tr8)
        sName <- tolower(sName)
        sName <- gsub("acc", "accelerometer.", sName)
        sName <- gsub("gyro", "gyroscope.", sName)
        sName <- gsub("tgravity", "gravity.", sName)
        sName <- gsub("fbody|tbody", "body.", sName)
        sName <- gsub("body.body", "body.", sName)
        sName <- gsub("jerk", "jerk.", sName)
        sName <- gsub("mag", "magnitude.", sName)
        sName <- gsub("std", "standard.deviation.", sName)
        sName <- gsub("-|\\()|", "", sName)
        sName <- gsub("deviation.$", "deviation", sName)
        names(tr8)[offSet] <- paste(sName)
      }
    }
  }
  
  ## Include a column at the beginning to identify the type of data i.e. Training data
  tr9 <- data.frame(c("Training data"),tr8)
  names(tr9)[1] <- c("type.of.data")
  tr10 <- aggregate(tr9[,5:82],by=list(tr9$type.of.data,tr9$subject,tr9$activity,tr9$activity.desc),FUN="mean")
  names(tr10)[1] <- paste("type.of.data")
  names(tr10)[2] <- paste("subject")
  names(tr10)[3] <- paste("activity")
  names(tr10)[4] <- paste("activity.desc")
  
  ## Load Subjects into table
  setwd(vTestDir)
  ts1 <- read.table(file="subject_test.txt")
  names(ts1) <- c("subject")
  
  ## Load activities performed by subjects into table
  ts2 <- read.table(file="y_test.txt")
  names(ts2) <- c("activity")
  
  setwd(vL2Dir)
  ## Load activity labels into table
  ts3 <- read.table("activity_labels.txt")
  names(ts3) <- c("activity","activity.desc")
  
  ## Merge activities performed by the subjects and activities labels
  ts4 <- merge(ts2,ts3,by.x="activity",by.y="activity")
  
  ## Merge subjects and activities detailed information from pervious step
  ts5 <- data.frame(ts1,ts4)
  
  ## Load features into table - Count: 561
  ts6 <- read.table("features.txt")
  
  ## Search for Standard Deviation Descriptions - std()
  s <- data.frame(grep("std",ts6$V2))
  
  ## Search for Standard Deviation Descriptions - mean()
  m <- data.frame(grep("mean",ts6$V2))
  
  ## Load X Test into table 7352x561
  setwd(vTestDir)
  ts7 <- read.table("X_test.txt")
  
  setwd(vL1Dir)
  
  ## Combine mean variable columns with subject and activity data using a for
  ## loop. The variable columns will be added using cbind with an offset from
  ## the subject and activity columns
  
  ts8 <- data.frame(ts5)
  for ( i in 1:nrow(m)) {
    ## print(s[i,1])
    mVal <- m[i,1]
    mName <- ts6[mVal,2]
    for ( n in 1:ncol(ts7) ) {
      if (n == mVal) { 
        ts8 <- cbind(ts8,as.numeric(ts7[,mVal]))
        offSet <- ncol(ts8)
        mName <- tolower(mName)
        mName <- gsub("acc", "accelerometer.", mName)
        mName <- gsub("gyro", "gyroscope.", mName)
        mName <- gsub("tgravity", "gravity.", mName)
        mName <- gsub("fbody|tbody", "body.", mName)
        mName <- gsub("body.body", "body.", mName)
        mName <- gsub("jerk", "jerk.", mName)
        mName <- gsub("mag", "magnitude.", mName)
        mName <- gsub("freq", "frequency.", mName)
        mName <- gsub("mean", "mean.", mName)
        mName <- gsub("-|\\()", "", mName)
        mName <- gsub("mean.$", "mean", mName)
        mName <- gsub("frequency.$", "frequency", mName)
        names(ts8)[offSet] <- paste(gsub("-|\\()", "", mName))
      }
    }
  }
  
  ## Combine standard deviation variable columns with subject and activity data
  ## using a for loop. The variable columns will be added using cbind with an
  ## offset from the subject and activity columns
  
  for ( i in 1:nrow(s)) {
    ## print(s[i,1])
    sVal <- s[i,1]
    sName <- ts6[sVal,2]
    for ( n in 1:ncol(ts7) ) {
      if (n == sVal) { 
        ts8 <- cbind(ts8,as.numeric(ts7[,sVal]))
        offSet <- ncol(ts8)
        sName <- tolower(sName)
        sName <- gsub("acc", "accelerometer.", sName)
        sName <- gsub("gyro", "gyroscope.", sName)
        sName <- gsub("tgravity", "gravity.", sName)
        sName <- gsub("fbody|tbody", "body.", sName)
        sName <- gsub("body.body", "body.", sName)
        sName <- gsub("jerk", "jerk.", sName)
        sName <- gsub("mag", "magnitude.", sName)
        sName <- gsub("std", "standard.deviation.", sName)
        sName <- gsub("-|\\()|", "", sName)
        sName <- gsub("deviation.$", "deviation", sName)
        names(ts8)[offSet] <- paste(sName)
      }
    }
  }
  
  ## Include a column at the beginning to identify the type of data i.e. Test data
  ts9 <- data.frame(c("Test data"),ts8)
  names(ts9)[1] <- c("type.of.data")
 
  ts10 <- aggregate(ts9[,5:82],by=list(ts9$type.of.data,ts9$subject,ts9$activity,ts9$activity.desc),FUN="mean")
  names(ts10)[1] <- paste("type.of.data")
  names(ts10)[2] <- paste("subject")
  names(ts10)[3] <- paste("activity")
  names(ts10)[4] <- paste("activity.desc")
  
  ## Combine Training and Test data into a final data
  finalData <- rbind(tr9,ts9)
  finalDataAvg <- rbind(tr10,ts10)
  
  ## Create a tidy data text file that contains the combined Training and Test
  ## data containing the mean and standard deviation variable columns. Remove
  ## the first column containing the row numbers. Use a single space separator.
  write.table(finalData,file="harus_tidy_mean_std_data.txt",row.names=FALSE,sep=" ")
  
  ## Create a tidy data text file that contains the combined Training and Test 
  ## data containing the average variable columns grouped by type of data,
  ## subject and activity. Remove the first column containing the row numbers.
  ## Use a single space separator.
  write.table(finalDataAvg,file="harus_tidy_avg_data.txt",row.names=FALSE,sep=" ")
  
  return()
}

run_analysis <- function() {
	
  ## Set the directories
  vL1Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/"
  vL2Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/"
  vTestDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test"
	vTrainDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train"
	
  ## All data tables that begin with "tr" refer to Train data sets and "ts" refer to Test data sets
  ## Training data represents 70% of the Subjects while Test data represents 30% of Subjects

  ## Process Training data
  setwd(vTrainDir)
  ## Load Subjects into table
  tr1 <- read.table(file="subject_train.txt")
  names(tr1) <- c("subject")
  
  ## Load Activities performed by Subjects into table
  tr2 <- read.table(file="y_train.txt")
  names(tr2) <- c("activity")
  
  setwd(vL2Dir)
  ## Load Activity Labels into table
  tr3 <- read.table("activity_labels.txt")
  names(tr3) <- c("activity","activity.desc")
  
  ## Merge Subjects and Activities
  tr4 <- merge(tr2,tr3,by.x="activity",by.y="activity")
  
  ## Merge Subjects and Activities
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

  ## Combine Mean Columns with the Subject and Activity Columns
  tr8 <- data.frame(tr5)
  for ( i in 1:nrow(m)) {
    ## print(s[i,1])
    mVal <- m[i,1]
    mName <- tr6[mVal,2]
    for ( n in 1:ncol(tr7) ) {
      if (n == mVal) { 
        tr8 <- cbind(tr8,tr7[,mVal])
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
  ## Combine Std Columns with the Subject and Activity Columns
  for ( i in 1:nrow(s)) {
    ## print(s[i,1])
    sVal <- s[i,1]
    sName <- tr6[sVal,2]
    for ( n in 1:ncol(tr7) ) {
      if (n == sVal) { 
        tr8 <- cbind(tr8,tr7[,sVal])
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
  ## print(paste("HARUS: Processed ",nrow(tr8),"rows and",ncol(tr8),"columns of training data"))
  
  ## Include a column at the beginning to identify Training data
  tr9 <- data.frame(c("Training data"),tr8)
  names(tr9)[1] <- c("type.of.data")
  
  ## print("HARUS: Processing Test data")
  ## Load Subjects into table
  setwd(vTestDir)
  ts1 <- read.table(file="subject_test.txt")
  names(ts1) <- c("subject")
  
  ## Load Activities performed by Subjects into table
  ts2 <- read.table(file="y_test.txt")
  names(ts2) <- c("activity")
  
  setwd(vL2Dir)
  ## Load Activity Labels into table
  ts3 <- read.table("activity_labels.txt")
  names(ts3) <- c("activity","activity.desc")
  
  ## Merge Subjects and Activities
  ts4 <- merge(ts2,ts3,by.x="activity",by.y="activity")
  
  ## Merge Subjects and Activities
  ts5 <- data.frame(ts1,ts4)
  
  ## Load Features into table - Count: 561
  ts6 <- read.table("features.txt")
  ## Search for Standard Deviation Descriptions - std()
  s <- data.frame(grep("std",ts6$V2))
  
  ## Search for Standard Deviation Descriptions - mean()
  m <- data.frame(grep("mean",ts6$V2))
  
  ## Load X Test into table 7352x561
  setwd(vTestDir)
  ts7 <- read.table("X_test.txt")
  
  setwd(vL1Dir)
  
  ## Combine Mean Columns with the Subject and Activity Columns
  ts8 <- data.frame(ts5)
  for ( i in 1:nrow(m)) {
    ## print(s[i,1])
    mVal <- m[i,1]
    mName <- ts6[mVal,2]
    for ( n in 1:ncol(ts7) ) {
      if (n == mVal) { 
        ts8 <- cbind(ts8,ts7[,mVal])
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
  ## Combine Std Columns with the Subject and Activity Columns
  for ( i in 1:nrow(s)) {
    ## print(s[i,1])
    sVal <- s[i,1]
    sName <- ts6[sVal,2]
    for ( n in 1:ncol(ts7) ) {
      if (n == sVal) { 
        ts8 <- cbind(ts8,ts7[,sVal])
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
  ## print(paste("HARUS: Processed ",nrow(ts8),"rows and",ncol(ts8),"columns of test data"))
  
  ## Include a column at the beginning to identify Test data
  ts9 <- data.frame(c("Test data"),ts8)
  names(ts9)[1] <- c("type.of.data")
  finalData <- rbind(tr9,ts9)
  
  ## Create a tidy data text file that contains the combined Training and Test data
  write.table(finalData,file="harus_tidy_finalreport.txt",row.names=FALSE,sep=" ")
  
  ## Create a tidy data text file that contains average of the variables by activity
  
  return()  

}

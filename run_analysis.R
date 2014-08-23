run_analysis <- function() {
  ##
  ## Purpose: As a part of the Course Project for 'Getting and Cleaning Data', this R code has been written to 
  ## perform the following funcitons:
  ## Step 1: Load Subject and Activity data for Training and Test
  ## Step 2: Extract only the Mean and Standard Deviation variables from the features (which contains a total of 561 variables)
  ## Step 3: Merge the Subject and Activity data for Training and Test with Variables extracted in Step 2
  ## Step 4: Calculate the Average for the Training and Test data
  ## Step 5: Write the output text files for Mean/Standard Deviation and Average Training and Test data
  ## 
  ## Note: 
  ## 1. First the Training data is processed and then the Test data is processed
  ## 2. All data tables that begin with "tr" refer to Train data sets and "ts" refer to Test data sets
  ## 3. Training data represents 70% (7352) of the Subjects while Test data represents 30% of Subjects 
  ## Set the directories
  ##
  vL1Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/"
  vL2Dir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/"
  vTestDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test"
	vTrainDir="/Users/Administrator/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train"
	
  ## Process Training data
  setwd(vTrainDir)
  ## Step 1: Load Subject and Activity data for Training
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
  
  ## Step 2: Extract only the Mean and Standard Deviation variables from the features (which contains a total of 561 variables)
  tr6 <- read.table("features.txt")
  
  ## Search for Standard Deviation Descriptions - std()
  s <- data.frame(grep("std",tr6$V2))

  ## Search for Standard Deviation Descriptions - mean()
  m <- data.frame(grep("mean",tr6$V2))
  
  setwd(vTrainDir)

  ## Step 3: Merge the Subject and Activity data for Training with Variables extracted in Step 2
  ## Load X Training into table 7352x561
  tr7 <- read.table("X_train.txt")
  
  setwd(vL1Dir)

  ## Combine Mean and Standard Deviation Columns with the Subject and Activity Columns
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
  ## Combine Std Columns with the Subject and Activity Columns
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
  ## print(paste("HARUS: Processed ",nrow(tr8),"rows and",ncol(tr8),"columns of training data"))
  
  ## Include a column at the beginning to identify Training data
  tr9 <- data.frame(c("Training data"),tr8)
  names(tr9)[1] <- c("type.of.data")

  ## Step 4: Calculate the Average for the Training data
  tr10 <- aggregate(tr9[,5:82],by=list(tr9$type.of.data,tr9$subject,tr9$activity,tr9$activity.desc),FUN="mean")
  names(tr10)[1] <- paste("type.of.data")
  names(tr10)[2] <- paste("subject")
  names(tr10)[3] <- paste("activity")
  names(tr10)[4] <- paste("activity.desc")
  
  ########################
  ## Processing Test data
  ########################
  ## Step 1: Load Subject and Activity data for Test
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
  
  ## Step 2: Extract only the Mean and Standard Deviation variables from the features (which contains a total of 561 variables)
  ts6 <- read.table("features.txt")

  ## Search for Standard Deviation Descriptions - std()
  s <- data.frame(grep("std",ts6$V2))
  
  ## Search for Standard Deviation Descriptions - mean()
  m <- data.frame(grep("mean",ts6$V2))
  
  ## Step 3: Merge the Subject and Activity data for Training with Variables extracted in Step 2
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
  ## Combine Std Columns with the Subject and Activity Columns
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
  ## print(paste("HARUS: Processed ",nrow(ts8),"rows and",ncol(ts8),"columns of test data"))
  
  ## Include a column at the beginning to identify Test data
  ts9 <- data.frame(c("Test data"),ts8)
  names(ts9)[1] <- c("type.of.data")

  ## Step 4: Calculate the Average for Test data
  ts10 <- aggregate(ts9[,5:82],by=list(ts9$type.of.data,ts9$subject,ts9$activity,ts9$activity.desc),FUN="mean")
  names(ts10)[1] <- paste("type.of.data")
  names(ts10)[2] <- paste("subject")
  names(ts10)[3] <- paste("activity")
  names(ts10)[4] <- paste("activity.desc")
  
  ## Step 5: Write the output text files for Mean/Standard Deviation and Average Training and Test data
  
  ## Create a tidy data text file that contains the combined Training and Test data
  finalData <- rbind(tr9,ts9)
  write.table(finalData,file="harus_tidy_mean_std_data.txt",row.names=FALSE,sep=" ")
  
  ## Create a tidy data text file that contains average of the variables by activity
  finalDataAvg <- rbind(tr10,ts10)
  write.table(finalDataAvg,file="harus_tidy_avg_data.txt",row.names=FALSE,sep=" ")
  return()
}

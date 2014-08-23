The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
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

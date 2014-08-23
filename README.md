#INTRODUCTION

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Following have been submitted: 
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that have been performed to clean up the data called CodeBook.md. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##CODE DESCRIPTION:

At a high-level, the R script first processes the training data and then the test data. Then, the processed training and test data is combined. Average is then calculated, and finally, two output text files are produced.

The R script called run_analysis.R performs the following steps for each type of data (training and test):
Step 1: Load training and test data for subjects. In this step list of activity codes and descriptions are also loaded.
Step 2: Load the features data that contains 561 variables with code and descriptions. 
Step 3: Merge the subject and activity data. And then include the Variables with this merged data using a loop. While loading the variables, clean and standardize the variables based on http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf. The variables have been made more descriptive, converted to lower case, replaced '-' with '.' 
Step 4: Calculate the Average by grouping on type of data, subject and activity
Step 5: Write the output text files for Mean/Standard Deviation and Average into two separate text files.
 
Note: 
1. First the Training data is processed and then the Test data is processed
2. All data tables that begin with "tr" refer to Train data sets and "ts" refer to Test data sets
3. Training data represents 70% (7352) of the Subjects while Test data represents 30% of Subjects

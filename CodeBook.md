# Code book for 'Getting And Cleaning Data Project assignment'

## Summary
This document contains:
1. Raw data
2. Trasformations and work to clean up the data
3. Output explanation

## Raw data

Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.   

Attribute Information:  

For each record in the dataset it is provided:   
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.  

Original data sets: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Check the README.txt file for further details about this dataset.  


## Trasformations and work to clean up the data

0.1 Get raw data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
    - The raw data are downloaded locally (UCI_HAR_data.zip) and extacted (UCI_HAR_data directory)
0.2 Load Common tables  
1   Merges the training and the test sets to create one data set.  
2   Extracts only the measurements on the mean and standard deviation for each measurement.  
3   Uses descriptive activity names to name the activities in the data set  
4   Appropriately labels the data set with descriptive variable names  
5   Creates a tidy data set with the average of each variable for each activity and each subject  

## Output explanation
The run_analysis() output is a tidy data set with the following characteristics.  
Each data point is the average for each activity and each subject  

### Data set dimension:

*  66  Rows    - Rappresenting the Mean and StandardDeviation for 33 Measurements  
*  180 Columns - Rappresnting each activity (6) and each subject (30) [6*30 = 180]  
  
### Columns
*  The activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
*  There are 30 subjects  
* Example: The columns "WALKING_DOWNSTAIRS.Subject_22" indicates measurement for the subject number 22 for the WALKING_DOWNSTAIRS activity.  

### Rows

Each Row contains a label that may specified if the measure is a time domain or frequency domain.
Each Row contains a label that may specified if the measure is a Mean or a Standard Deviation.

Each Row will specify which measurement contains:

    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (BodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
    
    Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (BodyAccJerk-XYZ and BodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (BodyAccMag, tGravityAccMag, BodyAccJerkMag, BodyGyroMag, BodyGyroJerkMag). 
    
    Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing BodyAcc-XYZ, BodyAccJerk-XYZ, BodyGyro-XYZ, BodyAccJerkMag, BodyGyroMag, BodyGyroJerkMag. 
    
    These signals were used to estimate variables of the feature vector for each pattern:  
    '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
    
    BodyAcc-XYZ
    GravityAcc-XYZ
    BodyAccJerk-XYZ
    BodyGyro-XYZ
    BodyGyroJerk-XYZ
    BodyAccMag
    GravityAccMag
    BodyAccJerkMag
    BodyGyroMag
    BodyGyroJerkMag
    BodyAcc-XYZ
    BodyAccJerk-XYZ
    BodyGyro-XYZ
    BodyAccMag
    BodyAccJerkMag
    BodyGyroMag
    BodyGyroJerkMag
    BodyAccMean
    BodyAccJerkMean
    BodyGyroMean
    BodyGyroJerkMean
    gravityMean










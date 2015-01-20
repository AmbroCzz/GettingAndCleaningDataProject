# You should create one R script called run_analysis.R that does the following.

run_analysis <- function()
{
    # 0.1 Get data file if not already there
    message("0.1 Get data file if not already there")

    if (!file.exists("./UCI HAR Dataset")) {
        # download the data
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        destFileZip="./UCI_HAR_data.zip"
        message("Downloading Dataset")
        download.file(fileURL, destfile=destFileZip, method="auto")
        unzip(destFileZip)
    }


    # 0.2 Load Common tables
    message("0.2 Load Common tables")
    features <- read.table(file = "./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
    colnames(activity_labels) <- c("activityCode", "activityDescription")

    # 1.  Merges the training and the test sets to create one data set.
    message("1   Merges the training and the test sets to create one data set.")
    message("1.1 Reading test set")
    subject_test   <- read.table("./UCI HAR Dataset/test/subject_test.txt" )
    X_test         <- read.table("./UCI HAR Dataset/test/X_test.txt"       )
    y_test         <- read.table("./UCI HAR Dataset/test/y_test.txt"       )
    colnames(X_test)  <- features[ , 2]

    dataTest <- cbind(subject_test, y_test, X_test)
    colnames(dataTest)[1:2] <- c("subject", "activityCode")

    message("1.2 Reading training set")
    subject_train  <- read.table("./UCI HAR Dataset/train/subject_train.txt" )
    X_train        <- read.table("./UCI HAR Dataset/train/X_train.txt"       )
    y_train        <- read.table("./UCI HAR Dataset/train/y_train.txt"       )
    colnames(X_train) <- features[ , 2]

    dataTrain <- cbind(subject_train, y_train, X_train)
    colnames(dataTrain)[1:2] <- c("subject", "activityCode")

    dataTestTrain <- rbind(dataTest, dataTrain)

    # 2.  Extracts only the measurements on the mean and standard deviation for each measurement.
    message("2   Extracts only the measurements on the mean and standard deviation for each measurement.")
    featuresMeanStd <- grep(pattern = "mean|std", features[,2], value = TRUE)

    # 2.1 Remove features erroneusly matched in previous grep (*meanFreq*)
    message("2.1 Remove features erroneusly matched in previous grep (*meanFreq*)")
    featuresMeanStdOnly <- grep(pattern = "meanFreq", featuresMeanStd, value = TRUE, invert = TRUE)

    dataSelected <- dataTestTrain[ , c("subject", "activityCode", featuresMeanStdOnly)]

    # 3.  Uses descriptive activity names to name the activities in the data set
    message("3   Uses descriptive activity names to name the activities in the data set")
    d2 <- merge(activity_labels, dataSelected, by = "activityCode")

    # 3.1 Sort by activityCode and subject (not required)
    d2 <- d2[order(d2[,1], d2[,3]), ]
    # 3.2 remove activityCode
    d2 <- d2[, -1]

    # 4.  Appropriately labels the data set with descriptive variable names.
    message("4   Appropriately labels the data set with descriptive variable names")

    names(d2) <- gsub(x = names(d2), pattern = "-std\\(\\)" , replacement = ".StandardDeviation" )
    names(d2) <- gsub(x = names(d2), pattern = "-mean\\(\\)", replacement = ".Mean" )

    # Based on features_info.txt
    # time      domain signals (prefix 't')
    # frequency domain signals (prefix 'f')
    lNames = length(names(d2))
    for( i in 1:lNames)
    {
        if ( grepl("^f", names(d2)[i] ) )
        {
            names(d2)[i] <- gsub(x = names(d2)[i], pattern = '^f', replacement = "")
            names(d2)[i] <- paste0(names(d2)[i], ".FrequencyDomain")
        }
        else
            if ( grepl("^t", names(d2)[i] ) )
            {
                names(d2)[i] <- gsub(x = names(d2)[i], pattern = '^t', replacement = "")
                names(d2)[i] <- paste0(names(d2)[i], ".TimeDomain")
            }
    }

    # 5.  From the data set in step 4, creates a second, independent tidy data set with
    #     the average of each variable for each activity and each subject.

    message("5   Creates a tidy data set with the average of each variable for each activity and each subject");

    splitted <- split(d2, list(d2$activityDescription, d2$subject), drop = TRUE)

    final <- sapply(splitted, function(x) colMeans(x[, names(d2)[c(-1,-2)]]))
    colnames(final) <- gsub(x = colnames(final), pattern = '\\.', replacement = ".Subject_")

    return(final)
}




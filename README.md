# Getting-and-cleaning-data-project
This repository was created for the Coursera "Getting and cleaning data" course

The R script, run_analysis.R, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Loads both the training and test datasets, 
3. Loads the activity and subject data for each dataset, and merges those columns with the dataset
4. Merges the two datasets and keep only those columns which reflect a mean or standard deviation
5. Replaces activity numbers with descriptive names
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
8. The end result is shown in the file tidy.txt.

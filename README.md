# GettingDataProject
##final project for getting and cleaning data coursera course

This script works with the Samsung data found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script uses r base packages, data.table and dplyr and their dependencies.

##Process
- The data is unzipped, read into data tables and columns are labelled. (training and test data read in separately)
- training and test data are combined into one data table.
- Calculated means and standard deviations are extracted from the table.
- activities are appropriately labelled
- The averages of the means and standard deviations are calculated for each of the extracted means and standard deviations for each activity for each subject. 
- This calculation is put into a data table and arranged into a long format. 
- The data table is written to a file.
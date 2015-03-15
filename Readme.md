# **README**

The repository contains the course project "Getting and Cleaning data".

One of  exciting areas in data science now is wearable computing. The project uses data collected from the accelerometers from the Samsung Galaxy S smartphone. The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (`WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING`). There are 561 measured values for each volunteer's activity.  All information is stored in different files which can be downloaded as a zip archive.

A full description of the data is available at the site: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The project prepares a tidy data set that can be used for later analysis. This tidy data set contains  averages of each variable with measurements on the mean and standard deviation.

The analysis is fully atomized.

* To download the data from Internet and get the tidy data set one has to execute the R script `run_analysis.R` 

* The resulting tidy data will be written to the file `averages.txt` which can be found in the folder whith the R script 

* The description of the data, variables, transformations and  work performed to clean up the data can be found in the file `Codebook.md`.  Comments in the R script `run_analysis.R` show which R code chunks  perform corresponding transformations of data 






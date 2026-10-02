# Getting and Cleaning Data Course Project

This repository contains the required deliverables for the Johns Hopkins Getting and Cleaning Data course project.

## Overview
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The source data represents data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Files Included
* **run_analysis.R**: The R script that downloads the dataset, merges training and test sets, extracts mean/std measurements, applies descriptive activity names, labels variables, and calculates variable averages.
* **tidy_dataset.txt**: The final output dataset containing average values for each variable grouped by subject and activity.
* **CodeBook.md**: A codebook describing variables, data, and transformations performed.
* **README.md**: This file, providing an overview of the repository.

## How to Run the Script
1. Open RStudio.
2. Run `source("run_analysis.R")`.
3. The script will automatically download and unzip the dataset if necessary, process the data, and generate `tidy_dataset.txt` in your working directory.

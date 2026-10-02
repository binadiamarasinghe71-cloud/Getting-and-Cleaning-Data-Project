# Code Book - Getting and Cleaning Data Course Project

This code book describes the variables, data, and transformations performed to clean up the UCI HAR Dataset.

## Dataset Overview
* **Source**: UCI Machine Learning Repository - Human Activity Recognition Using Smartphones Data Set.
* **Subjects**: 30 volunteers aged 19–48 years.
* **Activities**: 6 daily activities performed wearing a smartphone (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

## Variables in tidy_dataset.txt

### Identifiers
* `subject`: ID of the subject (1 to 30).
* `activity`: Name of the activity performed.

### Signal Measurements
All measurements are numerical values representing the average of normalized signal data bounded within [-1, 1] for each subject and activity:
* `TimeAccelerometerMean-X/Y/Z` & `STD-X/Y/Z`
* `TimeGravityAccelerometerMean-X/Y/Z` & `STD-X/Y/Z`
* `TimeAccelerometerJerkMean-X/Y/Z` & `STD-X/Y/Z`
* `TimeGyroscopeMean-X/Y/Z` & `STD-X/Y/Z`
* `TimeGyroscopeJerkMean-X/Y/Z` & `STD-X/Y/Z`
* `TimeAccelerometerMagnitudeMean` / `STD`
* `TimeGravityAccelerometerMagnitudeMean` / `STD`
* `TimeAccelerometerJerkMagnitudeMean` / `STD`
* `TimeGyroscopeMagnitudeMean` / `STD`
* `TimeGyroscopeJerkMagnitudeMean` / `STD`
* `FrequencyAccelerometerMean-X/Y/Z` & `STD-X/Y/Z`
* `FrequencyAccelerometerJerkMean-X/Y/Z` & `STD-X/Y/Z`
* `FrequencyGyroscopeMean-X/Y/Z` & `STD-X/Y/Z`
* `FrequencyAccelerometerMagnitudeMean` / `STD`
* `FrequencyAccelerometerJerkMagnitudeMean` / `STD`
* `FrequencyGyroscopeMagnitudeMean` / `STD`
* `FrequencyGyroscopeJerkMagnitudeMean` / `STD`

## Transformations Performed
1. Merged training (`X_train`, `y_train`, `subject_train`) and testing (`X_test`, `y_test`, `subject_test`) datasets.
2. Extracted measurements containing `mean()` and `std()`.
3. Applied descriptive activity names using `activity_labels.txt`.
4. Relabeled abbreviated variable names into clear descriptive names (e.g., `t` to `Time`, `Acc` to `Accelerometer`, `Gyro` to `Gyroscope`).
5. Grouped by `subject` and `activity` to calculate average values across all measurements into `tidy_dataset.txt`.

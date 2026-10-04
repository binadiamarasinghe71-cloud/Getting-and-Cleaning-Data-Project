library(dplyr)

# 0. Download and unzip dataset if it doesn't exist
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"

if (!file.exists(zip_file)) {
  download.file(dataset_url, zip_file, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) {
  unzip(zip_file)
}

data_path <- "UCI HAR Dataset"

# Load metadata
features <- read.table(file.path(data_path, "features.txt"), col.names = c("index", "feature_name"))
activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("class_id", "activity_name"))

# Load test dataset
subject_test <- read.table(file.path(data_path, "test", "subject_test.txt"), col.names = "subject")
x_test <- read.table(file.path(data_path, "test", "X_test.txt"), col.names = features$feature_name, check.names = FALSE)
y_test <- read.table(file.path(data_path, "test", "y_test.txt"), col.names = "activity_code")

# Load train dataset
subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"), col.names = "subject")
x_train <- read.table(file.path(data_path, "train", "X_train.txt"), col.names = features$feature_name, check.names = FALSE)
y_train <- read.table(file.path(data_path, "train", "y_train.txt"), col.names = "activity_code")

# 1. Merge training and test sets
subject_all <- rbind(subject_train, subject_test)
x_all       <- rbind(x_train, x_test)
y_all       <- rbind(y_train, y_test)

merged_data <- cbind(subject_all, y_all, x_all)

# 2. Extract mean and std measurements
selected_features <- features$feature_name[grep("mean|std", features$feature_name, ignore.case = TRUE)]
selected_columns  <- c("subject", "activity_code", selected_features)

filtered_data <- merged_data[, selected_columns]

# 3. Use descriptive activity names
filtered_data$activity_code <- factor(
  filtered_data$activity_code,
  levels = activity_labels$class_id,
  labels = activity_labels$activity_name
)
filtered_data <- rename(filtered_data, activity = activity_code)

# 4. Label data set with descriptive variable names
names(filtered_data) <- gsub("^t", "Time", names(filtered_data))
names(filtered_data) <- gsub("^f", "Frequency", names(filtered_data))
names(filtered_data) <- gsub("Acc", "Accelerometer", names(filtered_data))
names(filtered_data) <- gsub("Gyro", "Gyroscope", names(filtered_data))
names(filtered_data) <- gsub("Mag", "Magnitude", names(filtered_data))
names(filtered_data) <- gsub("BodyBody", "Body", names(filtered_data))
names(filtered_data) <- gsub("-mean\\(\\)", "Mean", names(filtered_data), ignore.case = TRUE)
names(filtered_data) <- gsub("-std\\(\\)", "Std", names(filtered_data), ignore.case = TRUE)
names(filtered_data) <- gsub("-freq\\(\\)", "Frequency", names(filtered_data), ignore.case = TRUE)
names(filtered_data) <- gsub("angle", "Angle", names(filtered_data), ignore.case = TRUE)
names(filtered_data) <- gsub("gravity", "Gravity", names(filtered_data), ignore.case = TRUE)
names(filtered_data) <- gsub("[\\(\\)-]", "", names(filtered_data))

# 5. Create independent tidy data set with averages
tidy_data <- filtered_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# Save tidy dataset
write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)

cat("Success! 'tidy_dataset.txt' created successfully.\n")



#### Preamble ####
# Purpose: Tests on the simulated data of behavioral interventions to 
  #assess their impact on student academic and engagement outcomes.
# Author: Shuangyuan Yang
# Date: 22 November 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Complete and run the file named "00-simulate_data.R".
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)

# Read in the simulated data
test_simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv", show_col_types = FALSE)

# Test if the data was successfully loaded
if (exists("test_simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 1000 rows
if (nrow(test_simulated_data) == 1000) {
  message("Test Passed: The dataset has 1000 rows.")
} else {
  stop("Test Failed: The dataset does not have 1000 rows.")
}

# Check if the dataset has 29 columns
if (ncol(test_simulated_data) == 29) {
  message("Test Passed: The dataset has 29 columns.")
} else {
  stop("Test Failed: The dataset does not have 29 columns.")
}

# Check if there are any missing values in the simulated data
if (all(!is.na(test_simulated_data))) {
  message("Test Passed: This dataset has no missing values.")
} else {
  stop("Test Failed: This dataset contains missing values.")
}

# Check if all values in the 'ID' column are unique
if (n_distinct(test_simulated_data$ID) == nrow(test_simulated_data)) {
  message("Test Passed: All values have unique 'ID'.")
} else {
  stop("Test Failed: The 'ID' column contains duplicate values.")
}

# Check if the 'sex' column contains only valid gender
valid_sex <- c("Male", "Female")
if (all(test_simulated_data$sex %in% valid_sex)) {
  message("Test Passed: The 'sex' column contains only valid gender.")
} else {
  stop("Test Failed: The 'sex' column contains other invalid gender besides 'Male' and 'Female'.")
}

# Check if the 'Year' column contains only valid study years
valid_Year <- 1:4
if (all(test_simulated_data$Year %in% valid_Year)) {
  message("Test Passed: The 'Year' column contains only valid study years.")
} else {
  stop("Test Failed: The 'Year' column contains invalid study years.")
}

# Check if the 'Coded.CGPA' column contains values within 1 to 4
if (all(test_simulated_data$Coded.CGPA >= 1 & test_simulated_data$Coded.CGPA <= 4)) {
  message("Test Passed: The 'Coded.CGPA' column only contains values between 1 and 4.")
} else {
  stop("Test Failed: The 'Coded.CGPA' column contains values outside the range of 1 to 4.")
}

# Check if the 'exam_score' column contains all values between 0 and 150
if (all(test_simulated_data$exam_score >= 0 & test_simulated_data$exam_score <= 150)) {
  message("Test Passed: The 'exam_score' column only contains values between 0 and 150.")
} else {
  stop("Test Failed: The 'exam_score' column contains values outside the range of 0 to 100.")
}

# Check if the 'coursemark' column contains all values between 0 and 150
if (all(test_simulated_data$coursemark >= 0 & test_simulated_data$coursemark <= 150)) {
  message("Test Passed: The 'coursemark' column only contains values between 0 and 150.")
} else {
  stop("Test Failed: The 'coursemark' column contains values outside the range of 0 to 150.")
}

# Check if the 'Section' column contains all values between 1 and 7
valid_Sections <- 1:7
if (all(test_simulated_data$Section %in% valid_Sections)) {
  message("Test Passed: The 'Section' column contains only valid values from 1 to 7.")
} else {
  stop("The 'Section' column contains invalid values.")
}

# Check if all pre-intervention columns have values between 1 and 7
pre_columns <- c("affect_pre", "cog_pre", "value_pre", "difficulty_pre", "interest_pre", "effort_pre")
for (col in pre_columns) {
  if (all(test_simulated_data[[col]] >= 1 & test_simulated_data[[col]] <= 7)) {
    message(paste("Test Passed:", col, "contains all values between 1 and 7."))
  } else {
    stop(paste("Test Failed:", col, "contains values outside the range of 1 to 7."))
  }
}

# Check if all post-intervention columns have values between 1 and 7
post_columns <- c("affect_post", "cog_post", "value_post", "difficulty_post", "interest_post", "effort_post")
for (col in post_columns) {
  if (all(test_simulated_data[[col]] >= 1 & test_simulated_data[[col]] <= 7)) {
    message(paste("Test Passed:", col, "contains all values between 1 and 7."))
  } else {
    stop(paste("Test Failed:", col, "contains values outside the range of 1 to 7."))
  }
}

# Check if all change columns are correctly calculated
change_columns <- c("change_affect", "change_cog", "change_value", "change_difficulty", "change_interest", "change_effort")
for (col in change_columns) {
  # Extract the corresponding pre and post column names
  pre_col <- gsub("change_", "pre_", col)
  post_col <- gsub("change_", "post_", col)
  calculated_change <- test_simulated_data[[post_col]] - test_simulated_data[[pre_col]]
  # Compare the calculated change with the existing column
  if (all(round(test_simulated_data[[col]], 2) == round(calculated_change, 2))) {
    message(paste("Test Passed:", col, "is correctly calculated."))
  } else {
    stop(paste("Test Failed:", col, "is not correctly calculated."))
  }
}

# # Check if the 'Open_Email' column contains only binary values 0 or 1
valid_Open_Email <- c(0, 1)
if (all(test_simulated_data$Open_Email %in% valid_Open_Email)) {
  message("Test Passed: The 'Open_Email' column contains only valid binary values.")
} else {
  stop("Test Failed: The 'Open_Email' column contains invalid values.")
}

# Check if the 'online' column contains only valid class types
valid_online <- c("In-class", "Online")
if (all(test_simulated_data$online %in% valid_online)) {
  message("Test Passed: The 'online' column contains only valid class types.")
} else {
  stop("Test Failed: The 'online' column contains invalid class types.")
}

# Check if the 'cgpa' column contains only valid grades
valid_cgpa <- c("A", "B", "C", "D")
if (all(test_simulated_data$cgpa %in% valid_cgpa)) {
  message("Test Passed: The 'cgpa' column contains only valid grades.")
} else {
  stop("Test Failed: The 'cgpa' column contains invalid grades.")
}

# Check if the 'email' column contains only valid email types
valid_email <- c("Plain", "Interesting")
if (all(test_simulated_data$email %in% valid_email)) {
  message("Test Passed: The 'email' column contains only valid email types.")
} else {
  stop("Test Failed: The 'email' column contains invalid values.")
}

# Check if the distribution of the 'Year' column matches the expected probabilities
expected_probs_Year <- c("1" = 0.15, "2" = 0.70, "3" = 0.10, "4" = 0.05)
observed_Year <- table(test_simulated_data$Year)
chi_Year <- chisq.test(x = observed_Year, p = expected_probs_Year)
if (chi_Year$p.value > 0.05) {
  message("Test Passed: The observed distribution of 'Year' column matches the expected probabilities.")
} else {
  stop("Test Failed: The observed distribution of 'Year' column does not match the expected probabilities.")
}

# Check if the distribution of the 'Open_Email' column matches the expected probabilities
expected_probs_Open_Email <- c("0" = 0.45, "1" = 0.55)
observed_Open_Email <- table(test_simulated_data$Open_Email)
chi_Open_Email <- chisq.test(x = observed_Open_Email, p = expected_probs_Open_Email)
if (chi_Open_Email$p.value > 0.05) {
  message("Test Passed: The observed distribution of 'Open_Email' column matches the expected probabilities.")
} else {
  stop("Test Failed: The observed distribution of 'Open_Email' column does not match the expected probabilities.")
}

# Check if the distribution of the 'online' column matches the expected probabilities
expected_probs_online <- c("in-class" = 0.87, "online" = 0.13)
observed_counts <- table(test_simulated_data$online)
chi_online <- chisq.test(x = observed_counts, p = expected_probs_online)
if (chi_online$p.value > 0.05) {
  message("Test Passed: The observed distribution of 'online' column matches the expected probabilities.")
} else {
  stop("Test Failed: The observed distribution of 'online' column does not match the expected probabilities.")
}

# Check if the distribution of the 'cgpa' column matches the expected probabilities
expected_probs_cgpa <- c("A" = 0.15, "B" = 0.35, "C" = 0.35, "D" = 0.15)
observed_cgpa <- table(test_simulated_data$cgpa)
chi_cgpa <- chisq.test(x = observed_cgpa, p = expected_probs_cgpa)
if (chi_cgpa$p.value > 0.05) {
  message("Test Passed: The observed distribution of 'cgpa' column matches the expected probabilities.")
} else {
  stop("Test Failed: The observed distribution of 'cgpa' column does not match the expected probabilities.")
}

# Check if the distribution of the 'email' column matches the expected probabilities
expected_probs_email <- c("Plain" = 0.50, "Interesting" = 0.50)
observed_email <- table(test_simulated_data$email)
chi_email <- chisq.test(x = observed_email, p = expected_probs_email)
if (chi_email$p.value > 0.05) {
  message("Test Passed: The observed distribution of 'email' column matches the expected probabilities.")
} else {
  stop("Test Failed: The observed distribution of 'email' column does not match the expected probabilities.")
}


#### Preamble ####
# Purpose: Tests on the simulated data of behavioral interventions to
# assess their impact on student academic and engagement outcomes.
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Complete and run the file named "00-simulate_data.R".
# Any other information needed? N/A


#### Workspace setup ####
library(testthat)

# Read in the simulated data
test_simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

#### Test data ####

# Test if the dataset was successfully loaded
test_that("Dataset is successfully loaded", {
  expect_true(exists("test_simulated_data"),
    info = "The dataset could not be loaded."
  )
})

# Test that the dataset has 1000 rows - there are 1000 students
test_that("dataset has 1000 rows", {
  expect_equal(nrow(test_simulated_data), 1000)
})

# Test that the dataset has 6 columns
test_that("dataset has 6 columns", {
  expect_equal(ncol(test_simulated_data), 6)
})

# Test that the dataset has the correct columns
test_that("dataset has all required columns", {
  expected_columns <- c(
    "email", "change in affect",
    "change in cognitive competence", "change in difficulty", "change in interest",
    "change in effort"
  )
  expect_equal(sort(names(test_simulated_data)), sort(expected_columns))
})

# Test that there are no missing values in dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(test_simulated_data)))
})

# Test that all change variables are numeric
test_that("change variables are numeric", {
  change_columns <- c(
    "change in affect", "change in cognitive competence", "change in difficulty",
    "change in interest", "change in effort"
  )
  for (col in change_columns) {
    expect_type(test_simulated_data[[col]], "double")
  }
})

# Test that `change in*` columns are not excessively large or small
test_that("change variables have reasonable values", {
  change_columns <- c(
    "change in affect", "change in cognitive competence", "change in difficulty",
    "change in interest"
  )
  for (col in change_columns) {
    expect_true(all(test_simulated_data[[col]] >= -6 & test_simulated_data[[col]] <= 6))
  }
})

# Test that `change in effort` columns are not excessively large or small
test_that("change variables have reasonable values", {
  change_in_effort <- c(
    "change in effort"
  )
  for (col in change_in_effort) {
    expect_true(all(test_simulated_data[[col]] >= -10 & test_simulated_data[[col]] <= 10))
  }
})

# Test that `change in*` variables are rounded to two decimal places
test_that("change variables are rounded to two decimal places", {
  change_columns <- c(
    "change in affect", "change in cognitive competence", "change in difficulty",
    "change in interest", "change in effort"
  )
  for (col in change_columns) {
    expect_true(all(test_simulated_data[[col]] == round(test_simulated_data[[col]], 2)))
  }
})

# Test that the `email` column contains only valid types
test_that("email column contains valid types", {
  valid_email <- c("Plain", "Interesting")
  expect_true(all(test_simulated_data$email %in% valid_email))
})

# Test that there are at least 2 unique levels in `email`
test_that("email column has at least 2 unique values", {
  expect_true(length(unique(test_simulated_data$email)) >= 2)
})

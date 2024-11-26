#### Preamble ####
# Purpose: Test the analysis data that get in "03-clean_data.R".
# Author: Shuangyuan Yang
# Date: 22 November 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: clean and save the raw data 
  #(complete and run the file named "03-clean_data.R")
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)

#### Test Data ####

# Load the analysis dataset
test_analysis_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

# Test that the dataset has 622 rows - there are 622 students
test_that("dataset has 622 rows", {
  expect_equal(nrow(test_analysis_data), 622)
})

# Test that the dataset has 8 columns
test_that("dataset has 7 columns", {
  expect_equal(ncol(test_analysis_data), 7)
})

# Test that the dataset has the correct columns
test_that("dataset has all required columns", {
  expected_columns <- c("id", "email", "change_affect", 
                        "change_cog", "change_difficulty", "change_interest", 
                        "change_effort")
  expect_equal(sort(names(test_analysis_data)), sort(expected_columns))
})

# Test that there are no missing values in dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(test_analysis_data)))
})

# Test that the `id` column is unique and sequential
test_that("id column is unique and sequential", {
  expect_equal(n_distinct(test_analysis_data$id), nrow(test_analysis_data))
  expect_true(all(diff(test_analysis_data$id) == 1))
})

# Test that the `email` column contains only valid types
test_that("email column contains valid types", {
  valid_email <- c("Plain", "Interesting")
  expect_true(all(test_analysis_data$email %in% valid_email))
})

# Test that all change variables are numeric
test_that("change variables are numeric", {
  change_columns <- c("change_affect", "change_cog", "change_difficulty", 
                      "change_interest", "change_effort")
  for (col in change_columns) {
    expect_type(test_analysis_data[[col]], "double")
  }
})

# Test that `change_*` columns are not excessively large or small
test_that("change variables have reasonable values", {
  change_columns <- c("change_affect", "change_cog", "change_difficulty", 
                      "change_interest", "change_effort")
  for (col in change_columns) {
    expect_true(all(test_analysis_data[[col]] >= -6 & test_analysis_data[[col]] <= 6))
  }
})

# Test that `change_*` variables are rounded to two decimal places
test_that("change variables are rounded to two decimal places", {
  change_columns <- c("change_affect", "change_cog", "change_difficulty", 
                      "change_interest", "change_effort")
  for (col in change_columns) {
    expect_true(all(test_analysis_data[[col]] == round(test_analysis_data[[col]], 2)))
  }
})

# Test that there are at least 2 unique levels in `email`
test_that("email column has at least 2 unique values", {
  expect_true(length(unique(test_analysis_data$email)) >= 2)
})


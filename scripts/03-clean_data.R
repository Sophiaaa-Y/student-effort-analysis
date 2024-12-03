#### Preamble ####
# Purpose: Cleans the raw data of behavioral interventions to assess their
# impact on student academic and engagement outcomes that get
# in "02-download_data.R".
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Complete and run the file named "02-download_data.R".
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(dplyr)
library(janitor)

#### Clean Data ####
# Load the raw data
raw_data <- read_csv("data/01-raw_data/raw_data.csv", show_col_types = FALSE)

# Data Cleaning For:

# 1. Standardizing Column Names

# 2. Filtering:
# - Make sure values of these (`affect_pre`, `affect_post`, `cog_pre`, `cog_post`, `difficulty_pre`, `difficulty_post`, `interest_pre`,
#   `interest_post`, `effort_pre`, `effort_post`) are in the valid range of 1 to 7.
# - The `email` column is non-missing.
# - The `open_email` column equals 1, ensuring that only rows where the email was opened are included.

# 3. Transforming Variables:
# - `email`: Converts the email style into a categorical variable with levels "Plain" and "Interesting".
# - `change_affect`, `change_cog`, change_difficulty, `change_interest`, `change_effort`: Rounds these variables to two decimal places.

# 4. Selecting Columns: `email`, `change_affect`, `change_cog`, `change_difficulty`, `change_interest`, `change_effort`.

# 5. Rename the selected columns.

# 6. Removes Missing Values.

# 7. Saving the analysis data in `.parquet` formats for use in further analysis.

#### Clean Data ####
analysis_data <- raw_data %>%
  # Standardize column names
  clean_names() %>%
  # Filtering criteria
  filter(
    affect_pre >= 1 & affect_pre <= 7, # Valid pre-intervention affect level
    affect_post >= 1 & affect_post <= 7, # Valid post-intervention affect level
    cog_pre >= 1 & cog_pre <= 7, # Valid pre-intervention cognitive competence level
    cog_post >= 1 & cog_post <= 7, # Valid post-intervention cognitive competence level
    difficulty_pre >= 1 & difficulty_pre <= 7, # Valid pre-intervention difficulty level
    difficulty_post >= 1 & difficulty_post <= 7, # Valid post-intervention difficulty level
    interest_pre >= 1 & interest_pre <= 7, # Valid pre-intervention interest level
    interest_post >= 1 & interest_post <= 7, # Valid post-intervention interest level
    effort_pre >= 1 & effort_pre <= 7, # Valid pre-intervention effort level
    effort_post >= 1 & effort_post <= 7, # Valid post-intervention effort level
    !is.na(email), # Remove rows with missing email type
    open_email == 1 # Include only rows where the email was opened
  ) %>%
  mutate( # Convert categorical variable to factor
    email = factor(email, levels = c("Plain", "Interesting")),

    # Round relevant numeric columns to 2 decimals
    across(c(change_affect, change_cog, change_difficulty, change_interest, change_effort), ~ round(.x, 2)),
  ) %>%
  # Select relevant columns
  select(
    `email`, `change_affect`, `change_cog`, `change_difficulty`, `change_interest`,
    `change_effort`
  ) %>%
  # Renaming the column names
  rename(
    `change in affect` = `change_affect`,
    `change in cognitive competence` = `change_cog`,
    `change in difficulty` = `change_difficulty`,
    `change in interest` = `change_interest`,
    `change in effort` = `change_effort`
  ) %>%
  # Key Variables:
  # - `email`: The style of email received by the student, which purpose is to try to motivate learning and improve score.
  #    This is categorized as "Plain" or "Interesting".
  # - `change in affect`: Change in affect level before and after the intervention.
  # - `change in cognitive competence`: Change in cognitive competence level before and after the intervention.
  # - `change in difficulty`: Change in difficulty level before and after the intervention.
  # - `change in interest`: Change in interest level before and after the intervention.
  # - `change in effort`: Change in effort level before and after the intervention.

  drop_na()

#### Save data ####
write_parquet(analysis_data, "data/02-analysis_data/analysis_data.parquet")

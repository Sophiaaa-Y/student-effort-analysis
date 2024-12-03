#### Preamble ####
# Purpose: Simulate the dataset of behavioral interventions to assess their
# impact on student academic and engagement outcomes.
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install the `janitor (Firke 2023)` and `tidyverse` package.
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Simulate Data ####
# Set seed for reproducibility
set.seed(917)

# Number of data points
n <- 1000

# Generate predictors
affect_pre <- round(runif(n, 1, 7), 2)
cog_pre <- round(runif(n, 1, 7), 2)
difficulty_pre <- round(runif(n, 1, 7), 2)
interest_pre <- round(runif(n, 1, 7), 2)

affect_post <- round(runif(n, 1, 7), 2)
cog_post <- round(runif(n, 1, 7), 2)
difficulty_post <- round(runif(n, 1, 7), 2)
interest_post <- round(runif(n, 1, 7), 2)

# Simulate changes
change_in_affect <- round(affect_post - affect_pre, 2)
change_in_cognitive_competence <- round(cog_post - cog_pre, 2)
change_in_difficulty <- round(difficulty_post - difficulty_pre, 2)
change_in_interest <- round(interest_post - interest_pre, 2)

# Simulate email style
email_type <- sample(c("Plain", "Interesting"), n, replace = TRUE)
email_type_numeric <- ifelse(email_type == "Plain", 0, 1)

# Define weights and bias for generating effort based on predictors
weight_affect <- 0.5
weight_interest <- 0.7
weight_difficulty <- -0.4
weight_cognitive <- 0.6
weight_email <- 0.3
bias <- 0.2

# Simulate "change_in_effort" using weighted formula
change_in_effort <- round(weight_affect * change_in_affect +
  weight_interest * change_in_interest +
  weight_difficulty * change_in_difficulty +
  weight_cognitive * change_in_cognitive_competence +
  weight_email * email_type_numeric +
  bias + rnorm(n, mean = 0, sd = 0.1), 2)

# Combine into a single tibble
simulated_effectofnudge_data <- tibble(
  email = email_type,
  `change in affect` = change_in_affect,
  `change in cognitive competence` = change_in_cognitive_competence,
  `change in difficulty` = change_in_difficulty,
  `change in interest` = change_in_interest,
  `change in effort` = change_in_effort
)

# Display the first few rows of the simulated data
head(simulated_effectofnudge_data)

#### Save data ####
write_csv(
  simulated_effectofnudge_data,
  "data/00-simulated_data/simulated_data.csv"
)

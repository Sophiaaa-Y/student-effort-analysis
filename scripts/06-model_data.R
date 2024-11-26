#### Preamble ####
# Purpose: Use the analysis data to set up the model.
# Author: Shuangyuan Yang
# Date: 22 November 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Complete and run the file named "03-clean_data.R", 
  #and the file named "04-test_analysis_data.R"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(rstanarm) # Load the rstanarm package for Bayesian modeling
library(arrow)    # Load the arrow package to read Parquet files
library(dplyr)    # Load dplyr for data manipulation
library(here)     # Load here for relative file paths

#### Read data ####
model_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

### Model data ####
# Fit a Bayesian linear regression model
set.seed(569) # Ensure reproducibility
change_effort_model <- stan_glm(
  formula = change_effort ~ change_affect + change_cog + change_difficulty + change_interest + email,
  data = model_data,
  family = gaussian(),       # Use Gaussian family for linear regression
  prior = normal(0, 2.5),    # Weakly informative normal prior for coefficients
  prior_intercept = normal(0, 5), # Weakly informative prior for the intercept
  prior_aux = cauchy(0, 2.5) # Weakly informative prior for the residual standard deviation
)

# Print the summary of the Bayesian model to inspect the results
print(summary(change_effort_model))

# Posterior predictive checks
pp_check(change_effort_model)

# Plot the posterior distributions of coefficients
plot(change_effort_model)

#### Save Model ####
saveRDS(change_effort_model, file = "models/change_effort_model.rds")


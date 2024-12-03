#### Preamble ####
# Purpose: Use the analysis data to set up the model.
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Complete and run the file named "03-clean_data.R",
# and the file named "04-test_analysis_data.R"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(rstanarm) # Load the rstanarm package for Bayesian modeling
library(arrow) # Load the arrow package to read Parquet files
library(dplyr) # Load dplyr for data manipulation
library(Metrics)

#### Read data ####
model_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
# Fit a Bayesian linear regression model
set.seed(56) # Ensure reproducibility
change_effort_model_bayesian <- stan_glm(
  formula = `change in effort` ~ `change in affect` + `change in cognitive competence` + `change in difficulty` + `change in interest` + `email`,
  data = model_data,
  family = gaussian(), # Use Gaussian family for linear regression
  prior = normal(0, 2.5), # Weakly informative normal prior for coefficients
  prior_intercept = normal(0, 5), # Weakly informative prior for the intercept
  prior_aux = cauchy(0, 2.5) # Weakly informative prior for the residual standard deviation
)

# Fit the frequentist linear regression model
change_effort_model_frequentist <- lm(
  formula = `change in effort` ~ `change in affect` +
    `change in cognitive competence` +
    `change in difficulty` +
    `change in interest` +
    `email`,
  data = model_data
)

# Print the summary of the Bayesian model to inspect the results
print(summary(change_effort_model_bayesian))

# Posterior predictive checks
pp_check(change_effort_model_bayesian)

# Plot the posterior distributions of coefficients
plot(change_effort_model_bayesian)

# Print the summary of the linear regression model to inspect the results
print(summary(change_effort_model_frequentist))

# Diagnostic plots to check residuals and model fit
par(mfrow = c(2, 2)) # Set up a 2x2 grid for plots
plot(change_effort_model_frequentist)

#### Save Model ####
saveRDS(change_effort_model_bayesian, file = "models/change_effort_model_bayesian.rds")
saveRDS(change_effort_model_frequentist, file = "models/change_effort_model_frequentist.rds")

#### Compare These Two Models ####

# Split data into training and testing sets
train_indices <- sample(1:nrow(model_data), 0.8 * nrow(model_data)) # 80% training
train_data <- model_data[train_indices, ]
test_data <- model_data[-train_indices, ]

### Fit Bayesian model ###
change_effort_model_bayesian <- stan_glm(
  formula = `change in effort` ~ `change in affect` + `change in cognitive competence` +
    `change in difficulty` + `change in interest` + `email`,
  data = train_data,
  family = gaussian(),
  prior = normal(0, 2.5),
  prior_intercept = normal(0, 5),
  prior_aux = cauchy(0, 2.5)
)

### Fit Frequentist model ###
change_effort_model_frequentist <- lm(
  formula = `change in effort` ~ `change in affect` + `change in cognitive competence` +
    `change in difficulty` + `change in interest` + `email`,
  data = train_data
)

### Predict on test set ###

# Bayesian model predictions
pred_bayesian <- posterior_predict(change_effort_model_bayesian, newdata = test_data)
pred_bayesian_mean <- rowMeans(pred_bayesian) # Use mean of posterior predictions

# Frequentist model predictions
pred_frequentist <- predict(change_effort_model_frequentist, newdata = test_data)

### Evaluate prediction performance ###

# Calculate RMSE for Bayesian model
rmse_bayesian <- rmse(test_data$`change in effort`, pred_bayesian_mean)

# Calculate RMSE for Frequentist model
rmse_frequentist <- rmse(test_data$`change in effort`, pred_frequentist)

# Print RMSE comparison
print(paste("RMSE for Bayesian model:", round(rmse_bayesian, 3)))
print(paste("RMSE for Frequentist model:", round(rmse_frequentist, 3)))

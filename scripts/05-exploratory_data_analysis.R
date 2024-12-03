#### Preamble ####
# Purpose: Explore and understand the data get in "03-clean_data.R"
# by creating data visualizations.
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: complete and run the file named "03-clean_data.R"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Exploratory Data Analysis ####

# Load the analysis data
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Overview of the dataset
cat("Dataset dimensions:", nrow(analysis_data), "rows and", ncol(analysis_data), "columns.\n")
glimpse(analysis_data)

# Combine all histograms into one graph with facets
analysis_data_distribution <- analysis_data %>%
  select(`change in effort`, `change in affect`, `change in cognitive competence`, `change in difficulty`, `change in interest`) %>%
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "Variables' values")

# Create the combined histogram
ggplot(analysis_data_distribution, aes(x = `Variables' values`)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white", alpha = 0.8) +
  facet_wrap(~Variable, scales = "free", ncol = 3) +
  labs(y = "Frequency") +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_affect` with regression line
ggplot(analysis_data, aes(x = `change in affect`, y = `change in effort`)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    x = "Change in Affect",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_cog` with regression line
ggplot(analysis_data, aes(x = `change in cognitive competence`, y = `change in effort`)) +
  geom_point(alpha = 0.6, color = "darkgreen") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    x = "Change in Cognitive Competence",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_difficulty` with regression line
ggplot(analysis_data, aes(x = `change in difficulty`, y = `change in effort`)) +
  geom_point(alpha = 0.6, color = "orange") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    x = "Change in Difficulty",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_interest` with regression line
ggplot(analysis_data, aes(x = `change in interest`, y = `change in effort`)) +
  geom_point(alpha = 0.6, color = "red") +
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
  labs(
    x = "Change in Interest",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Boxplot of `change_effort` by `email`
ggplot(analysis_data, aes(x = email, y = `change in effort`, fill = email)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(alpha = 0.3, width = 0.15, height = 0) +
  labs(
    x = "Email Type",
    y = "Change in Effort"
  ) +
  theme_minimal()

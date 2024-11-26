#### Preamble ####
# Purpose: Explore and understand the data get in "03-clean_data.R" 
  #by creating data visualizations.
# Author: Shuangyuan Yang
# Date: 22 November 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: complete and run the file named "03-clean_data.R"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(here)
library(arrow)

#### Exploratory Data Analysis ####

# Load the analysis data
analysis_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

# Overview of the dataset
cat("Dataset dimensions:", nrow(analysis_data), "rows and", ncol(analysis_data), "columns.\n")
glimpse(analysis_data)

# Combine all histograms into one graph with facets
analysis_data_distribution <- analysis_data %>%
  select(change_effort, change_affect, change_cog, change_difficulty, change_interest) %>%
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "Variables_values")

# Create the combined histogram
ggplot(analysis_data_distribution, aes(x = Variables_values)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white", alpha = 0.8) +
  facet_wrap(~ Variable, scales = "free", ncol = 3) +
  labs(
    title = "Combined Histograms of Key Variables' distributions",
    x = "Variables_values",
    y = "Frequency"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_affect` with regression line
ggplot(analysis_data, aes(x = change_affect, y = change_effort)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    title = "Change in Effort vs Change in Affect",
    x = "Change in Affect",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_cog` with regression line
ggplot(analysis_data, aes(x = change_cog, y = change_effort)) +
  geom_point(alpha = 0.6, color = "darkgreen") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    title = "Change in Effort vs Change in Cognitive Competence",
    x = "Change in Cognitive Competence",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_difficulty` with regression line
ggplot(analysis_data, aes(x = change_difficulty, y = change_effort)) +
  geom_point(alpha = 0.6, color = "orange") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    title = "Change in Effort vs Change in Difficulty",
    x = "Change in Difficulty",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Scatterplot of `change_effort` vs `change_interest` with regression line
ggplot(analysis_data, aes(x = change_interest, y = change_effort)) +
  geom_point(alpha = 0.6, color = "red") +
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
  labs(
    title = "Change in Effort vs Change in Interest",
    x = "Change in Interest",
    y = "Change in Effort"
  ) +
  theme_minimal()

# Boxplot of `change_effort` by `email`
ggplot(analysis_data, aes(x = email, y = change_effort, fill = email)) +
  geom_boxplot(alpha = 0.8) +
  labs(
    title = "Change in Effort by Email Type",
    x = "Email Type",
    y = "Change in Effort"
  ) +
  theme_minimal()


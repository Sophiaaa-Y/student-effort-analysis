#### Preamble ####
# Purpose: Simulate the dataset of behavioral interventions to assess their  
  #impact on student academic and engagement outcomes.
# Author: Shuangyuan Yang
# Date: 21 November 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install the `janitor (Firke 2023)` and `tidyverse` package.
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Simulate data ####
# Set seed for reproducibility
set.seed(917)

# Create a tibble with simulated data
simulated_effectofnudge_data <- tibble(
  
  # Simulate pre-intervention measures with scores between 1 and 7, 
    #randomly generated 1000 times
  affect_pre = round(runif(1000, 1, 7), 2),
  cog_pre = round(runif(1000, 1, 7), 2),
  difficulty_pre = round(runif(1000, 1, 7), 2),
  interest_pre = round(runif(1000, 1, 7), 2),
  effort_pre = round(runif(1000, 1, 7), 2),
  
  # Simulate post-intervention measures with scores between 1 and 7, 
    #randomly generated 1000 times
  affect_post = round(runif(1000, 1, 7), 2),
  cog_post = round(runif(1000, 1, 7), 2),
  difficulty_post = round(runif(1000, 1, 7), 2),
  interest_post = round(runif(1000, 1, 7), 2),
  effort_post = round(runif(1000, 1, 7), 2),
  
  # Simulate changes in measures after intervention by using the value of 
    #post-intervention minus the value of pre-intervention
  change_affect = round(affect_post - affect_pre, 2),
  change_cog = round(cog_post - cog_pre, 2),
  change_difficulty = round(difficulty_post - difficulty_pre, 2),
  change_interest = round(interest_post - interest_pre, 2),
  change_effort = round(effort_post - effort_pre, 2), 
  
  # Simulate e-mail style
  email = sample(c("Plain", "Interesting"), 1000, replace = TRUE, 
                 prob = c(0.50, 0.50))) %>% # Rough email type distribution
  
  select(`email`, `change_affect`, `change_cog`, `change_difficulty`, `change_interest`, 
         `change_effort`) %>%

  rename(
    `change in affect` = `change_affect`,
    `change in cognitive competence` = `change_cog`,
    `change in difficulty` = `change_difficulty`, 
    `change in interest` = `change_interest`, 
    `change in effort` = `change_effort`
  ) 

# Display the first few rows of the simulated data
head(simulated_effectofnudge_data)

#### Save data ####
write_csv(simulated_effectofnudge_data, 
          "data/00-simulated_data/simulated_data.csv")


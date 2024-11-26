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
  # Simulate 1000 IDs
  ID = 1:1000,
  
  # Simulate gender
  sex = sample(c("Male", "Female"), 1000, replace = TRUE), 
  
  # Simulate year of study
  Year = sample(c(1, 2, 3, 4), 1000, replace = TRUE, 
                prob = c(0.15, 0.70, 0.10, 0.05)), # Rough year distribution
  
  # Simulate CGPA coded category, randomly generated 1000 times
  Coded.CGPA = sample(1:4, 1000, replace = TRUE),
  
  # Simulate exam score between 0 and 100, randomly generated 1000 times
  exam_score = round(runif(1000, min = 0, max = 150), 1),
  
  # Simulate course marks between 0 and 100, randomly generated 1000 times
  coursemark = round(runif(1000, min = 0, max = 150), 1),
  
  # Simulate section identifier
  Section = sample(1:7, 1000, replace = TRUE),
  
  # Simulate pre-intervention measures with scores between 1 and 7, 
    #randomly generated 1000 times
  affect_pre = round(runif(1000, 1, 7), 2),
  cog_pre = round(runif(1000, 1, 7), 2),
  value_pre = round(runif(1000, 1, 7), 2),
  difficulty_pre = round(runif(1000, 1, 7), 2),
  interest_pre = round(runif(1000, 1, 7), 2),
  effort_pre = round(runif(1000, 1, 7), 2),
  
  # Simulate post-intervention measures with scores between 1 and 7, 
    #randomly generated 1000 times
  affect_post = round(runif(1000, 1, 7), 2),
  cog_post = round(runif(1000, 1, 7), 2),
  value_post = round(runif(1000, 1, 7), 2),
  difficulty_post = round(runif(1000, 1, 7), 2),
  interest_post = round(runif(1000, 1, 7), 2),
  effort_post = round(runif(1000, 1, 7), 2),
  
  # Simulate changes in measures after intervention by using the value of 
    #post-intervention minus the value of pre-intervention
  change_affect = round(affect_post - affect_pre, 2),
  change_cog = round(cog_post - cog_pre, 2),
  change_value = round(value_post - value_pre, 2),
  change_difficulty = round(difficulty_post - difficulty_pre, 2),
  change_interest = round(interest_post - interest_pre, 2),
  change_effort = round(effort_post - effort_pre, 2), 
  
  # Simulate binary indicator for email opening
  Open_Email = sample(c(0, 1), 1000, replace = TRUE, 
                      prob = c(0.45, 0.55)), # Rough gender distribution
  
  # Simulate type of the course
  online = sample(c("In-class", "Online"), 1000, replace = TRUE, 
                  prob = c(0.87, 0.13)), # Rough class type distribution
  
  # Simulate CGPA grade
  cgpa = sample(c("A", "B", "C", "D"), 1000, replace = TRUE, 
                prob = c(0.15, 0.35, 0.35, 0.15)), # Rough CGPA distribution),
  
  # Simulate e-mail style
  email = sample(c("Plain", "Interesting"), 1000, replace = TRUE, 
                 prob = c(0.50, 0.50)), # Rough email type distribution)
)

# Display the first few rows of the simulated data
head(simulated_effectofnudge_data)

#### Save data ####
write_csv(simulated_effectofnudge_data, 
          "data/00-simulated_data/simulated_data.csv")


#### Preamble ####
# Purpose: Downloads and saves the data from the github named "nudgedata".
# Author: Shuangyuan Yang
# Date: 3 December 2024
# Contact: shuangyuan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install the `tidyverse` packages and `dplyr` package.
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Read in the downloaded data ####
raw_data <- read_csv("data/01-raw_data/effectofnudge.csv",
  show_col_types = FALSE
)

#### Save data again for analysis ####
write_csv(raw_data, "data/01-raw_data/raw_data.csv")

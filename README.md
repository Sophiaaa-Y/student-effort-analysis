# Exploring the Drivers of Academic Effort: A Bayesian Analysis of Email-Based Interventions and Behavioral Changes

## Overview

This GitHub Repository contains all files used to generate the paper Exploring the Exploring the Drivers of Academic Effort: A Bayesian Analysis of Email-Based Interventions and Behavioral Changes. The study analyzes how changes in emotional states, perceived cognitive competence, difficulty perception, intrinsic interest, and email intervention types influence changes in student effort following an email-based intervention. The results reveal that increased emotional engagement, intrinsic interest, and receiving more engaging ("Interesting") emails positively impact student effort, while higher difficulty perception is associated with reduced effort. The repository provides a comprehensive framework for data analysis, modeling, and reporting using Bayesian statistical methods, and the data is obtained from [Nudge Data Repository](https://github.com/ntaback/nudgedata).


## File Structure

The repo is structured as:

-   `data/00-simulated_data` Contains simulated datasets created for testing.
-   `data/01-raw_data` contains the raw data as obtained from the [Nudge Data Repository](https://github.com/ntaback/nudgedata).
-   `data/02-analysis_data` contains the cleaned data used in this analysis.
-   `models` contains fitted Bayesian Multiple Linear Regression model. 
-   `other/datasheet` Contains a detailed datasheet for the datasets used, outlining key metadata, provenance, preprocessing steps, and other relevant documentation to ensure transparency and reproducibility.
-   `other/literature` contains copies of references used in the analysis.
-   `other/llm_usage` contains the entire chat history with ChatGPT-4o.
-   `other/sketches` contains sketches of the data and Bayesian model, and visualizations that used in this study.
-   `paper` contains a PDF version of the final paper, the Quarto file used to create the PDF, and a file containing the references for the paper.
-   `scripts` contains R scripts for data simulation, downloading, cleaning, testing, EDA, and modeling.


## Statement on LLM usage

Some aspects of this project are generated with help from ChatGPT-4o such as code, visualizations, and paragraphs. The entire chat history is available in `other/llm/usage.txt`.

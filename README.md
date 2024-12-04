# Exploring the Impact of Encouragement and Student Behaviour on Academic Effort in Second-year Statistics Courses


## Overview

This repository contains all data, R scripts, and materials necessary for generating and reproducing the analysis for *Exploring the Impact of Encouragement and Student Behaviour on Academic Effort in Second-year Statistics Courses*. The research investigates the effects of task complexity, intrinsic motivation, emotional states, cognitive competence, and email intervention types on changes in student effort. The repository provides a comprehensive framework for data analysis, modeling, and reporting using Bayesian statistical methods, and the data is obtained from [Nudge Data Repository](https://github.com/ntaback/nudgedata.git).


## File Structure

The repo is structured as:

-   **`data/00-simulated_data`** Contains simulated datasets created for testing.
-   **`data/01-raw_data`** contains the raw data as obtained from the [Nudge Data Repository](https://github.com/ntaback/nudgedata).
-   **`data/02-analysis_data`** contains the cleaned data used in this analysis.
-   **`models`** contains fitted Bayesian Multiple Linear Regression model and the Frequentist model. 
-   **`other/datasheet`** Contains a detailed datasheet for the datasets used, outlining key metadata, provenance, preprocessing steps, and other relevant documentation to ensure transparency and reproducibility.
-   **`other/literature`** contains copies of references used in the analysis.
-   **`other/llm_usage`** contains the entire chat history with ChatGPT-4o.
-   **`other/sketches`** contains sketches of the data and Bayesian model, and visualizations that used in this study.
-   **`paper`** contains a PDF version of the final paper, the Quarto file used to create the PDF, and a file containing the references for the paper.
-   **`scripts`** contains R scripts for data simulation, downloading, cleaning, testing, EDA, and modeling.


## Statement on LLM usage

Some aspects of this project are generated with help from ChatGPT-4o. Firstly, it helps to generate code for data cleaning, simulation, test, and modeling, as well as creating visualizations to represent analytical results. It also provides some draft text for some sections such as the title and subtitle, abstract, introduction, discussion, and summaries for visualizations. Besides, ChatGPT-4o provides some ideas for model setup, model prior distributions, justifications for both model and variables, measurement, results, clean data process, data and model detail parts in the appendix such as summaries for visualizations, and two methodology parts in the appendix. Additionally, ChatGPT-4o provides some improvement suggestions for the paper structure and content. Moreover, ChatGPT-4o also provides ideas for `datasheet`. The entire chat history with ChatGPT-4o is available in `other/llm_usage/usage.txt`.

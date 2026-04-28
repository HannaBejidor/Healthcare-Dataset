# Healthcare Analysis:
# 'D-dimer test analysis for PE/DVT using MS Excel, SQL and Power BI'

## Project Overview
D-dimer is a protein fragment, a byproduct of plasmin degradation. D-dimer test is a very common primary test to detect the fragment of blood clot, including its nature of having a high sensitivity and low specificity, resulting to a high negative predictive value (NPV) [Bounds and Kok, 2023](https://www.ncbi.nlm.nih.gov/books/NBK431064/#), making it a very helpful test for ruling out more serious diagnoses such as Pulmonary Embolism (PE) or Deep Vein Thrombosis (DVT).

The aim and objective of this project is to investigate and perform a descriptive and diagnostic data analysis on the synthetic dataset from 2024-2025 and to answer real-world clinical questions. To execute this, basic to advanced applications of MS Excel, MySQL (query programming language), and Power BI (for data visualisation) as one ecosystem will be used.

Click link for full written report paper: [Link](https://1drv.ms/w/c/cf57a7fa3a3da56f/IQBqkGWvN5ufQbwwczhcdvKEARNQHe6WsQFFfDzZzFaXA6w?e=Rg2cBI)

#### Tools used for the analysis were:
- MS Excel for showing data overview and pivot table: [MsExcel-Ddimer](https://1drv.ms/x/c/cf57a7fa3a3da56f/IQBq-Bu4LSfnSKsURK0buuuhAdRVD0q0e5ujj_1D4KNc5O8?e=JCs1y1)
- Basic Power BI dashboard for visual analysis
- MySQL, to perform queries for data filtering, sorting, data aggregation and further understanding the data.
  
## Data Structure overview
This D-dimer dataset is a synthetic data I created based on real-world data available from a clinical laboratory. The data was imported in tabular form, then using Excel to view the data. Spreadsheet containing 12,300 rows with 9 column variables of: Lab_number, Name, Date_of_specimen, Sex, Date_of_birth, Age, numeric_result, Result_text, and Clinical_text.

Based on the given data, descriptive analysis was performed to analyse patients influx to investigate sample flow per month/quarterly/yearly. And analyse patients demographics and its relation with d-dimer numeric results, such as gender distribution, age frequency and average d-dimer based on patients age.
Figure below shows a summary descriptive analysis using Power BI.

<img width="1289" height="727" alt="Screenshot 2026-04-10 164652" src="https://github.com/user-attachments/assets/d3d342dc-eede-4790-8025-584aa4daaefd" />

## Executive summary
The dashboard shows the summary of descriptive analysis of the lab samples for checking d-dimer test results.
- Influx of samples every month from January 2024 - December 2025 : Total Sample size = 12264
- Gender distribution: Female = 46% (5640): Male = 53% (6501)  ; Other = 1% 123
- Age frequency of the sample population is showing a normal distribution of age. With mean age of 51 years old, minimum age of 9 years old and maximum age of 97 years old.

The figure below shows a table of descriptive analysis using pivot tables.
<img width="688" height="340" alt="Screenshot 2026-04-11 001902" src="https://github.com/user-attachments/assets/d58c6f83-20a5-48c2-bf6b-cf19d6498e57" />

## Conclusion





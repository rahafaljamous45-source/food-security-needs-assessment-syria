# Food Security Needs Assessment – Syria

**Data Cleaning, Indicator Calculation & Analysis using R**

This project demonstrates a complete, reproducible workflow for processing household food security survey data, inspired by real-world humanitarian needs assessments (e.g., IMPACT Initiatives, WFP, OCHA).

---

## Project Overview

The project simulates a typical Multi-Sector Needs Assessment (MSNA) / Food Security survey workflow:

1. Starts with raw survey-style data (including realistic data quality issues)
2. Performs systematic data cleaning
3. Calculates standard food security indicators
4. Produces summary tables ready for dashboarding (Power BI / Tableau)

---

## Key Skills Demonstrated

- Importing and handling survey data in R
- Detecting and treating missing values
- Identifying and handling outliers
- Standardizing inconsistent categorical variables
- Calculating the **Food Consumption Score (FCS)** according to WFP methodology
- Calculating **Food Expenditure Share**
- Creating grouped summary tables
- Exporting clean, analysis-ready datasets and multi-sheet Excel files
- Writing reproducible and well-structured R scripts

---

## Project Structure

- **data/raw/** : Original / generated raw data
- **data/processed/** : Cleaned data + indicators + summary tables
- **scripts/** :
  - `01_generate_realistic_data.R` : Creates realistic survey data with common data quality issues
  - `02_clean_data.R` : Data cleaning pipeline
  - `03_calculate_indicators.R` : Calculates FCS, Food Expenditure Share, and summary tables
- **outputs/** : Final Excel file (`syria_food_security_analysis.xlsx`)
- **README.md**
- **LICENSE**

---

## Indicators Calculated

### 1. Food Consumption Score (FCS)

Calculated using the standard WFP formula:

- Staples × 2  
- Pulses × 3  
- Dairy × 4  
- Meat/Fish/Eggs × 4  
- Vegetables × 1  
- Fruits × 1  
- Oil/Fat × 0.5  
- Sugar × 0.5  

**Categories used (high threshold):**

- Poor: ≤ 28  
- Borderline: 28.1 – 42  
- Acceptable: > 42  

### 2. Food Expenditure Share

Percentage of total household income spent on food.

---

## How to Run the Project

1. Clone or download this repository
2. Open the project in RStudio
3. Install required packages (if needed):

```r
install.packages(c("tidyverse", "janitor", "here", "naniar", "openxlsx"))
```
4. Run the scripts in order:
- scripts/01_generate_realistic_data.R
- scripts/02_clean_data.R
- scripts/03_calculate_indicators.R

## Outputs

- Clean household-level dataset with indicators
- Summary tables by Governorate, Household Type, and Gender of Household Head
- Multi-sheet Excel file ready for Power BI or further analysis

---

## Notes

- The raw data was intentionally generated with common real-world issues (missing values, outliers, and inconsistent text categories) to demonstrate a realistic cleaning workflow.
- This project is intended for learning and portfolio purposes and uses a small sample size.

---

## Author

**Rahaf Aljamous**  
Aspiring Data Analyst | Humanitarian / Food Security Data
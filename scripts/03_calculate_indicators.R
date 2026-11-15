library(tidyverse)
library(here)
survey <- read_csv(here("data", "processed", "syria_food_security_survey_clean.csv"))
survey <- survey %>%
  mutate(
    FCS = (FCSStap * 2) +
      (FCSPulse * 3) +
      (FCSDairy * 4) +
      (FCSPr * 4) +
      (FCSVeg * 1) +
      (FCSFruit * 1) +
      (FCSFat * 0.5) +
      (FCSSugar * 0.5)
  )
survey <- survey %>%
  mutate(
    FCS_category = case_when(
      FCS <= 28 ~ "Poor",
      FCS > 28 & FCS <= 42 ~ "Borderline",
      FCS > 42 ~ "Acceptable"
    ),
    FCS_category = factor(FCS_category, levels = c("Poor", "Borderline", "Acceptable"))
  )
survey <- survey %>%
  mutate(
    food_expenditure_share = (food_expenditure_syp / monthly_income_syp) * 100,
    
    food_share_category = case_when(
      food_expenditure_share < 50 ~ "Low (<50%)",
      food_expenditure_share >= 50 & food_expenditure_share <= 65 ~ "Medium (50-65%)",
      food_expenditure_share > 65 ~ "High (>65%)"
    ),
    food_share_category = factor(
      food_share_category,
      levels = c("Low (<50%)", "Medium (50-65%)", "High (>65%)")
    )
  )
survey <- survey %>%
  mutate(
    food_expenditure_share = if_else(
      food_expenditure_share > 100,
      100,
      food_expenditure_share
    )
  )
write_csv(survey, here("data", "processed", "syria_food_security_with_indicators.csv"))
"____________Save files_______________"
library(openxlsx)
write_csv(summary_by_governorate, here("data", "processed", "summary_by_governorate.csv"))
write_csv(summary_by_hh_type, here("data", "processed", "summary_by_hh_type.csv"))
write_csv(summary_by_gender, here("data", "processed", "summary_by_gender.csv"))
wb <- createWorkbook()
addWorksheet(wb, "Full Data")
writeData(wb, "Full Data", survey)
addWorksheet(wb, "By Governorate")
writeData(wb, "By Governorate", summary_by_governorate)
addWorksheet(wb, "By Household Type")
writeData(wb, "By Household Type", summary_by_hh_type)
addWorksheet(wb, "By Gender of Head")
writeData(wb, "By Gender of Head", summary_by_gender)
saveWorkbook(wb, here("outputs", "syria_food_security_analysis.xlsx"), overwrite = TRUE)
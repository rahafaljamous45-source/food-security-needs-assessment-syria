library(tidyverse)
library(janitor)
library(here)
library(naniar)
raw_data <- read_csv(here("data", "raw", "syria_food_security_survey_raw.csv"))
glimpse(raw_data)
dim(raw_data)
colSums(is.na(raw_data))
miss_var_summary(raw_data)
clean_data <- raw_data %>%
  mutate(
    monthly_income_syp = if_else(
      is.na(monthly_income_syp),
      median(monthly_income_syp, na.rm = TRUE),
      monthly_income_syp
    ),
    food_expenditure_syp = if_else(
      is.na(food_expenditure_syp),
      median(food_expenditure_syp, na.rm = TRUE),
      food_expenditure_syp
    ),
    household_size = if_else(
      is.na(household_size),
      median(household_size, na.rm = TRUE),
      household_size
    )
  )
clean_data <- clean_data %>%
  mutate(
    monthly_income_syp = if_else(
      monthly_income_syp > quantile(monthly_income_syp, 0.95, na.rm = TRUE),
      median(monthly_income_syp, na.rm = TRUE),
      monthly_income_syp
    ),
    household_size = if_else(
      household_size > 15,
      median(household_size, na.rm = TRUE),
      household_size
    )
  )
clean_data <- clean_data %>%
  mutate(
    governorate = str_to_title(str_trim(governorate)),
    household_type = str_to_title(str_trim(household_type)),
    female_headed = str_to_title(str_trim(female_headed)),
    household_type = if_else(household_type == "Idp", "IDP", household_type)
  )
if (!dir.exists(here("data", "processed"))) {
  dir.create(here("data", "processed"), recursive = TRUE)
}
write_csv(clean_data, here("data", "processed", "syria_food_security_survey_clean.csv"))
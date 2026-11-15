library(tidyverse)
library(here)
fcs_raw <- read_csv(here("data", "raw", "FCS_Sample_Survey.csv"))
getwd()
list.files("data/raw")
list.files("data/raw", full.names = TRUE)
list.files("data/raw", recursive = TRUE)
list.files(path = "data", recursive = TRUE, full.names = TRUE)
names(fcs_raw)
dim(fcs_raw)
n <- nrow(fcs_raw)
hh_id <- paste0("HH_", str_pad(1:n, 4, pad = 0))
governorates <- c(
  "Damascus", "Rural Damascus", "Aleppo", "Homs", "Hama",
  "Latakia", "Tartous", "Idleb", "Deir-ez-Zor", "Al-Hasakeh",
  "Ar-Raqqa", "Daraa", "As-Sweida", "Quneitra"
)
governorate <- sample(governorates, size = n, replace = TRUE)              
hh_types <- c("Resident", "IDP", "Returnee", "Refugee")
household_type <- sample(
  hh_types, 
  size = n, 
  replace = TRUE,
  prob = c(0.55, 0.25, 0.12, 0.08)   # نسب تقريبية واقعية
)
household_size <- sample(2:10, size = n, replace = TRUE)
monthly_income_syp <- round(rlnorm(n, meanlog = 14.6, sdlog = 0.65))
food_expenditure_syp <- round(monthly_income_syp * runif(n, min = 0.40, max = 0.80))
main_income_source <- sample(
  c("Daily labour", "Regular salary", "Agriculture", 
    "Trade/Business", "Remittances", "Humanitarian assistance"),
  size = n,
  replace = TRUE
)
female_headed <- sample(
  c("Yes", "No"),
  size = n,
  replace = TRUE,
  prob = c(0.23, 0.77)
)
interview_date <- sample(
  seq(as.Date("2025-01-10"), as.Date("2025-03-15"), by = "day"),
  size = n,
  replace = TRUE
)
extra_data <- tibble(
  hh_id = hh_id,
  governorate = governorate,
  household_type = household_type,
  household_size = household_size,
  monthly_income_syp = monthly_income_syp,
  food_expenditure_syp = food_expenditure_syp,
  main_income_source = main_income_source,
  female_headed = female_headed,
  interview_date = interview_date
)
survey_data <- bind_cols(extra_data, fcs_raw)
set.seed(2024)
survey_data <- survey_data %>%
  mutate(
    monthly_income_syp = if_else(runif(n()) < 0.07, NA_real_, monthly_income_syp),
    food_expenditure_syp = if_else(runif(n()) < 0.05, NA_real_, food_expenditure_syp),
    household_size = if_else(runif(n()) < 0.04, NA_real_, household_size)
  )
survey_data <- survey_data %>%
  mutate(
    monthly_income_syp = if_else(
      row_number() %in% sample(1:n(), 3),
      monthly_income_syp * 15,
      monthly_income_syp
    ),
    
    household_size = if_else(
      row_number() %in% sample(1:n(), 2),
      28,
      household_size
    )
  )
survey_data <- survey_data %>%
  mutate(
    governorate = case_when(
      row_number() %in% sample(1:n(), 5) ~ "damascus",
      row_number() %in% sample(1:n(), 4) ~ "Damascus ",
      row_number() %in% sample(1:n(), 3) ~ "DAMASCUS",
      TRUE ~ governorate
    ),
    
    household_type = case_when(
      row_number() %in% sample(1:n(), 4) ~ "idp",
      row_number() %in% sample(1:n(), 3) ~ "IDP ",
      TRUE ~ household_type
    ),
    
    female_headed = case_when(
      row_number() %in% sample(1:n(), 3) ~ "yes",
      row_number() %in% sample(1:n(), 2) ~ "YES",
      TRUE ~ female_headed
    )
  )
write_csv(survey_data, here("data", "raw", "syria_food_security_survey_raw.csv"))

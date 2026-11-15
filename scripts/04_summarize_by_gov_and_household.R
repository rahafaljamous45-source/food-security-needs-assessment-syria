summary_by_governorate <- survey %>%
  group_by(governorate) %>%
  summarise(
    n_households = n(),
    avg_FCS = mean(FCS, na.rm = TRUE),
    pct_poor = mean(FCS_category == "Poor", na.rm = TRUE) * 100,
    pct_borderline = mean(FCS_category == "Borderline", na.rm = TRUE) * 100,
    pct_acceptable = mean(FCS_category == "Acceptable", na.rm = TRUE) * 100,
    avg_food_share = mean(food_expenditure_share, na.rm = TRUE),
    avg_household_size = mean(household_size, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_FCS))
summary_by_hh_type <- survey %>%
  group_by(household_type) %>%
  summarise(
    n_households = n(),
    avg_FCS = mean(FCS, na.rm = TRUE),
    pct_poor = mean(FCS_category == "Poor", na.rm = TRUE) * 100,
    pct_acceptable = mean(FCS_category == "Acceptable", na.rm = TRUE) * 100,
    avg_food_share = mean(food_expenditure_share, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_FCS))
summary_by_gender <- survey %>%
  group_by(female_headed) %>%
  summarise(
    n_households = n(),
    avg_FCS = mean(FCS, na.rm = TRUE),
    avg_food_share = mean(food_expenditure_share, na.rm = TRUE)
  )
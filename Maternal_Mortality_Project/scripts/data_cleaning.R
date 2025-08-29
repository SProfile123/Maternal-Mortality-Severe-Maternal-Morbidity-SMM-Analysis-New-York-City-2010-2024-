

# Load required libraries
library(tidyverse)

# Load dataset
df <- read_csv("Pregnancy-Associated_Mortality.csv")

# Handle missing values
df <- df %>%
  drop_na(Year, `Race/ethnicity`) %>%
  mutate(Deaths = ifelse(is.na(Deaths), 0, Deaths))

# Standardize race categories
df <- df %>%
  mutate(`Race/ethnicity` = recode(`Race/ethnicity`,
    "Black, non-Hispanic" = "Black",
    "White, non-Hispanic" = "White",
    "Hispanic" = "Hispanic",
    "Asian/Pacific Islander" = "Asian/PI",
    .default = "Other/Unknown"
  ))

# Save cleaned dataset
write_csv(df, "maternal_mortality_clean.csv")

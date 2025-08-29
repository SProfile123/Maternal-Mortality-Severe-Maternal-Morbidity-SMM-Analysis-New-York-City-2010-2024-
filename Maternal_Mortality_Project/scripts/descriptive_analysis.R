

library(tidyverse)
library(ggplot2)

# Load cleaned dataset
df <- read_csv("maternal_mortality_clean.csv")

# Summary by race
race_summary <- df %>%
  group_by(`Race/ethnicity`) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm=TRUE))

# Summary by borough
borough_summary <- df %>%
  group_by(Borough) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm=TRUE))

# Save summary tables
write_csv(race_summary, "Race_Disparities_R.csv")
write_csv(borough_summary, "Borough_Disparities_R.csv")

# Plot: Deaths by Race over time
p1 <- ggplot(df, aes(x=Year, y=Deaths, color=`Race/ethnicity`)) +
  geom_line() + geom_point() +
  labs(title="Maternal Deaths by Race/Ethnicity (NYC, 2010–2024)",
       y="Number of Deaths") +
  theme_minimal()
ggsave("Deaths_by_Race_R.png", plot=p1, width=8, height=5, dpi=300)

# Plot: Deaths by Borough
p2 <- ggplot(borough_summary, aes(x=Borough, y=Total_Deaths)) +
  geom_col(fill="steelblue") +
  labs(title="Maternal Deaths by Borough", y="Total Deaths") +
  theme_minimal()
ggsave("Deaths_by_Borough_R.png", plot=p2, width=8, height=5, dpi=300)

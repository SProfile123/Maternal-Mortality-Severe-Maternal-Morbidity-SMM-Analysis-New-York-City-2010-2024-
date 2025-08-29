
library(tidyverse)
library(tidytext)
library(wordcloud)
library(RColorBrewer)

# Load cleaned dataset
df <- read_csv("maternal_mortality_clean.csv")

# Tokenize words from underlying causes
tokens <- df %>%
  unnest_tokens(word, Underlying_cause) %>%
  anti_join(stop_words)

# Count frequent terms
themes <- tokens %>%
  count(word, sort=TRUE) %>%
  filter(n > 5)

# Save qualitative themes
write_csv(themes, "Qualitative_Themes_R.csv")

# Generate word cloud
png("Underlying_Causes_WordCloud_R.png", width=1000, height=600)
set.seed(123)
wordcloud(words = themes$word, freq = themes$n, max.words=100,
          colors=brewer.pal(8, "Dark2"))
dev.off()

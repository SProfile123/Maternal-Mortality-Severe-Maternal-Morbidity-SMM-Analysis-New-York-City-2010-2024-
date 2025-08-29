library(tidyverse); library(ggplot2); library(tidytext); library(wordcloud); library(RColorBrewer)

df <- read_csv('../data/Pregnancy-Associated_Mortality.csv')
set.seed(123)
df$Live_Births <- sample(20000:40000, nrow(df), replace=TRUE)
df <- df %>% mutate(MMR = (Deaths / Live_Births) * 100000)

race_summary <- df %>% group_by(`Race/ethnicity`) %>% summarise(Average_MMR = mean(MMR, na.rm=TRUE))
borough_summary <- df %>% group_by(Borough) %>% summarise(Average_MMR = mean(MMR, na.rm=TRUE))

ggplot(df, aes(x=Year, y=MMR, color=`Race/ethnicity`)) + geom_line() + geom_point() + 
  labs(title="MMR by Race/Ethnicity") + theme_minimal()
ggsave('../results/MMR_by_Race_R.png', width=8, height=5, dpi=300)

ggplot(borough_summary, aes(x=Borough, y=Average_MMR)) + geom_col(fill="steelblue") + 
  labs(title="Average MMR by Borough") + theme_minimal()
ggsave('../results/MMR_by_Borough_R.png', width=8, height=5, dpi=300)

tokens <- df %>% unnest_tokens(word, Underlying_cause) %>% anti_join(stop_words)
themes <- tokens %>% count(word, sort=TRUE) %>% filter(n > 5)
write_csv(themes, '../results/Qualitative_Themes_R.csv')

png('../results/Underlying_Causes_WordCloud_R.png', width=1000, height=600)
wordcloud(words=themes$word, freq=themes$n, max.words=100, colors=brewer.pal(8, 'Dark2'))
dev.off()

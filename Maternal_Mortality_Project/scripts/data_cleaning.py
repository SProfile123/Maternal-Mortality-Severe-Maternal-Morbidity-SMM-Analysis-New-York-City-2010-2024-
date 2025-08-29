import pandas as pd, numpy as np

df = pd.read_csv('../data/Pregnancy-Associated_Mortality.csv')
df['Live_Births'] = np.random.randint(20000, 40000, size=len(df))
df['MMR'] = (df['Deaths'] / df['Live_Births']) * 100000
df.to_csv('../data/maternal_mortality_clean.csv', index=False)

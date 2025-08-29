import pandas as pd, seaborn as sns, matplotlib.pyplot as plt

df = pd.read_csv('../data/maternal_mortality_clean.csv')
race_summary = df.groupby("Race/ethnicity")["MMR"].mean().reset_index()
borough_summary = df.groupby("Borough")["MMR"].mean().reset_index()

sns.lineplot(data=df, x="Year", y="MMR", hue="Race/ethnicity", marker="o")
plt.title("MMR by Race/Ethnicity"); plt.savefig('../results/MMR_by_Race_Py.png'); plt.clf()

sns.barplot(data=borough_summary, x="Borough", y="MMR")
plt.title("Average MMR by Borough"); plt.savefig('../results/MMR_by_Borough_Py.png')

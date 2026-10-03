from pathlib import Path
import numpy as np, pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

df=pd.read_csv(Path("../data/customer_data_clean.csv"))
def pct_rank(s): return s.rank(pct=True,method="average")
df["financial_capacity"]=0.55*pct_rank(np.log1p(df["annual_income"]))+0.30*pct_rank(np.log1p(df["account_balance"]))+0.15*pct_rank(np.log1p(df["investment_amount"]))
df["engagement"]=0.45*pct_rank(np.log1p(df["monthly_transaction_count"]))+0.25*pct_rank(np.log1p(df["monthly_transaction_amount"]))+0.15*df["digital_transaction_ratio"]+0.10*(1-pct_rank(df["months_inactive_12_mon"]))+0.05*pct_rank(df["total_relationship_count"])
df["credit_dependence"]=0.40*pct_rank(df["credit_utilization_ratio"])+0.35*pct_rank(np.log1p(df["loan_amount"]))+0.25*pct_rank(df["emi_to_monthly_income_ratio"].clip(0,3))
df["digital_behavior"]=0.70*df["digital_transaction_ratio"]+0.30*df["upi_transaction_share"]
cols=["financial_capacity","engagement","credit_dependence","digital_behavior"]
X=StandardScaler().fit_transform(df[cols])*np.sqrt(np.array([0.35,0.30,0.20,0.15]))
model=KMeans(n_clusters=4,n_init=20,random_state=42)
df["segment_id"]=model.fit_predict(X)+1
profiles=df.groupby("segment_id")[cols].mean()
# Post-fit, unique names based on observed profiles.
a=profiles["financial_capacity"].idxmax(); names={a:"Affluent Under-Engaged"}
rem=[x for x in profiles.index if x not in names]
d=max(rem,key=lambda s: profiles.loc[s,"digital_behavior"]+profiles.loc[s,"engagement"]); names[d]="Digital Active"
rem=[x for x in profiles.index if x not in names]
c=max(rem,key=lambda s: profiles.loc[s,"credit_dependence"]); names[c]="Credit Active"
rem=[x for x in profiles.index if x not in names]; names[rem[0]]="Prime Engaged"
df["segment_name"]=df["segment_id"].map(names)
df.to_csv("../outputs/customer_segments_powerbi.csv",index=False)
print(df["segment_name"].value_counts())

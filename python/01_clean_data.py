from pathlib import Path
import pandas as pd, numpy as np

raw=Path("../data/raw_source_copy.csv")
out=Path("../data/customer_data_clean.csv")
df=pd.read_csv(raw)
df.columns=(df.columns.str.strip().str.lower().str.replace(r"[^a-z0-9]+","_",regex=True).str.strip("_"))
for c in df.select_dtypes(include=np.number).columns:
    df[c]=pd.to_numeric(df[c],errors="coerce")
    if df[c].isna().any(): df[c]=df[c].fillna(df[c].median())
for c in df.select_dtypes(exclude=np.number).columns:
    if df[c].isna().any(): df[c]=df[c].fillna("Unknown")
df=df.drop_duplicates().reset_index(drop=True)
df["monthly_income"]=df["annual_income"]/12
df["loan_to_income_ratio"]=(df["loan_amount"]/df["annual_income"]).replace([np.inf,-np.inf],np.nan).fillna(0).clip(0,10)
df["emi_to_monthly_income_ratio"]=(df["emi_amount"]/df["monthly_income"]).replace([np.inf,-np.inf],np.nan).fillna(0).clip(0,5)
df["card_spend_share"]=(df["credit_card_spend"]/df["monthly_transaction_amount"]).replace([np.inf,-np.inf],np.nan).fillna(0).clip(0,1)
df["investment_to_income_ratio"]=(df["investment_amount"]/df["annual_income"]).replace([np.inf,-np.inf],np.nan).fillna(0).clip(0,10)
df["balance_to_income_ratio"]=(df["account_balance"]/df["annual_income"]).replace([np.inf,-np.inf],np.nan).fillna(0).clip(0,10)
df["engagement_recency_score"]=(1-df["months_inactive_12_mon"]/12).clip(0,1)
df.to_csv(out,index=False)
print(out)

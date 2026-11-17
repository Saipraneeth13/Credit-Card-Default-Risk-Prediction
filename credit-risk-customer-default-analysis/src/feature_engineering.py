"""
src/feature_engineering.py
Phase 3: Domain-Driven Credit Risk Feature Engineering.
"""
import os
import numpy as np
import pandas as pd


def engineer_features(df: pd.DataFrame) -> pd.DataFrame:
    """Create behavioral, utilization, and delinquency aggregation features."""
    df_feat = df.copy()

    bill_cols = ["BILL_AMT1", "BILL_AMT2", "BILL_AMT3", "BILL_AMT4", "BILL_AMT5", "BILL_AMT6"]
    pay_amt_cols = ["PAY_AMT1", "PAY_AMT2", "PAY_AMT3", "PAY_AMT4", "PAY_AMT5", "PAY_AMT6"]
    pay_stat_cols = ["PAY_1", "PAY_2", "PAY_3", "PAY_4", "PAY_5", "PAY_6"]

    df_feat["Total_Bill_Amount"] = df_feat[bill_cols].sum(axis=1)
    df_feat["Average_Bill_Amount"] = df_feat[bill_cols].mean(axis=1).round(2)
    df_feat["Total_Payment_Amount"] = df_feat[pay_amt_cols].sum(axis=1)
    df_feat["Average_Payment_Amount"] = df_feat[pay_amt_cols].mean(axis=1).round(2)
    df_feat["Maximum_Delay_Status"] = df_feat[pay_stat_cols].max(axis=1)
    df_feat["Delayed_Payment_Count"] = (df_feat[pay_stat_cols] > 0).sum(axis=1)
    df_feat["Average_Repayment_Status"] = df_feat[pay_stat_cols].mean(axis=1).round(3)

    # Safe Payment-to-Bill Ratio (guards against zero or negative net bills)
    pos_bill = df_feat["Total_Bill_Amount"].clip(lower=0)
    df_feat["Payment_to_Bill_Ratio"] = np.where(
        pos_bill > 0,
        np.clip(df_feat["Total_Payment_Amount"] / pos_bill, 0, 5.0),
        np.where(df_feat["Total_Payment_Amount"] > 0, 1.0, 0.0)
    ).round(4)

    # Credit Utilization Ratio (Most recent statement balance / Credit Limit)
    df_feat["Credit_Utilization_Ratio"] = np.where(
        df_feat["LIMIT_BAL"] > 0,
        df_feat["BILL_AMT1"] / df_feat["LIMIT_BAL"],
        0.0
    ).round(4)

    # 6-month balance trajectory (September minus April)
    df_feat["Bill_Trend_Change"] = df_feat["BILL_AMT1"] - df_feat["BILL_AMT6"]

    # Analytical segments
    df_feat["Age_Group"] = pd.cut(
        df_feat["AGE"], bins=[20, 29, 39, 49, 59, 100],
        labels=["21-29", "30-39", "40-49", "50-59", "60+"]
    ).astype(str)

    df_feat["Credit_Limit_Tier"] = pd.cut(
        df_feat["LIMIT_BAL"], bins=[0, 50000, 150000, 300000, 10000000],
        labels=["Low (<=50K)", "Medium (50K-150K)", "High (150K-300K)", "Premium (>300K)"]
    ).astype(str)

    return df_feat


if __name__ == "__main__":
    df_clean = pd.read_csv("data/processed/credit_card_default_cleaned.csv")
    df_feat = engineer_features(df_clean)
    df_feat.to_csv("data/processed/credit_card_default_features.csv", index=False)
    print(f"Engineered features saved: {df_feat.shape}")

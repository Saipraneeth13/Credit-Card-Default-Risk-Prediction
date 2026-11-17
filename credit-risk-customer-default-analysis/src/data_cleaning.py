"""
src/data_cleaning.py
Phase 1: Data Standardization, Undocumented Code Consolidation, and Quality Assertions.
"""
import os
import pandas as pd
from src.data_loader import load_raw_excel


def clean_credit_data(df: pd.DataFrame) -> pd.DataFrame:
    """Clean raw credit card default records without dropping valid behavioral codes."""
    df_clean = df.copy()

    # Standardize column names
    df_clean = df_clean.rename(columns={
        "PAY_0": "PAY_1",
        "default payment next month": "DEFAULT_NEXT_MONTH"
    })

    # Consolidate undocumented EDUCATION codes (0, 5, 6 -> 4 'Other')
    df_clean["EDUCATION"] = df_clean["EDUCATION"].replace({0: 4, 5: 4, 6: 4})

    # Consolidate undocumented MARRIAGE code (0 -> 3 'Other')
    df_clean["MARRIAGE"] = df_clean["MARRIAGE"].replace({0: 3})

    # Add human-readable category labels for BI and EDA
    df_clean["SEX_LABEL"] = df_clean["SEX"].map({1: "Male", 2: "Female"})
    df_clean["EDUCATION_LABEL"] = df_clean["EDUCATION"].map({
        1: "Graduate School", 2: "University", 3: "High School", 4: "Other"
    })
    df_clean["MARRIAGE_LABEL"] = df_clean["MARRIAGE"].map({
        1: "Married", 2: "Single", 3: "Other"
    })

    # Integrity checks
    assert df_clean.shape == (30000, 28), f"Unexpected shape: {df_clean.shape}"
    assert df_clean.isnull().sum().sum() == 0, "Null values detected after cleaning"
    assert df_clean["ID"].nunique() == 30000, "Duplicate IDs detected"

    return df_clean


if __name__ == "__main__":
    raw_df = load_raw_excel()
    cleaned_df = clean_credit_data(raw_df)
    os.makedirs("data/processed", exist_ok=True)
    cleaned_df.to_csv("data/processed/credit_card_default_cleaned.csv", index=False)
    print("Saved data/processed/credit_card_default_cleaned.csv")

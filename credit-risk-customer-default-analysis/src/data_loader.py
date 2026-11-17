"""
src/data_loader.py
Utility module to ingest the raw Excel dataset and validate workbook schema.
"""
import pandas as pd


def load_raw_excel(filepath: str = "data/raw/default of credit card clients.xls") -> pd.DataFrame:
    """Inspect sheet names and load the 'Data' sheet using row index 1 as column headers."""
    xls = pd.ExcelFile(filepath)
    if "Data" not in xls.sheet_names:
        raise ValueError(f"Expected sheet 'Data', found {xls.sheet_names}")
    df = pd.read_excel(filepath, sheet_name="Data", header=1)
    if df.shape != (30000, 25):
        raise ValueError(f"Expected shape (30000, 25), got {df.shape}")
    return df


if __name__ == "__main__":
    data = load_raw_excel()
    print(f"Loaded raw dataset successfully: {data.shape}")

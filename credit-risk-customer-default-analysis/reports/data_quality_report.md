# Data Quality & Schema Validation Report

- **Source File:** `default of credit card clients.xls` (Sheet: `Data`, Header Row: Index `1`).
- **Dimensions:** `30,000` customer rows $\times$ `25` original columns (`28` after adding human-readable labels).
- **Missing Values & Duplicates:** `0` missing values; `0` duplicate `ID`s.
- **Categorical Standardization:**
  - `PAY_0` renamed to `PAY_1` for alignment with `BILL_AMT1..6` and `PAY_AMT1..6`.
  - `EDUCATION`: Undocumented codes `0` (14), `5` (280), and `6` (51) consolidated into `4` (`Other`, total 468).
  - `MARRIAGE`: Undocumented code `0` (54) consolidated into `3` (`Other`, total 377).
  - Negative `PAY_1..6` (`-2` inactive, `-1` paid in full) and negative `BILL_AMT` (credit balances) preserved as valid banking states.

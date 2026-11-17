# Credit Risk & Customer Default Analysis

An end-to-end banking and financial services data analytics portfolio project analyzing credit card repayment behavior, customer default drivers, SQL risk segmentation, statistical hypothesis testing, predictive machine learning, and Power BI executive reporting.

## Business Objective
Analyze 30,000 credit card client records to uncover behavioral and financial drivers of next-month payment default, build a leak-free predictive risk model, and deliver actionable risk mitigation recommendations.

## Key Empirical Findings
- **Overall Portfolio Default Rate:** **22.12%** (6,636 defaults out of 30,000 clients).
- **Recent Repayment Status (`PAY_1`):** Clients current in September default at **12.8%–16.8%**, whereas clients 1 month delayed jump to **33.9%**, and clients 2+ months delayed surge to **69.1%–75.8%**.
- **Repeat Delinquency:** Default rate climbs from **11.7%** (0 delayed months) to **50.9%** (3 delayed months) and **70.3%** (6 delayed months).
- **Credit Limit & Utilization:** Defaulters have significantly lower credit limits (**NT$ 130,110** vs **NT$ 178,100**, $p < 0.0001$) and higher credit utilization (**49.0%** vs **40.5%**, $p < 0.0001$).
- **Champion Predictive Model:** Gradient Boosting (excluding sensitive demographic attribute `SEX`) achieved **0.7815 ROC-AUC** and **0.5572 PR-AUC**, capturing **48.8% recall** at **57.5% precision** using a risk-calibrated `0.35` probability threshold.

## Repository Structure
```text
credit-risk-customer-default-analysis/
├── data/
│   ├── raw/                  # Original Excel workbook
│   ├── processed/            # Cleaned & feature-engineered CSV datasets
│   └── exports/              # Power BI scored dataset & model metrics
├── notebooks/                # 6 sequential Jupyter notebooks (01 to 06)
├── sql/                      # MySQL schema, data quality checks, and 20 risk queries
├── dashboard/                # Power BI DAX measures & 4-page layout guide
├── src/                      # Modular Python pipeline scripts
├── models/                   # Serialized Gradient Boosting pipeline (.joblib)
├── reports/                  # Data quality, business insights, model evaluation & charts
├── requirements.txt
├── .gitignore
└── README.md
```

## How to Reproduce
```bash
pip install -r requirements.txt
python -m src.data_cleaning
python -m src.feature_engineering
python -m src.evaluation
```

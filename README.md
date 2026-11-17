# Credit Risk & Customer Default Analysis

An end-to-end banking and financial services data analytics portfolio project analyzing credit card repayment behavior, customer default drivers, SQL risk segmentation, statistical hypothesis testing, predictive machine learning, and Power BI executive reporting.

## Business Objective

Analyze 30,000 credit card client records to uncover behavioral and financial drivers of next-month payment default, build a leak-free predictive risk model, and deliver actionable risk mitigation recommendations.

## Key Empirical Findings

* **Overall Portfolio Default Rate:** **22.12%** (6,636 defaults out of 30,000 clients).
* **Recent Repayment Status (`PAY_1`):** Clients current in September default at **12.8%–16.8%**, whereas clients 1 month delayed jump to **33.9%**, and clients 2+ months delayed surge to **69.1%–75.8%**.
* **Repeat Delinquency:** Default rate climbs from **11.7%** (0 delayed months) to **50.9%** (3 delayed months) and **70.3%** (6 delayed months).
* **Credit Limit & Utilization:** Defaulters have significantly lower credit limits (**NT\$ 130,110** vs **NT\$ 178,100**, $p < 0.0001$) and higher credit utilization (**49.0%** vs **40.5%**, $p < 0.0001$).
* **Champion Predictive Model:** Gradient Boosting (excluding sensitive demographic attribute `SEX`) achieved **0.7815 ROC-AUC** and **0.5572 PR-AUC**, capturing **48.8% recall** at **57.5% precision** using a risk-calibrated `0.35` probability threshold.

## Exploratory Data Analysis & Visual Results

### 1. Primary Drivers of Credit Default

![Primary Drivers of Credit Default](reports/figures/01_eda_key_drivers.png)

* **Portfolio & Credit Limits:** Out of 30,000 clients, 22.12% defaulted. Default risk drops sharply as credit limits rise—from **31.8%** in the Low tier ($\le\text{NT\$ }50\text{K}$) down to **13.3%** in the Premium tier ($>\text{NT\$ }300\text{K}$).
* **Delinquency Escalation:** A single missed payment in September (`PAY_1 = 1`) more than doubles default risk to **33.9%**, while 2–3 months of consecutive delay (`PAY_1 = 2` or `3`) pushes default rates above **69%**. Repeated delinquency across the 6-month window compounds risk steadily from **11.7%** (0 delayed months) to **70.3%** (all 6 months delayed).

### 2. Six-Month Billing & Payment Trajectories (April–September)

![Six-Month Billing and Payment Trajectories](reports/figures/02_six_month_trends.png)

* **Balance Growth vs. Payment Stagnation:** Both segments experienced rising statement balances from April to September, yet non-defaulters scaled their monthly payments upward (from NT\$ 5,713 to NT\$ 6,300) to service the debt, whereas defaulters' payments stagnated flat between **NT\$ 3,150 and NT\$ 3,450/month**.

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
├── reports/
│   ├── figures/              # High-resolution EDA & trend visualizations
│   ├── data_quality_report.md
│   ├── business_insights.md
│   └── model_evaluation.md
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

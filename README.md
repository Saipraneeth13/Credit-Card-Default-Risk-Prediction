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

![Primary Drivers of Credit Default]




* **Portfolio & Credit Limits:** Out of 30,000 clients, 22.12% defaulted. Default risk drops sharply as credit limits rise—from **31.8%** in the Low tier ($\le\text{NT\$ }50\text{K}$) down to **13.3%** in the Premium tier ($>\text{NT\$ }300\text{K}$).
* **Delinquency Escalation:** A single missed payment in September (`PAY_1 = 1`) more than doubles default risk to **33.9%**, while 2–3 months of consecutive delay (`PAY_1 = 2` or `3`) pushes default rates above **69%**. Repeated delinquency across the 6-month window compounds risk steadily from **11.7%** (0 delayed months) to **70.3%** (all 6 months delayed).

### 2. Six-Month Billing & Payment Trajectories (April–September)

![Six-Month Billing and Payment Trajectories](reports/figures/02_six_month_trends.png)

* **Balance Growth vs. Payment Stagnation:** Both segments experienced rising statement balances from April to September, yet non-defaulters scaled their monthly payments upward (from NT\$ 5,713 to NT\$ 6,300) to service the debt, whereas defaulters' payments stagnated flat between **NT\$ 3,150 and NT\$ 3,450/month**.

## Power BI Executive Dashboard

A 4-page Power BI report built on the scored dataset (`data/exports/powerbi_credit_risk_dataset.csv`). The DAX measures are in [`dashboard/dax_measures.md`](dashboard/dax_measures.md) and the page-by-page layout is in [`dashboard/dashboard_guide.md`](dashboard/dashboard_guide.md).

**Data model:** the scored dataset is loaded as `credit_risk`, alongside two standalone reference tables, `model_feature_importance` and `model_comparison_metrics`.

**Global slicers on every page:** `Credit_Limit_Tier`, `EDUCATION_LABEL`, `MARRIAGE_LABEL`, `Age_Group`, `Risk_Tier`.

### Page 1: Executive Overview

![Page 1 - Executive Overview](reports/figures/dashboard_page1_executive_overview.png)

* **KPI cards:** 30,000 total customers, 6,636 defaults, 23,364 non-defaults, a 22.12% overall default rate, and an average credit limit of NT\$ 167,484.
* **Visuals:** Default vs. non-default donut chart, plus default rate by age group, credit limit tier, education, and marital status.

### Page 2: Customer & Credit Analysis

![Page 2 - Customer & Credit Analysis](reports/figures/dashboard_page2_customer_credit.png)

* Credit limit tier distribution and the relationship between credit utilization and default rate.
* Average payment-to-bill ratio KPI (0.38) and a total current exposure matrix across customer segments.

### Page 3: Repayment Behaviour

![Page 3 - Repayment Behaviour](reports/figures/dashboard_page3_repayment_behaviour.png)

* Default rate by delayed payment count, escalating from **11.7%** at 0 delays to **70.3%** at 6 delays.
* Six-month `BILL_AMT` and `PAY_AMT` trends split by default status.

### Page 4: Risk & Model Insights

![Page 4 - Risk & Model Insights](reports/figures/dashboard_page4_risk_model_insights.png)

* Customer count by `Risk_Tier`.
* Confusion matrix (`DEFAULT_NEXT_MONTH` vs. `Predicted_Default_Flag`) at the `0.35` threshold, with model recall and precision measures.
* Model comparison table and the top 10 features by importance.

### Core DAX Measures

| Measure | Definition |
|---|---|
| `Total Customers` | `DISTINCTCOUNT(credit_risk[ID])` |
| `Default Customers` | Distinct customers where `DEFAULT_NEXT_MONTH = 1` |
| `Overall Default Rate` | `DIVIDE([Default Customers], [Total Customers], 0)` |
| `Average Credit Limit` | `AVERAGE(credit_risk[LIMIT_BAL])` |
| `Total Current Exposure` | `SUM(credit_risk[BILL_AMT1])` |
| `Average Utilization Ratio` | `AVERAGE(credit_risk[Credit_Utilization_Ratio])` |
| `Average Payment to Bill Ratio` | `AVERAGE(credit_risk[Payment_to_Bill_Ratio])` |
| `Model Recall` / `Model Precision` | Derived from TP, FP, FN counts at the 0.35 threshold |

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
│   └── generate_dashboard_images.py   # Renders the 4 dashboard pages as PNGs
├── models/                   # Serialized Gradient Boosting pipeline (.joblib)
├── reports/
│   ├── figures/              # EDA, trend, and dashboard visualizations
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
python -m src.generate_dashboard_images
```

The last command reads the three CSVs in `data/exports/` and saves the four dashboard page images to `reports/figures/`.

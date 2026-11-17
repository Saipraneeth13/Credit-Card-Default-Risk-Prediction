# Power BI 4-Page Dashboard Architecture Guide

## Data Import
1. Import `data/exports/powerbi_credit_risk_dataset.csv` as table `credit_risk`.
2. Import `data/exports/model_feature_importance.csv` and `data/exports/model_comparison_metrics.csv` as standalone reference tables.
3. Add global slicers on all pages: `Credit_Limit_Tier`, `EDUCATION_LABEL`, `MARRIAGE_LABEL`, `Age_Group`, and `Risk_Tier`.

## Page 1: Executive Overview
- **Top KPI Cards:** `Total Customers` (30,000), `Default Customers` (6,636), `Non-Default Customers` (23,364), `Overall Default Rate` (22.12%), `Average Credit Limit` (NT$ 167,484).
- **Visuals:** Donut Chart (Default vs Non-Default), Clustered Bar Charts for `Overall Default Rate` by `Age_Group`, `Credit_Limit_Tier`, `EDUCATION_LABEL`, and `MARRIAGE_LABEL`.

## Page 2: Customer & Credit Analysis
- **Visuals:** Histogram/Column Chart of `Credit_Limit_Tier`, Scatter/Bar of `Average Utilization Ratio` vs `Overall Default Rate`, KPI Card for `Average Payment to Bill Ratio` (0.38), Matrix comparing `Total Current Exposure` across segments.

## Page 3: Repayment Behaviour
- **Visuals:** Clustered Column Chart of `Delayed_Payment_Count` (0 to 6 months) vs `Overall Default Rate` (escalating from 11.7% at 0 delays to 70.3% at 6 delays); Line Charts comparing 6-month `BILL_AMT` and `PAY_AMT` trends split by `DEFAULT_NEXT_MONTH`.

## Page 4: Risk & Model Insights
- **Visuals:** Bar Chart of customer count by `Risk_Tier`; Matrix displaying Confusion Matrix (`DEFAULT_NEXT_MONTH` vs `Predicted_Default_Flag`); Table of `model_comparison_metrics`; Horizontal Bar Chart of Top 10 `model_feature_importance`.

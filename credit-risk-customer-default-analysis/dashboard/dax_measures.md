# Power BI DAX Measures (`powerbi_credit_risk_dataset.csv`)

## Core KPI Measures
```dax
Total Customers = DISTINCTCOUNT(credit_risk[ID])

Default Customers = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[DEFAULT_NEXT_MONTH] = 1)

Non-Default Customers = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[DEFAULT_NEXT_MONTH] = 0)

Overall Default Rate = DIVIDE([Default Customers], [Total Customers], 0)

Average Credit Limit = AVERAGE(credit_risk[LIMIT_BAL])

Total Current Exposure = SUM(credit_risk[BILL_AMT1])

Average Utilization Ratio = AVERAGE(credit_risk[Credit_Utilization_Ratio])

Average Payment to Bill Ratio = AVERAGE(credit_risk[Payment_to_Bill_Ratio])
```

## Predictive Model & Confusion Matrix Measures (Threshold = 0.35)
```dax
Predicted Default Customers = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[Predicted_Default_Flag] = 1)

True Positives (TP) = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[DEFAULT_NEXT_MONTH] = 1, credit_risk[Predicted_Default_Flag] = 1)

False Positives (FP) = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[DEFAULT_NEXT_MONTH] = 0, credit_risk[Predicted_Default_Flag] = 1)

False Negatives (FN) = CALCULATE(DISTINCTCOUNT(credit_risk[ID]), credit_risk[DEFAULT_NEXT_MONTH] = 1, credit_risk[Predicted_Default_Flag] = 0)

Model Recall = DIVIDE([True Positives (TP)], [True Positives (TP)] + [False Negatives (FN)], 0)

Model Precision = DIVIDE([True Positives (TP)], [True Positives (TP)] + [False Positives (FP)], 0)
```

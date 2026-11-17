-- sql/business_analysis.sql
-- 20 Business Intelligence & Credit Risk SQL Queries (MySQL 8.0+)

USE credit_risk_db;

-- Q1. Total Customers
SELECT COUNT(*) AS total_customers FROM credit_card_clients;

-- Q2. Total Default Customers
SELECT SUM(DEFAULT_NEXT_MONTH) AS total_default_customers FROM credit_card_clients;

-- Q3. Overall Default Percentage
SELECT
    COUNT(*) AS total_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_customers,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS overall_default_rate_pct
FROM credit_card_clients;

-- Q4. Default Rate by Education Level
SELECT
    EDUCATION_LABEL,
    COUNT(*) AS total_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY EDUCATION_LABEL
ORDER BY default_rate_pct DESC;

-- Q5. Default Rate by Marital Status
SELECT
    MARRIAGE_LABEL,
    COUNT(*) AS total_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY MARRIAGE_LABEL
ORDER BY default_rate_pct DESC;

-- Q6. Default Rate by Age Group
SELECT
    Age_Group,
    COUNT(*) AS total_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY Age_Group
ORDER BY Age_Group;

-- Q7. Default Rate by Credit Limit Range
SELECT
    Credit_Limit_Tier,
    COUNT(*) AS total_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY Credit_Limit_Tier
ORDER BY default_rate_pct DESC;

-- Q8. Average Credit Limit by Default Status
SELECT
    CASE WHEN DEFAULT_NEXT_MONTH = 1 THEN 'Default' ELSE 'Non-Default' END AS default_status,
    COUNT(*) AS customer_count,
    ROUND(AVG(LIMIT_BAL), 2) AS avg_credit_limit
FROM credit_card_clients
GROUP BY DEFAULT_NEXT_MONTH;

-- Q9. Average 6-Month Bill Amount by Default Status
SELECT
    CASE WHEN DEFAULT_NEXT_MONTH = 1 THEN 'Default' ELSE 'Non-Default' END AS default_status,
    ROUND(AVG(Average_Bill_Amount), 2) AS avg_monthly_bill,
    ROUND(AVG(Total_Bill_Amount), 2) AS avg_6m_total_bill
FROM credit_card_clients
GROUP BY DEFAULT_NEXT_MONTH;

-- Q10. Average 6-Month Payment Amount by Default Status
SELECT
    CASE WHEN DEFAULT_NEXT_MONTH = 1 THEN 'Default' ELSE 'Non-Default' END AS default_status,
    ROUND(AVG(Average_Payment_Amount), 2) AS avg_monthly_payment,
    ROUND(AVG(Total_Payment_Amount), 2) AS avg_6m_total_payment
FROM credit_card_clients
GROUP BY DEFAULT_NEXT_MONTH;

-- Q11. Customers with Any Delayed Repayment in the Last 6 Months
SELECT
    CASE WHEN Delayed_Payment_Count > 0 THEN 'Has Delay' ELSE 'No Delay' END AS delay_history,
    COUNT(*) AS customer_count,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY CASE WHEN Delayed_Payment_Count > 0 THEN 'Has Delay' ELSE 'No Delay' END;

-- Q12. Customers with Repeated Delayed Payments (3 or more months delayed)
SELECT
    Delayed_Payment_Count,
    COUNT(*) AS customer_count,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
WHERE Delayed_Payment_Count >= 3
GROUP BY Delayed_Payment_Count
ORDER BY Delayed_Payment_Count;

-- Q13. Customers with High Outstanding Balances (Utilization > 80%)
SELECT
    CASE WHEN Credit_Utilization_Ratio > 0.80 THEN 'High Utilization (>80%)' ELSE 'Normal Utilization (<=80%)' END AS util_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY CASE WHEN Credit_Utilization_Ratio > 0.80 THEN 'High Utilization (>80%)' ELSE 'Normal Utilization (<=80%)' END;

-- Q14. Payment-to-Bill Ratio Bucket Analysis
WITH ratio_buckets AS (
    SELECT
        ID,
        DEFAULT_NEXT_MONTH,
        CASE
            WHEN Payment_to_Bill_Ratio = 0 THEN '0% (No Payment)'
            WHEN Payment_to_Bill_Ratio < 0.10 THEN '1% - 10% (Minimum Payers)'
            WHEN Payment_to_Bill_Ratio < 0.50 THEN '10% - 50% (Partial Payers)'
            ELSE '50%+ (Heavy/Full Payers)'
        END AS payment_behavior
    FROM credit_card_clients
)
SELECT
    payment_behavior,
    COUNT(*) AS customer_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM ratio_buckets
GROUP BY payment_behavior
ORDER BY default_rate_pct DESC;

-- Q15. Default Rate by Maximum Repayment Delay Status
SELECT
    Maximum_Delay_Status,
    COUNT(*) AS customer_count,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
FROM credit_card_clients
GROUP BY Maximum_Delay_Status
ORDER BY Maximum_Delay_Status;

-- Q16. Customer Segmentation by Credit Limit & Utilization
SELECT
    Credit_Limit_Tier,
    COUNT(*) AS customers,
    ROUND(AVG(LIMIT_BAL), 0) AS avg_limit,
    ROUND(AVG(Credit_Utilization_Ratio) * 100, 2) AS avg_utilization_pct
FROM credit_card_clients
GROUP BY Credit_Limit_Tier
ORDER BY avg_limit;

-- Q17. Default Distribution Share Across Credit Limit Segments (Window Function)
SELECT
    Credit_Limit_Tier,
    SUM(DEFAULT_NEXT_MONTH) AS segment_defaults,
    ROUND(SUM(DEFAULT_NEXT_MONTH) * 100.0 / SUM(SUM(DEFAULT_NEXT_MONTH)) OVER (), 2) AS pct_of_all_defaults
FROM credit_card_clients
GROUP BY Credit_Limit_Tier
ORDER BY segment_defaults DESC;

-- Q18. High-Risk Customer Profile Analysis (Delayed >= 2 months AND Utilization > 75%)
SELECT
    COUNT(*) AS high_risk_customers,
    SUM(DEFAULT_NEXT_MONTH) AS default_count,
    ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct,
    ROUND(SUM(BILL_AMT1), 2) AS total_current_exposure
FROM credit_card_clients
WHERE Delayed_Payment_Count >= 2
  AND Credit_Utilization_Ratio > 0.75;

-- Q19. Ranking Education x Credit Limit Segments by Default Rate (CTE + RANK Window Function)
WITH segment_stats AS (
    SELECT
        EDUCATION_LABEL,
        Credit_Limit_Tier,
        COUNT(*) AS customer_count,
        ROUND(AVG(DEFAULT_NEXT_MONTH) * 100, 2) AS default_rate_pct
    FROM credit_card_clients
    GROUP BY EDUCATION_LABEL, Credit_Limit_Tier
    HAVING COUNT(*) >= 100
)
SELECT
    RANK() OVER (ORDER BY default_rate_pct DESC) AS risk_rank,
    EDUCATION_LABEL,
    Credit_Limit_Tier,
    customer_count,
    default_rate_pct
FROM segment_stats;

-- Q20. Six-Month Delinquency Progression Comparison
SELECT
    'Month 6 (Apr)' AS billing_month, ROUND(AVG(CASE WHEN PAY_6 > 0 THEN 1 ELSE 0 END) * 100, 2) AS pct_delayed, ROUND(AVG(BILL_AMT6), 2) AS avg_bill, ROUND(AVG(PAY_AMT6), 2) AS avg_payment FROM credit_card_clients
UNION ALL
SELECT 'Month 5 (May)', ROUND(AVG(CASE WHEN PAY_5 > 0 THEN 1 ELSE 0 END) * 100, 2), ROUND(AVG(BILL_AMT5), 2), ROUND(AVG(PAY_AMT5), 2) FROM credit_card_clients
UNION ALL
SELECT 'Month 4 (Jun)', ROUND(AVG(CASE WHEN PAY_4 > 0 THEN 1 ELSE 0 END) * 100, 2), ROUND(AVG(BILL_AMT4), 2), ROUND(AVG(PAY_AMT4), 2) FROM credit_card_clients
UNION ALL
SELECT 'Month 3 (Jul)', ROUND(AVG(CASE WHEN PAY_3 > 0 THEN 1 ELSE 0 END) * 100, 2), ROUND(AVG(BILL_AMT3), 2), ROUND(AVG(PAY_AMT3), 2) FROM credit_card_clients
UNION ALL
SELECT 'Month 2 (Aug)', ROUND(AVG(CASE WHEN PAY_2 > 0 THEN 1 ELSE 0 END) * 100, 2), ROUND(AVG(BILL_AMT2), 2), ROUND(AVG(PAY_AMT2), 2) FROM credit_card_clients
UNION ALL
SELECT 'Month 1 (Sep)', ROUND(AVG(CASE WHEN PAY_1 > 0 THEN 1 ELSE 0 END) * 100, 2), ROUND(AVG(BILL_AMT1), 2), ROUND(AVG(PAY_AMT1), 2) FROM credit_card_clients;
